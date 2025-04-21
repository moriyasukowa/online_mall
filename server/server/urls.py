from django.contrib import admin
from django.urls import path, include, re_path
from django.views.static import serve
from django.conf import settings
from commodity.models import CommodityInfos
from django.http import JsonResponse
from logistics.urls import get_procurement_plan
from shopper.models import Region
from shopper.views import get_sales_order_items

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
    path('shopper/region_list/', region_list, name='region_list'),
    path('shopper/get-sales-order-items/', get_sales_order_items, name='get_sales_order_items')
]