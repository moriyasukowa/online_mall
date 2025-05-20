from urllib.parse import urlparse
from django.contrib import admin
from django.forms import ValidationError
from django.shortcuts import redirect
from django.db import IntegrityError, transaction
from commodity.models import CommodityInfos
from shopper.models import OrderInfos
from .models import ProcurementOrder, OutboundOrder, PurchaseOrder, PurchaseOrderItem,ProcurementOrderItem, OutboundOrderItem, LogisticsOrder, LogisticsOrderItem, PurchaseStockInOrder, PurchaseStockInOrderItem
from django.contrib import admin
from django.http import HttpResponseRedirect, JsonResponse
from django.utils.html import format_html
from django.contrib import messages
from django.urls import path, resolve, reverse
from django.utils import timezone
from django.contrib.admin import DateFieldListFilter
from rangefilter.filters import DateRangeFilter
from logistics.form import PurchaseOrderItemInlineFormSet

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
                'logistics/css/select_table.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/autocomplete2.js',
            'logistics/js/select2_table.js',
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
    formset = PurchaseOrderItemInlineFormSet # 使用自定义的 FormSet
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
                'logistics/css/select_table.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/autocomplete2.js',
            'logistics/js/select2_table.js',
        )
    def get_formset(self, request, obj=None, **kwargs):
        formset = super().get_formset(request, obj, **kwargs)
        formset.form.base_fields['commodity'].widget.can_add_related = False
        formset.form.base_fields['commodity'].widget.can_change_related = False
        return formset
    

@admin.register(PurchaseOrder)
class PurchaseOrderAdmin(admin.ModelAdmin):

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

    # Task 1: 采购计划1对1检查 (在 save_model 中尝试，但 Form clean 更佳)
    def save_model(self, request, obj: PurchaseOrder, form, change):
        if obj.procurement_plan:
            query = PurchaseOrder.objects.filter(procurement_plan=obj.procurement_plan)
            if change and obj.pk: # 如果是编辑，排除自己
                query = query.exclude(pk=obj.pk)
            if query.exists():
                # 使用 messages 框架提示，但这不会阻止保存
                messages.error(request, f"错误：采购计划 '{obj.procurement_plan}' 已经被其他采购订单关联。")
        super().save_model(request, obj, form, change) # 调用父类方法保存 PurchaseOrder

    def save_formset(self, request, form, formset, change):

        super().save_formset(request, form, formset, change)
        purchase_order = form.instance # 获取已保存的 PurchaseOrder 实例
        if purchase_order.procurement_plan:
            plan = purchase_order.procurement_plan
            if plan.status != 'approved': # 避免不必要的更新
                plan.status = 'approved'
                plan.save(update_fields=['status']) # 只更新 status 字段
                self.message_user(request, f"采购计划 '{plan.order_number}' 状态已更新为 '已批准'。", messages.SUCCESS)
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


