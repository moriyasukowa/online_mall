from rest_framework import serializers
from .models import PurchaseOrder, OutboundOrder, OutboundOrderItem, LogisticsOrder, StockInOrder

# filepath: c:/Users/zhang/Desktop/project/server/logistics/serializers.py


class PurchaseOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = PurchaseOrder
        fields = '__all__'

class OutboundOrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OutboundOrderItem
        fields = '__all__'

class OutboundOrderSerializer(serializers.ModelSerializer):
    orders = OutboundOrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = OutboundOrder
        fields = '__all__'

class LogisticsOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = LogisticsOrder
        fields = '__all__'

class StockInOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockInOrder
        fields = '__all__'