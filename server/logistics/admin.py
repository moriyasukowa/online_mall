from django.contrib import admin
from .models import PurchaseOrder, OutboundOrder, OutboundOrderItem, LogisticsOrder, StockInOrder
from django.contrib import admin
from django.http import HttpResponseRedirect
from django.utils.html import format_html
from django.contrib import messages
from django.urls import path, reverse

@admin.register(PurchaseOrder)
class PurchaseOrderAdmin(admin.ModelAdmin):
    list_display = ('order_number', 'commodity', 'quantity', 'status', 'created_by', 'created_at')
    list_filter = ('status',)
    actions = ['approve_selected_orders']

    # 自定义批量批准动作
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

    # 详情页按钮
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
        purchase_order = PurchaseOrder.objects.get(id=object_id)
        if purchase_order.status == 'pending':
            purchase_order.status = 'approved'
            purchase_order.save()
            self.message_user(request, "采购单已批准", messages.SUCCESS)
        else:
            self.message_user(request, "仅能批准待审核状态的采购单", messages.ERROR)
        return HttpResponseRedirect(
            reverse('admin:logistics_purchaseorder_change', args=[object_id])
        )
@admin.register(OutboundOrder)
class OutboundOrderAdmin(admin.ModelAdmin):
    list_display = ('order_number', 'commodity', 'quantity', 'created_by', 'created_at')
    search_fields = ('order_number', 'commodity__name')
    list_filter = ('created_at',)
    ordering = ('-created_at',)

@admin.register(OutboundOrderItem)
class OutboundOrderItemAdmin(admin.ModelAdmin):
    list_display = ('outbound_order', 'order', 'is_picked')
    search_fields = ('outbound_order__order_number', 'order__order_number')
    list_filter = ('is_picked',)
    ordering = ('-outbound_order__created_at',)

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
