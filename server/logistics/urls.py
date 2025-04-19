# logistics/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PurchaseOrderViewSet,
    OutboundOrderViewSet,
    LogisticsOrderViewSet,
    StockInOrderViewSet,
)

router = DefaultRouter()
router.register(r'purchase-orders', PurchaseOrderViewSet)
router.register(r'outbound-orders', OutboundOrderViewSet)
router.register(r'logistics-orders', LogisticsOrderViewSet)
router.register(r'stock-in-orders', StockInOrderViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
from django.http import JsonResponse
from .models import PurchaseOrder, ProcurementOrder, ProcurementOrderItem

def get_procurement_plan(request):
    """获取采购计划的详细信息，包括供应商和商品项"""
    plan_id = request.GET.get('plan_id')
    try:
        plan = ProcurementOrder.objects.get(id=plan_id)
        items = ProcurementOrderItem.objects.filter(order=plan)
        
        # 准备响应数据
        response_data = {
            'supplier': str(plan.supplier) if plan.supplier else None,
            'items': [
                {
                    'commodity_id': item.commodity.id,
                    'name' : str(item.commodity) if item.commodity else None,
                    'unit_price': float(item.unit_price) if item.unit_price else 0,
                    'quantity': item.quantity
                }
                for item in items
            ]
        }
        return JsonResponse(response_data)
    except ProcurementOrder.DoesNotExist:
        return JsonResponse({'error': '采购计划不存在'}, status=404)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)