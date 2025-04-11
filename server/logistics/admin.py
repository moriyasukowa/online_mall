from django.contrib import admin
from django.forms import ValidationError
from .models import ProcurementOrder, OutboundOrder, PurchaseOrder, LogisticsOrder, PurchaseOrderItem, StockInOrder, ProcurementOrderItem
from django.contrib import admin
from django.http import HttpResponseRedirect, JsonResponse
from django.utils.html import format_html
from django.contrib import messages
from django.urls import path, reverse
from django.utils import timezone
from django.contrib.admin import DateFieldListFilter
from rangefilter.filters import DateRangeFilter


class ProcurementOrderItemInline(admin.TabularInline):
    model = ProcurementOrderItem
    extra = 1
    fields = ('commodity', 'unit_price', 'quantity')
    autocomplete_fields = ['commodity']
    search_fields = ['commodity']
    min_num = 1
    verbose_name = '订单商品项'
    verbose_name_plural = '订单商品项'
    class Media:
        css = {
            'all': (
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/autocomplete2.js',
        )
    def get_formset(self, request, obj=None, **kwargs):
        formset = super().get_formset(request, obj, **kwargs)
        formset.form.base_fields['commodity'].widget.can_add_related = False
        formset.form.base_fields['commodity'].widget.can_change_related = False
        return formset


    
@admin.register(ProcurementOrder)
class ProcurementOrderAdmin(admin.ModelAdmin):
    class Media:
        css = {'all': ('/static/logistics/css/custom_inline.css',)}  # 使用正斜杠
    # 基础列表显示配置
    list_per_page = 20
    list_max_show_all = 200
    date_hierarchy = 'created_at'
    preserve_filters = True
    list_display = ('order_number', 'supplier', 'item_count', 'total_quantity', 'created_by', 'created_at', 'status')
    list_filter = ('status','created_at')
    search_fields = ('order_number', 'supplier')
    list_editable = ('status',)
    # 新增和编辑时的字段显示
    fields = ('order_number', 'supplier',  'created_by', 'due_date')
    # 内联商品项管理
    inlines = [ProcurementOrderItemInline]
    def item_count(self, obj):
        """商品种类数（辅助列）"""
        return obj.item_count
    item_count.short_description = '商品种类数'
    def total_quantity(self, obj):
        """订单的总采购数量（辅助列）"""
        return obj.total_quantity
    total_quantity.short_description = '总采购数量'
    
    
    def get_readonly_fields(self, request, obj=None):
        """动态设置只读字段"""
        if obj:  # 编辑模式
            return self.readonly_fields + ('order_number',)
        return self.readonly_fields
    def get_changeform_initial_data(self, request):
        """设置新建表单的初始值"""
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'order_number': self.generate_initial_order_number(request)
        })
        return initial
    def generate_initial_order_number(self, request):
        """生成建议订单号（用户可覆盖）"""
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        
        last_order = ProcurementOrder.objects.filter(
            order_number__startswith=f'PPO-{date_str}-'
        ).order_by('-order_number').first()

        if last_order:
            last_num = int(last_order.order_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
            
        return f'PPO-{date_str}-{new_num:03d}'
    
    def save_model(self, request, obj, form, change):
        """保存时的处理逻辑"""
        if not change:  # 新建时
            # 自动填充创建人（确保安全）
            obj.created_by = request.user
            
            # 处理订单号逻辑
            if not obj.order_number:  # 用户未输入时使用自动生成
                obj.order_number = self.generate_initial_order_number(request)
            else:  # 用户自定义时进行格式验证
                if not obj.order_number.startswith('PPO-'):
                    raise ValidationError("订单号必须以PPO-开头")
        
        super().save_model(request, obj, form, change)

        
    def approve_selected_orders(self, request, queryset):
        invalid_orders = queryset.exclude(status='pending')
        if invalid_orders.exists():
            self.message_user(
                request,
                f"跳过 {invalid_orders.count()} 个非待审核状态的采购单",
                level=messages.WARNING
            )
        
        valid_orders = queryset.filter(status='pending')
        updated_count = valid_orders.update(status='approved')
        
        self.message_user(
            request,
            f"成功批准 {updated_count} 个采购单",
            level=messages.SUCCESS
        )
    approve_selected_orders.short_description = "批准选中的采购单"

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        extra_context = extra_context or {}
        if object_id:
            extra_context['show_approve_button'] = True
        return super().changeform_view(request, object_id, form_url, extra_context)

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                '<path:object_id>/approve/',
                self.admin_site.admin_view(self.approve_single_order),
                name='approve_purchase_order'
            ),
        ]
        return custom_urls + urls

    def approve_single_order(self, request, object_id):
        purchase_order = ProcurementOrder.objects.get(id=object_id)
        if purchase_order.status == 'pending':
            purchase_order.status = 'approved'
            purchase_order.save()
            self.message_user(request, "采购单已批准", messages.SUCCESS)
        else:
            self.message_user(request, "仅能批准待审核状态的采购单", messages.ERROR)
        return HttpResponseRedirect(
            reverse('admin:logistics_purchaseorder_change', args=[object_id])
        )
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                'get-plan-details/<int:plan_id>/',
                self.admin_site.admin_view(self.get_plan_details),
                name='get_plan_details'
            ),
        ]
        return custom_urls + urls

    def get_plan_details(self, request, plan_id):
        """获取采购计划详情的API"""
        try:
            plan = ProcurementOrder.objects.select_related('commodity', 'company').get(id=plan_id)
            data = {
                'commodity': {
                    'id': plan.commodity.id,
                    'text': str(plan.commodity),
                    'stock': plan.commodity.stock
                },
                'company': plan.company.id,
                'planned_quantity': plan.planned_quantity,
                'default_quantity': min(plan.planned_quantity, plan.commodity.stock)
            }
            return JsonResponse(data)
        except ProcurementOrder.DoesNotExist:
            return JsonResponse({'error': '采购计划不存在'}, status=404)

