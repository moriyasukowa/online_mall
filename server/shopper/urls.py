from django.urls import path
from .views import *

urlpatterns = [
    path('login/', loginView.as_view(), name='login'),
    path('logout/', logoutView.as_view(), name='logout'),
    path('home/', shopperView.as_view(), name='home'),
    path('shopcart/', shopcartView.as_view(), name='shopcart'),
    path('pays/', paysView.as_view(), name='pays'),
    path('delete/', deleteView.as_view(), name='delete'),
    path('refund/', refundView.as_view(), name='refunds'),
    path('gets/', getView.as_view(), name='gets'),
    path('updateOrderStatus/', updateOrderStatusView.as_view(), name='updateOrderStatus')
]
