from django.shortcuts import render
# Create your views here.
# logistics/views.py
from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import ProcurementOrder, StockInOrder
from .serializers import PurchaseOrderSerializer
from .models import OutboundOrder, OutboundOrderItem
from .serializers import OutboundOrderSerializer, OutboundOrderItemSerializer, ProcurementOrderSerializer
from .models import LogisticsOrder
from .serializers import LogisticsOrderSerializer

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

class OutboundOrderItemViewSet(viewsets.ModelViewSet):
    queryset = OutboundOrderItem.objects.all()
    serializer_class = OutboundOrderItemSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['patch'])
    def mark_picked(self, request, pk=None):
        """标记订单已拣选"""
        item = self.get_object()
        item.is_picked = True
        item.save()
        return Response({'status': '拣选完成'})
    
class LogisticsOrderViewSet(viewsets.ModelViewSet):
    queryset = LogisticsOrder.objects.all()
    serializer_class = LogisticsOrderSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['patch'])
    def update_status(self, request, pk=None):
        """更新物流状态（例如发货、签收）"""
        logistics_order = self.get_object()
        new_status = request.data.get('status')
        if new_status not in ['preparing', 'shipped', 'delivered']:
            return Response({'error': '无效状态'}, status=400)
        
        logistics_order.status = new_status
        if new_status == 'delivered':
            logistics_order.actual_delivery = timezone.now().date()
        logistics_order.save()
        return Response({'status': logistics_order.status})
    
from .models import StockInOrder
from .serializers import StockInOrderSerializer

class StockInOrderViewSet(viewsets.ModelViewSet):
    queryset = StockInOrder.objects.all()
    serializer_class = StockInOrderSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        """创建入库单时自动更新商品库存"""
        stock_in_order = serializer.save()
        commodity = stock_in_order.purchase_order.commodity if stock_in_order.purchase_order else stock_in_order.order_info.commodity
        commodity.stock += stock_in_order.quantity
        commodity.save()