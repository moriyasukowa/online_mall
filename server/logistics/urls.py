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