from django.contrib import admin
from .models import PurchaseOrder, OutboundOrder, OutboundOrderItem, LogisticsOrder, StockInOrder
from django.contrib import admin
from django.http import HttpResponseRedirect
from django.urls import path
from django.utils.html import format_html
from django.contrib import messages

@admin.register(PurchaseOrder)
class PurchaseOrderAdmin(admin.ModelAdmin):
    list_display = ('order_number', 'commodity', 'quantity', 'status', 'created_by', 'created_at')
    list_filter = ('status',)
    actions = ['approve_selected_orders']  # 添加自定义动作
    def approve_selected_orders(modeladmin, request, queryset):
        invalid_orders = queryset.exclude(status='pending')
        if invalid_orders.exists():
            modeladmin.message_user(
                request,
                f"跳过 {invalid_orders.count()} 个非待审核状态的采购单",
                level=messages.WARNING
            )
        
        valid_orders = queryset.filter(status='pending')
        updated_count = valid_orders.update(status='approved')
        
        modeladmin.message_user(
            request,
            f"成功批准 {updated_count} 个采购单",
            level=messages.SUCCESS
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
