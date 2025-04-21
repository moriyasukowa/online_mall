from django.contrib import admin
from .models import *
from django.contrib import messages
from django.urls import path, reverse
from django.http import HttpResponseRedirect
from django.utils.html import format_html
from shopper.form import AddressInfosForm

class PurchaseInfosInline(admin.TabularInline):
    model = PurchaseInfos
    fields = ('commodityInfos_id', 'quantity', 'unit_price')
    autocomplete_fields = ['commodityInfos_id']
    extra = 1
    min_num = 1
    verbose_name = '购买商品'
    verbose_name_plural = '购买商品列表'
    class Media:
        css = {
            'all': (
                'shopper/css/select_table.css',
            )
        }

        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/complete_price_shopper.js',
            'shopper/js/shopper_s2_table.js',
        )

@admin.register(OrderInfos)
class OrderInfosAdmin(admin.ModelAdmin):
    class Media:
        css = {
            'all': (
                'shopper/css/inline_commodity.css',
                'shopper/css/address_select2-table.css',
            )
        }

        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/cal_price.js',
            'shopper/js/address_select_table2.js',
        )
    list_display = ('id', 'user_info', 'price', 'state_display', 'created', 'order_actions')
    list_filter = ('state', 'created')
    search_fields = ('id', 'user__username', 'pay_id')
    autocomplete_fields = ['address']
    inlines = [PurchaseInfosInline]
    date_hierarchy = 'created'
    list_per_page = 20
    actions = ['mark_as_paid', 'mark_as_shipped']
    fields = ('user', 'state', 'price','pay_id','address',)
    # 自定义方法：显示用户信息

    def user_info(self, obj):
        if obj.user:
            url = reverse('admin:auth_user_change', args=[obj.user.id])
            return format_html('<a href="{}">{}</a>', url, obj.user.username)
        return "-"
    user_info.short_description = '用户'
    def state_display(self, obj):
        color_map = {
            '待支付': 'orange',
            '已支付': 'green',
            '发货中': 'blue',
            '已签收': 'purple',
            '退货中': 'red',
            '退款成功': 'gray'
        }
        color = color_map.get(obj.state, 'black')
        return format_html(
            '<span style="color: {}; font-weight: bold;">{}</span>',
            color,
            obj.get_state_display()
        )
    state_display.short_description = '订单状态'
    def order_actions(self, obj):
        buttons = []
        if obj.state == 'unpaid':
            buttons.append(
                '<a class="button" href="{}">标记为已支付</a>'.format(
                    reverse('admin:mark_order_paid', args=[obj.id])
                )
            )
        elif obj.state == 'paid':
            buttons.append(
                '<a class="button" href="{}">发货</a>'.format(
                    reverse('admin:mark_order_shipped', args=[obj.id])
                )
            )
        return format_html(' '.join(buttons))
    order_actions.short_description = '操作'
    order_actions.allow_tags = True
    
    def mark_as_paid(self, request, queryset):
        updated = queryset.filter(state='unpaid').update(state='paid')
        self.message_user(request, f"{updated}个订单已标记为已支付")
    mark_as_paid.short_description = "标记选中订单为已支付"
    # 自定义动作：标记为已发货
    def mark_as_shipped(self, request, queryset):
        updated = queryset.filter(state='paid').update(state='shipped')
        self.message_user(request, f"{updated}个订单已标记为已发货")
    mark_as_shipped.short_description = "标记选中订单为已发货"
    # 获取查询集优化
    def get_queryset(self, request):
        return super().get_queryset(request).select_related('user', 'address')


@admin.register(AddressInfos)
class AddressInfosAdmin(admin.ModelAdmin):
    form = AddressInfosForm
    list_display = ('user', 'province_city_district', 'detail', 'phone_number', 'recipient_name', 'is_default')
    list_editable = ('detail', 'phone_number', 'recipient_name', 'is_default')

    list_filter = ('province', 'city')
    search_fields = ('user__username', 'detail', 'phone_number', 'recipient_name')
    raw_id_fields = ('user',)
    autocomplete_fields = ['user']

    def province_city_district(self, obj):
        return f"{obj.province} {obj.city} {obj.district}"
    province_city_district.short_description = '省市区'
    
    class Media:
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/address_selector.js',  # 三级联动JS
        )
        css = {
            'all': (
                'shopper/css/addressinfo_admin_custom.css',
            )
        }

@admin.register(Region)
class RegionAdmin(admin.ModelAdmin):
    list_display = ('name', 'parent', 'level')
    list_filter = ('level',)
    search_fields = ('name',)

@admin.register(RefundInfos)
class RefundInfosAdmin(admin.ModelAdmin):
    list_display = ['id', 'created', 'state', 'order_id', 'price']
    list_filter = ['state']
    date_hierarchy = 'created'
    def approve_selected_orders(self, request, queryset):
            invalid_orders = queryset.exclude(state='退款申请中')
            if invalid_orders.exists():
                self.message_user(
                    request,
                    f"跳过 {invalid_orders.count()} 个非待审核状态的采购单",
                    level=messages.WARNING
                )
            
            valid_orders = queryset.filter(status='退款申请中')
            updated_count = valid_orders.update(status='退款成功')
            
            self.message_user(
                request,
                f"成功批准 {updated_count} 个退款申请",
                level=messages.SUCCESS
            )
    approve_selected_orders.short_description = "批准选中的退款申请"

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
        purchase_order = RefundInfos.objects.get(id=object_id)
        if purchase_order.status == '退款申请中':
            purchase_order.status = '退款成功'
            purchase_order.save()
            self.message_user(request, "采购单已批准", messages.SUCCESS)
        else:
            self.message_user(request, "仅能批准待审核状态的采购单", messages.ERROR)
        return HttpResponseRedirect(
            reverse('admin:logistics_purchaseorder_change', args=[object_id])
        )