class PurchaseOrderItemInline(admin.TabularInline):
    model = PurchaseOrderItem
    extra = 0
    fields = ('commodity', 'unit_price', 'quantity_plan', 'quantity_actual')
    autocomplete_fields = ['commodity']
    search_fields = ['commodity']
    min_num = 1
    verbose_name = '订单商品项'
    verbose_name_plural = '订单商品项'
    class Media:
        css = {
            'all': (
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/autocomplete2.js',
        )
    def get_formset(self, request, obj=None, **kwargs):
        formset = super().get_formset(request, obj, **kwargs)
        formset.form.base_fields['commodity'].widget.can_add_related = False
        formset.form.base_fields['commodity'].widget.can_change_related = False
        return formset


@admin.register(PurchaseOrder)
class PurchaseOrderAdmin(admin.ModelAdmin):

    class Media:
        css = {
            'all': (
                'logistics/css/custom_inline1.css',
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/autocomplete_order2.js',
        )
    # 基础列表显示配置
    list_per_page = 10
    list_max_show_all = 200
    preserve_filters = True
    list_filter = (('created_at', DateRangeFilter),)
    date_hierarchy = 'created_at'
    list_display = ('order_number', 'supplier', 'item_count', 'total_quantity', 'created_by', 'created_at', 'status','due_date')
    search_fields = ('order_number', 'supplier')
    list_editable = ('status','due_date')
    # 新增和编辑时的字段显示
    fields = ('order_number','procurement_plan', 'supplier',  'created_by', 'due_date')
    autocomplete_fields = ['procurement_plan']
    # 内联商品项管理
    inlines = [PurchaseOrderItemInline]

    def item_count(self, obj):
        """商品种类数（辅助列）"""
        return obj.item_count
    item_count.short_description = '商品种类数'
    def total_quantity(self, obj):
        """订单的总采购数量（辅助列）"""
        return obj.total_quantity
    total_quantity.short_description = '总采购数量'
    def get_readonly_fields(self, request, obj=None):
        """动态设置只读字段"""
        if obj:  # 编辑模式
            return self.readonly_fields + ('order_number',)
        return self.readonly_fields

    def get_changeform_initial_data(self, request):
        """设置新建表单的初始值"""
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'order_number': self.generate_initial_order_number(request)
        })
        return initial
    
    def generate_initial_order_number(self, request):
        """生成建议订单号（用户可覆盖）"""
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        
        last_order = PurchaseOrder.objects.filter(
            order_number__startswith=f'PO-{date_str}-'
        ).order_by('-order_number').first()
        
        if last_order:
            last_num = int(last_order.order_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
            
        return f'PO-{date_str}-{new_num:03d}'


@admin.register(OutboundOrder)
class OutboundOrderAdmin(admin.ModelAdmin):
    list_display = ('order_number', 'commodity', 'quantity', 'created_by', 'created_at')
    search_fields = ('order_number', 'commodity__name')
    list_filter = ('created_at',)
    ordering = ('-created_at',)

    def get_changeform_initial_data(self, request):
        """设置新建表单的初始值"""
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'order_number': self.generate_initial_order_number(request)
        })
        return initial
    
    def generate_initial_order_number(self, request):
        """生成建议订单号（用户可覆盖）"""
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        
        last_order = OutboundOrder.objects.filter(
            order_number__startswith=f'OB-{date_str}-'
        ).order_by('-order_number').first()
        
        if last_order:
            last_num = int(last_order.order_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
            
        return f'OB-{date_str}-{new_num:03d}'


@admin.register(LogisticsOrder)
class LogisticsOrderAdmin(admin.ModelAdmin):
    list_display = ('tracking_number', 'purchase_order', 'order_info', 'carrier', 'status', 'estimated_delivery', 'actual_delivery')
    search_fields = ('tracking_number', 'carrier', 'purchase_order__order_number', 'order_info__order_number')
    list_filter = ('status', 'estimated_delivery', 'actual_delivery')
    ordering = ('-estimated_delivery',)

@admin.register(StockInOrder)
class StockInOrderAdmin(admin.ModelAdmin):
    list_display = ('stock_in_number', 'created_by', 'created_at', 'quantity', 'purchase_order', 'order_info')
    search_fields = ('stock_in_number', 'purchase_order__order_number', 'order_info__order_number')
    list_filter = ('created_at',)
    ordering = ('-created_at',)
