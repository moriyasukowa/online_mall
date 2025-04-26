from django.contrib import admin
from django.urls import path, include, re_path
from django.views.static import serve
from django.conf import settings
from commodity.models import CommodityInfos
from django.http import JsonResponse
from logistics.urls import get_outbound_order, get_procurement_plan, get_purchase_order, get_orders_of_outbound_order
from shopper.models import Region
from shopper.views import get_sales_order_items, AdminOrderDetailView, get_customer_order_details
from logistics.models import OutboundOrder
from django.db.models import Q

PENDING_PICKUP_STATE = '待揽收' # 或者根据你的 STATE 定义修改
def get_related_orders(request):
    outbound_order_id = request.GET.get('outbound_order_id')
    term = request.GET.get('term', '').strip() # 获取搜索词，去除首尾空格
    if not outbound_order_id:
        # 如果没有提供出库单ID，返回空列表
        return JsonResponse({'orders': []})
    try:
        outbound_order = OutboundOrder.objects.get(id=outbound_order_id)
        base_queryset = outbound_order.sales_orders.select_related('user').filter(
            state=PENDING_PICKUP_STATE  # 只获取“待揽收”状态的订单
        )
        if term:
            search_filter = (
                Q(id__icontains=term) |  # 搜索订单 ID (作为字符串部分匹配)
                Q(user__username__icontains=term) # 搜索用户名 (不区分大小写包含)
            )
            filtered_queryset = base_queryset.filter(search_filter)
        else:
            filtered_queryset = base_queryset

        orders_data = []
        for order in filtered_queryset:
            orders_data.append({
                'id': order.id,
                'text': str(order) # 使用模型的 __str__ 输出
            })

        return JsonResponse({'orders': orders_data})
    except OutboundOrder.DoesNotExist:
        # 如果出库单 ID 无效，返回空列表
        return JsonResponse({'orders': []})
    except Exception as e:
        # 最好在这里添加日志记录实际的错误
        print(f"Error in get_related_orders: {e}") # 打印错误到控制台供调试
        return JsonResponse({'error': 'An error occurred'}, status=500)

def region_list(request):
    parent_id = request.GET.get('parent_id')
    if int(parent_id) == 0:    
        print(f"parent_id: {parent_id}")
        queryset = Region.objects.filter(level = '1')
        data = {
            'code': 200,
            'message': 'success',
            'data': [{'id': r.id, 'name': r.name} for r in queryset]
        }
        return JsonResponse(data)
    queryset = Region.objects.filter(parent_id=parent_id)
    data = {
        'code': 200,
        'message': 'success',
        'data': [{'id': r.id, 'name': r.name} for r in queryset]
    }
    return JsonResponse(data)

def get_commodity_price(request):
    commodity_id = request.GET.get('commodity_id')
    try:
        commodity = CommodityInfos.objects.get(id=commodity_id)
        return JsonResponse({'price': float(commodity.price)})
    except CommodityInfos.DoesNotExist:
        return JsonResponse({'price': None})

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/commodity/', include(('commodity.urls', 'commodity'), namespace='commodity')),
    path('api/v1/shopper/', include(('shopper.urls', 'shopper'), namespace='shopper')),
    path('api/v1/logistics/', include(('logistics.urls', 'logistics'), namespace='logistics')),
    # 配置媒体资源的路由信息
    re_path('media/(?P<path>.*)', serve, {'document_root': settings.MEDIA_ROOT}, name='media'),
    # 定义静态资源的路由信息
    re_path('static/(?P<path>.*)', serve, {'document_root': settings.STATIC_ROOT}, name='static'),
    path('commodity/get_commodity_price/', get_commodity_price, name='get_commodity_price'),
    path('logistics/get_procurement_plan/', get_procurement_plan, name='get_procurement_plan'),
    path('logistics/get_purchase_order/', get_purchase_order, name='get_purchase_order'),
    path('logistics/get_outbound_order/', get_outbound_order , name='get_outbound_order'),
    path('logistics/get_orders_of_outbound_order/', get_orders_of_outbound_order , name='get_orders_of_outbound_order'),
    path('shopper/region_list/', region_list, name='region_list'),
    path('shopper/get-sales-order-items/', get_sales_order_items, name='get_sales_order_items'),
    path('shopper/order-detail/<int:pk>/', AdminOrderDetailView.as_view(), name='order-detail'), # 添加这行
    path('logistics/get-related-orders/', get_related_orders, name='get_related_orders'),
    path('shopper/get_customer_order_details/', get_customer_order_details, name='get_customer_order_details'),
]