class OutboundOrderItemInline(admin.TabularInline):
    class Media:
        css = {
            'all': (
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
                'logistics/css/select_table.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/select2_table.js',
        )
    model = OutboundOrderItem
    fields = ('commodity', 'quantity') 
    extra = 0
    min_num = 1
    autocomplete_fields = ['commodity'] 

@admin.register(OutboundOrder)
class OutboundOrderAdmin(admin.ModelAdmin):
    class Media:
        css = {
            'all': (
                'logistics/css/inline_out.css',
                'logistics/css/custom_filter_horizontal.css',
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/custom_filter_horizontal.js',
            'logistics/js/outbound_complete.js',
        )

    inlines = [OutboundOrderItemInline]
    list_display = ('order_number', 'status', 'created_by', 'created_at', 'outbound_date', 'item_count', 'total_quantity')
    list_filter = ('status', 'created_at', 'outbound_date')
    search_fields = ('order_number','created_by__username')
    readonly_fields = ('created_at', 'item_count', 'total_quantity')
    autocomplete_fields = ['created_by']
    fields = ('order_number',  'created_by', 'outbound_date','sales_orders', 'notes')
    # 使用自定义模板
    filter_horizontal = ['sales_orders']
    
    # 限制只显示待支付的订单
    def formfield_for_manytomany(self, db_field, request, **kwargs):
        if db_field.name == "sales_orders":
            kwargs["queryset"] = OrderInfos.objects.filter(state='已支付')
        return super().formfield_for_manytomany(db_field, request, **kwargs)

    def item_count(self, obj):
        return obj.item_count
    item_count.short_description = '商品种类数'

    def total_quantity(self, obj):
        return obj.total_quantity
    total_quantity.short_description = '总出库数量'

    def get_readonly_fields(self, request, obj=None):
        if obj:
            return self.readonly_fields + ('order_number',)
        return self.readonly_fields

    def get_changeform_initial_data(self, request):
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'order_number': self.generate_initial_order_number(request)
        })
        return initial

    def generate_initial_order_number(self, request):
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        last_order = OutboundOrder.objects.filter(order_number__startswith=f'OB-{date_str}-').order_by('-order_number').first()
        if last_order:
            last_num = int(last_order.order_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
        return f'OB-{date_str}-{new_num:03d}'
    
    def save_model(self, request, obj, form, change):
        with transaction.atomic():
            # 先保存出库单（但不提交事务）
            super().save_model(request, obj, form, change)
            
            # 获取表单中提交的销售订单ID列表
            if 'sales_orders' in form.cleaned_data:
                sales_order_ids = [order.id for order in form.cleaned_data['sales_orders']]
                
                # 更新这些订单的状态
                updated_count = OrderInfos.objects.filter(
                    id__in=sales_order_ids
                ).update(state='待揽收')
                
                # 添加操作成功的消息
                messages.success(
                    request, 
                    f'成功创建出库单，并更新了{updated_count}个关联订单的状态为"待揽收"'
                )
                
                # 确保多对多关系被保存（Django通常会自动处理）
                form.save_m2m()
            else:
                messages.warning(
                    request, 
                    '出库单创建成功，但没有关联任何销售订单'
                )
    def save_related(self, request, form, formsets, change):
        """
        在主对象和所有 formsets (包括 Inlines) 保存后调用。
        处理库存扣减和关联订单状态更新。
        """
        # 1. 首先调用父类的方法，确保默认的 M2M 等关联关系被保存
        super().save_related(request, form, formsets, change)

        # 2. 获取已保存的 OutboundOrder 实例
        obj = form.instance

        # 3. 获取关联的 OutboundOrderItem (现在应该能获取到了)
        items_to_process = obj.items.all()

        # 4. 检查是否有明细，如果没有则无需后续处理
        if not items_to_process:
            # 这里可以根据业务决定是否需要警告。
            # 如果是在 save_model 后立刻调用 save_related，可能还没有items
            # 但Django admin的标准流程是formsets保存后再调用save_related
            # 为保险起见，先检查一遍
            if not obj.items.exists(): # 再次确认数据库中是否存在
                 messages.warning(request, f"出库单 {obj.order_number} 最终没有包含任何商品明细，未执行库存扣减或销售订单状态更新。")
                 return

        # 5. 在事务中执行库存和订单状态更新逻辑
        try:
            with transaction.atomic():
                # --- 库存检查与扣减逻辑 ---
                commodities_to_update = []
                processed_commodity_ids = set() # 用于跟踪已处理的商品ID

                # 重新获取一次 items，确保拿到的是事务内最新的数据
                current_items = obj.items.all()
                if not current_items.exists(): # 再次检查，以防万一
                     messages.warning(request, f"出库单 {obj.order_number} 保存关联项后仍无商品明细，跳过后续处理。")
                     return # 明确退出


                for item in current_items:
                    commodity_id = item.commodity_id
                    quantity_to_deduct = item.quantity

                    if not commodity_id or quantity_to_deduct <= 0:
                        continue

                    # 避免重复处理同一商品ID（如果允许合并计算则需修改）
                    if commodity_id in processed_commodity_ids:
                        continue

                    try:
                        # 查询并锁定商品库存记录
                        commodity_record = CommodityInfos.objects.select_for_update().get(id=commodity_id)

                        if commodity_record.inventory < quantity_to_deduct:
                            raise ValidationError(
                                f"商品 '{commodity_record.name}' (ID: {commodity_id}) 库存不足。 "
                                f"当前库存: {commodity_record.inventory}, 本次出库需要: {quantity_to_deduct} "
                                f"(来自出库单: {obj.order_number})"
                            )

                        commodity_record.inventory -= quantity_to_deduct
                        commodities_to_update.append(commodity_record)
                        processed_commodity_ids.add(commodity_id)

                    except CommodityInfos.DoesNotExist:
                        raise ValidationError(
                            f"无法找到 ID 为 {commodity_id} 的商品信息，无法出库 "
                            f"(来自出库单: {obj.order_number})"
                        )

                # --- 批量更新商品库存 ---
                if commodities_to_update:
                    CommodityInfos.objects.bulk_update(commodities_to_update, ['inventory'])
                    messages.success(request, f"成功更新了 {len(processed_commodity_ids)} 种商品的库存。")

                # --- 更新关联销售订单的状态 ---
                # M2M关系应已由 super().save_related() 或Django默认机制保存
                sales_orders_qs = obj.sales_orders.all() # 直接从已保存的对象获取关联订单
                if sales_orders_qs.exists():
                    sales_order_ids = list(sales_orders_qs.values_list('id', flat=True))

                    # 更新状态，假设从'已支付'变为'待揽收'
                    updated_count = OrderInfos.objects.filter(
                        id__in=sales_order_ids,
                        state='已支付' # 原始状态
                    ).update(state='待揽收') # 目标状态 (与OutboundOrder的status choices匹配?)

                    if updated_count > 0:
                        messages.success(request, f'成功更新了 {updated_count} 个关联销售订单的状态为 "待揽收"。')
                    # else: # 可以选择性地添加警告，如果没更新任何订单
                    #     messages.warning(request, f'尝试更新 {len(sales_order_ids)} 个关联销售订单状态，但没有订单处于可更新状态（例如，状态不是 "已支付"）。')

        except ValidationError as e:
            messages.error(request, f"处理出库单关联操作失败（库存或订单状态）：{e}")
            # 注意：主对象和Inline可能已保存，此错误不自动回滚整个Admin保存过程
        except IntegrityError as e:
            messages.error(request, f"数据库错误，处理关联操作失败：{e}")
        except Exception as e:
            messages.error(request, f"发生意外错误，处理关联操作失败：{e}")
            # 添加日志记录
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Error in save_related for outbound order {obj.order_number}: {e}", exc_info=True)
class LogisticsOrderItemInline(admin.TabularInline):
    class Media:
        css = {
            'all': (
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
                'logistics/css/select_table.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/select2_table.js',
        )
    model = LogisticsOrderItem
    extra = 1
    autocomplete_fields = ['commodity']
    fields = ['commodity', 'quantity']
    min_num = 1
    verbose_name = "物流单商品项"
    verbose_name_plural = "物流单商品项"
@admin.register(LogisticsOrder)

class LogisticsOrderAdmin(admin.ModelAdmin):
    
    class Media:
        css = {
            'all': (
                    'logistics/css/custom_inline.css',
                    'logistics/css/address(dest)_select2-table.css',
                    'logistics/css/address(origin)_select2-table.css',
                    'logistics/css/order_of_outbound.css',
                    )
        }
        js = ('admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/address(dest)_select_table2.js',
            'logistics/js/address(origin)_select_table2.js',
            'logistics/js/order_of_outbound.js',
            'logistics/js/autocomplete_logistics_order1.js',
            )

    list_display = ['tracking_number', 'carrier', 'status', 'source_info', 
                    'estimated_delivery', 'actual_delivery', 'total_quantity',  
                    'item_count', 'created_at']
    list_filter = ['status', 'carrier', 'created_at']
    search_fields = ['tracking_number', 'carrier', 'notes']
    inlines = [LogisticsOrderItemInline]
    list_editable = ['status']
    
    fields = ['tracking_number', 'carrier', 'status', 'estimated_delivery', 'created_by', 'outbound_order', 'order_infos', 'origin_address', 'destination_address', 'notes']

    autocomplete_fields = ['outbound_order']

    def item_count(self, obj):
        return obj.item_count
    item_count.short_description = '商品种类数'

    def total_quantity(self, obj):
        return obj.total_quantity
    total_quantity.short_description = '总出库数量'
    def get_changeform_initial_data(self, request):
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'tracking_number': self.generate_initial_order_number(request)
        })
        return initial

    def generate_initial_order_number(self, request):
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        last_order = LogisticsOrder.objects.filter(tracking_number__startswith=f'LO-{date_str}-').order_by('-tracking_number').first()
        if last_order:
            last_num = int(last_order.tracking_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
        return f'LO-{date_str}-{new_num:03d}'
    
    def source_info(self, obj):
        if obj.outbound_order:
            return format_html('<span style="color: green;">出库单: {}</span>', obj.outbound_order.order_number)
        return "未关联"
    source_info.short_description = "关联来源"
    
    def save_model(self, request, obj: LogisticsOrder, form, change):

        try:
            with transaction.atomic():
                # 1. 先调用父类的 save_model 保存 LogisticsOrder 自身
                super().save_model(request, obj, form, change)
                # obj.refresh_from_db()
                # 2. 更新关联的 OrderInfos 状态
                order_info = obj.order_infos # 获取关联的客户订单对象
                if order_info:
                    if order_info.state != "已发货": # 仅在状态不是“已发货”时更新
                        old_status = order_info.state
                        order_info.state = "已发货"
                        order_info.save() 
                        print(f"订单 {order_info.id} 状态从 {old_status} 更新为已发货") # 日志
                    else:
                        print(f"订单 {order_info.id} 状态已经是已发货'，无需更新。") # 日志
                # 3. 检查并更新关联的 OutboundOrder 状态
                outbound_order = obj.outbound_order # 获取关联的出库单对象
                if outbound_order:
                    related_logistics_orders = LogisticsOrder.objects.filter(outbound_order=outbound_order)
                    is_any_order_not_shipped = related_logistics_orders.exclude(
                        order_infos__state ="已发货"
                    ).exists()
                    if not is_any_order_not_shipped:
                        # 如果所有关联的 OrderInfos 都已发货
                        if outbound_order.status != "completed":
                            old_outbound_status = outbound_order.status
                            outbound_order.status = "completed"
                            outbound_order.save()
                            messages.success(request, f"出库单 '{outbound_order.order_number}' 所有关联订单已发货，状态已更新为 完成。")
                            print(f"出库单 {outbound_order.order_number} 状态从 '{old_outbound_status}' 更新为 完成") # 日志
                        else:
                             print(f"出库单 {outbound_order.order_number} 状态已经是 完成。") # 日志
                    else:
                        # 否则，还有订单未发货，保持出库单状态不变（或设置为处理中等）
                        print(f"出库单 {outbound_order.order_number} 尚有关联订单未发货，状态保持 '{outbound_order.status}'。") # 日志

        except Exception as e:
             # 如果事务中发生任何错误，进行回滚，并向用户显示错误消息
             messages.error(request, f"保存物流单时发生错误: {e}")
             print(f"保存 LogisticsOrder {obj.id if obj and obj.id else 'new'} 时出错: {e}") # 记录详细错误到服务器日志

    

class PurchaseStockInOrderItemInline(admin.TabularInline):
    class Media:
        css = {
            'all': (
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
                'logistics/css/select_table.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/select2_table.js',
        )
    model = PurchaseStockInOrderItem
    extra = 1
    autocomplete_fields = ['commodity']
    fields = ['commodity', 'quantity']
    min_num = 1
    verbose_name = "入库单商品项"
    verbose_name_plural = "入库单商品项"

@admin.register(PurchaseStockInOrder)
class PurchaseStockInOrderAdmin(admin.ModelAdmin):
    class Media:
        css = {
            'all': (
                    'logistics/css/custom_inline.css',
                    'logistics/css/custom_filter_horizontal.css',
                    'logistics/css/inbound_custom.css',)
        }
        js = ('admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/pinbound_custom.js',
            'logistics/js/inbound_complete.js',
            )
        
    list_display = ['order_number', 'status', 'created_by', 'created_at', 
                    'total_quantity', 'item_count']
    list_filter = ['status', 'created_at', 'created_by']
    search_fields = ['order_number', 'notes']
    filter_horizontal = ['purchase_orders'] 
    inlines = [PurchaseStockInOrderItemInline]
    fields = ['order_number', 'status', 'created_by', 'created_at','purchase_orders','notes']

    # 限制只显示待支付的订单
    def formfield_for_manytomany(self, db_field, request, **kwargs):
        if db_field.name == "purchase_orders":
            kwargs["queryset"] = PurchaseOrder.objects.filter(status='pending')
        return super().formfield_for_manytomany(db_field, request, **kwargs)

    def get_changeform_initial_data(self, request):
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'order_number': self.generate_initial_order_number(request)
        })
        return initial

    def generate_initial_order_number(self, request):
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        last_order = PurchaseStockInOrder.objects.filter(order_number__startswith=f'PSO-{date_str}-').order_by('-order_number').first()
        if last_order:
            last_num = int(last_order.order_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
        return f'PSO-{date_str}-{new_num:03d}'
    
    def item_count(self, obj):
        return obj.item_count
    item_count.short_description = '商品种类数'

    def total_quantity(self, obj):
        return obj.total_quantity
    total_quantity.short_description = '总出库数量'

    def save_model(self, request, obj, form, change):
        with transaction.atomic():
            # 先保存出库单（但不提交事务）
            super().save_model(request, obj, form, change)
            
            # 获取表单中提交的销售订单ID列表
            if 'purchase_orders' in form.cleaned_data:
                purchase_order_ids = [order.order_number for order in form.cleaned_data['purchase_orders']]
                
                # 更新这些订单的状态
                updated_count = OrderInfos.objects.filter(
                    order_number__in=purchase_order_ids
                ).update(state='completed')
                
                # 添加操作成功的消息
                messages.success(
                    request, 
                    f'成功创建入库单，并更新其关联的{updated_count}采购单状态为"已完成"'
                )
                
                # 确保多对多关系被保存（Django通常会自动处理）
                form.save_m2m()
            else:
                messages.warning(
                    request, 
                    '出库单创建成功，但没有关联任何销售订单'
                )

    # --- save_related for inventory increase and PO status update ---
    def save_related(self, request, form, formsets, change):

        super().save_related(request, form, formsets, change)

        obj = form.instance

        items_to_process = obj.items.all() # IMPORTANT: Check related_name



        if not items_to_process.exists():
            messages.warning(request, f"入库单 {obj.order_number} 没有包含任何商品明细，未执行库存增加或采购单状态更新。")
            return # Exit if no items

        try:
            with transaction.atomic():
                # --- Inventory Increase Logic ---
                commodities_to_update = []
                processed_commodity_ids = set()

                for item in items_to_process:
                    commodity_id = item.commodity_id
                    quantity_to_increase = item.quantity # Use the correct name

                    if not commodity_id or quantity_to_increase <= 0:
                        continue

                    # Optional: handle multiple lines for same commodity if needed
                    if commodity_id in processed_commodity_ids:
                        # If you sum quantities *before* locking, lock only once.
                        # For simplicity here, we process each line but lock once per commodity.
                        pass

                    try:
                        # Lock the commodity row for update
                        commodity_record = CommodityInfos.objects.select_for_update().get(id=commodity_id)

                        # Increase inventory
                        commodity_record.inventory += quantity_to_increase
                        commodities_to_update.append(commodity_record)
                        processed_commodity_ids.add(commodity_id)

                    except CommodityInfos.DoesNotExist:
                        # This indicates a data integrity issue
                        raise ValidationError(
                            f"无法找到 ID 为 {commodity_id} 的商品信息，无法入库 "
                            f"(来自入库单: {obj.order_number})"
                        )

                # --- Bulk update inventory ---
                if commodities_to_update:
                    CommodityInfos.objects.bulk_update(commodities_to_update, ['inventory'])
                    messages.success(request, f"成功更新了 {len(processed_commodity_ids)} 种商品的库存。")
                    
        except ValidationError as e:
            messages.error(request, f"处理入库单关联操作失败（库存或订单状态）：{e}")
        except IntegrityError as e:
            messages.error(request, f"数据库错误，处理关联操作失败：{e}")
        except Exception as e:
            messages.error(request, f"发生意外错误，处理关联操作失败：{e}")
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Error in save_related for purchase stock in order {obj.order_number}: {e}", exc_info=True)
    
