from django.shortcuts import render
# Create your views here.
# logistics/views.py
from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import ProcurementOrder
from .serializers import PurchaseOrderSerializer
from .models import OutboundOrder, OutboundOrderItem
from .serializers import OutboundOrderSerializer, ProcurementOrderSerializer

class ProcurementOrderViewSet(viewsets.ModelViewSet):
    queryset = ProcurementOrder.objects.prefetch_related('items').all()
    serializer_class = ProcurementOrderSerializer
    permission_classes = [permissions.IsAuthenticated]

class PurchaseOrderViewSet(viewsets.ModelViewSet):
    queryset = ProcurementOrder.objects.all()
    serializer_class = PurchaseOrderSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['post'])
    def approve(self, request, pk=None):
        """审核采购单"""
        purchase_order = self.get_object()
        if purchase_order.status != 'pending':
            return Response({'error': '采购单已审核'}, status=status.HTTP_400_BAD_REQUEST)
        purchase_order.status = 'approved'
        purchase_order.save()
        return Response({'status': '审核通过'})

    @action(detail=True, methods=['post'])
    def complete(self, request, pk=None):
        """标记采购完成并生成入库单"""
        purchase_order = self.get_object()
        if purchase_order.status != 'approved':
            return Response({'error': '采购单未审核'}, status=status.HTTP_400_BAD_REQUEST)
        
        # 创建入库单
        stock_in_order = StockInOrder.objects.create(
            stock_in_number=f"STOCKIN-{purchase_order.order_number}",
            created_by=request.user,
    
            quantity=purchase_order.quantity,
            purchase_order=purchase_order,
            notes="采购入库"
        )
        purchase_order.status = 'completed'
        purchase_order.save()
        return Response({'stock_in_number': stock_in_order.stock_in_number})
    
class OutboundOrderViewSet(viewsets.ModelViewSet):
    queryset = OutboundOrder.objects.all()
    serializer_class = OutboundOrderSerializer
    permission_classes = [permissions.IsAuthenticated]

