# logistics/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PurchaseOrderViewSet,
    OutboundOrderViewSet,
    OutboundOrderItemViewSet,
    LogisticsOrderViewSet,
    StockInOrderViewSet
)

router = DefaultRouter()
router.register(r'purchase-orders', PurchaseOrderViewSet)
router.register(r'outbound-orders', OutboundOrderViewSet)
router.register(r'outbound-items', OutboundOrderItemViewSet)
router.register(r'logistics-orders', LogisticsOrderViewSet)
router.register(r'stock-in-orders', StockInOrderViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
from django.http import JsonResponse
from .models import PurchaseOrder

def get_procurement_plan_details(request):
    plan_id = request.GET.get('id')
    if not plan_id:
        return JsonResponse({'error': 'Invalid ID'}, status=400)
    
    try:
        plan = PurchaseOrder.objects.get(id=plan_id)
        return JsonResponse({
            'commodity': plan.commodity.id,
            'quantity': plan.quantity,
            'supplier': plan.supplier
        })
    except PurchaseOrder.DoesNotExist:
        return JsonResponse({'error': 'Procurement plan not found'}, status=404)
