# logistics/serializers.py
from rest_framework import serializers
from .models import (
    ProcurementOrder, 
    OutboundOrder, 
    OutboundOrderItem, 
    ProcurementOrderItem
)
from shopper.models import OrderInfos

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

class OutboundOrderSerializer(serializers.ModelSerializer):
    sales_orders = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=OrderInfos.objects.all()
    )
    
    class Meta:
        model = OutboundOrder
        fields = '__all__'
        read_only_fields = ('order_number', 'created_by', 'created_at')
