# logistics/serializers.py
from rest_framework import serializers
from .models import (
    PurchaseOrder, 
    OutboundOrder, 
    OutboundOrderItem, 
    LogisticsOrder, 
    StockInOrder
)

class PurchaseOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = PurchaseOrder
        fields = '__all__'

class OutboundOrderItemSerializer(serializers.ModelSerializer):
    order_number = serializers.CharField(source='order.order_number', read_only=True)
    
    class Meta:
        model = OutboundOrderItem
        fields = ['id', 'order_number', 'is_picked']

class OutboundOrderSerializer(serializers.ModelSerializer):
    orders = OutboundOrderItemSerializer(source='outboundorderitem_set', many=True, read_only=True)
    
    class Meta:
        model = OutboundOrder
        fields = '__all__'

class LogisticsOrderSerializer(serializers.ModelSerializer):
    def validate(self, data):
        """确保物流单关联采购单或客户订单之一"""
        if not (data.get('purchase_order') or data.get('order_info')):
            raise serializers.ValidationError("必须关联采购单或客户订单")
        if data.get('purchase_order') and data.get('order_info'):
            raise serializers.ValidationError("不能同时关联采购单和客户订单")
        return data
    
    class Meta:
        model = LogisticsOrder
        fields = '__all__'

class StockInOrderSerializer(serializers.ModelSerializer):
    def validate(self, data):
        """确保入库单关联采购单或客户订单之一"""
        if not (data.get('purchase_order') or data.get('order_info')):
            raise serializers.ValidationError("必须关联采购单或客户订单")
        if data.get('purchase_order') and data.get('order_info'):
            raise serializers.ValidationError("不能同时关联采购单和客户订单")
        return data
    
    class Meta:
        model = StockInOrder
        fields = '__all__'