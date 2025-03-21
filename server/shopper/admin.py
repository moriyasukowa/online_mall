from django.contrib import admin
from .models import *
from django.contrib import messages
from django.urls import path, reverse
from django.http import HttpResponseRedirect
# admin.site.register(CartInfos)
# admin.site.register(OrderInfos)

@admin.register(OrderInfos)
class OrderInfosAdmin(admin.ModelAdmin):
    list_display = ['id', 'price', 'created', 'state', 'pay_id']
    list_filter = ['state']
    date_hierarchy = 'created'

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



