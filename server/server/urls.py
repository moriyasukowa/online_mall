from django.contrib import admin
from django.urls import path, include, re_path
from django.views.static import serve
from django.conf import settings
from commodity.models import CommodityInfos
from django.http import JsonResponse
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
]

