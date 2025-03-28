# logistics/serializers.py
from rest_framework import serializers
from .models import (
    ProcurementOrder, 
    OutboundOrder, 
    OutboundOrderItem, 
    LogisticsOrder, 
    StockInOrder,
    ProcurementOrderItem
)
class ProcurementOrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProcurementOrderItem
        fields = ('commodity', 'quantity')
class ProcurementOrderSerializer(serializers.ModelSerializer):
    items = ProcurementOrderItemSerializer(many=True)
    class Meta:
        model = ProcurementOrder
        fields = ('order_number', 'supplier', 'status', 'items')
    def create(self, validated_data):
        items_data = validated_data.pop('items')
        order = ProcurementOrder.objects.create(**validated_data)
        for item_data in items_data:
            ProcurementOrderItem.objects.create(order=order, **item_data)
        return order
    def update(self, instance, validated_data):
        items_data = validated_data.pop('items')
        instance.supplier = validated_data.get('supplier', instance.supplier)
        instance.status = validated_data.get('status', instance.status)
        instance.save()
        # 清除旧的订单项，重新添加
        instance.items.all().delete()
        for item_data in items_data:
            ProcurementOrderItem.objects.create(order=instance, **item_data)
        return instance
class PurchaseOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProcurementOrder
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