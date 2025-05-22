import json
from django.conf import settings
from django.db.models import F
from django.http import Http404, JsonResponse
from rest_framework.pagination import PageNumberPagination
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import *
from django.core.exceptions import PermissionDenied
from django.contrib.admin.utils import get_model_from_relation
from django.contrib.admin.views.autocomplete import AutocompleteJsonView
from django.db.models import Q

class commodityView(APIView):
    '''
    商品列表页
    '''
    authentication_classes = []
    permission_classes = []

    # GET请求
    def get(self, request):
        types = request.GET.get('types', '')
        search = request.GET.get('search', '')
        sort = request.GET.get('sort', 'sold')  # 默认按销量排序
        
        # 添加排序方向参数，默认为降序('desc')
        order = request.GET.get('order', 'desc')
        
        context = {'state': 'success', 'msg': '获取成功', 'data': {}}
        context['data']['types'] = []
        firsts = Types.objects.values_list('firsts', flat=True).distinct()
        for f in firsts:
            t = Types.objects.filter(firsts=f).values_list('seconds', flat=True).all()
            context['data']['types'].append(dict(name=f, value=t))
        
        cf = CommodityInfos.objects.all()
        
        if types:
            cf = cf.filter(types=types)
            
        # 修改排序逻辑，支持正序和逆序
        if sort:
            # 根据order参数决定是否添加'-'前缀
            if order.lower() == 'desc':  # 降序排序
                cf = cf.order_by('-' + sort)
            else:  # 升序排序
                cf = cf.order_by(sort)
                
        if search:
            cf = cf.filter(name__contains=search)
            
        count = cf.count()
        # 分页查询，需要在settings.py设置REST_FRAMEWORK属性
        pg = PageNumberPagination()
        p = pg.paginate_queryset(queryset=cf, request=request)
        # 将分页后的数据传递MySerializer，生成JSON数据对象
        c = CommodityInfosSerializer(instance=p, many=True)
        # 获取前一页、后一页和总页的页数
        pageCount = pg.page.paginator.num_pages
        try:
            next = pg.page.next_page_number()
        except:
            next = pageCount
        try:
            previous = pg.page.previous_page_number()
        except:
            previous = 0
            
        # 将当前的排序字段和方向也添加到返回数据中，便于前端处理
        d = dict(data=c.data, 
                 previous=previous,
                 next=next, 
                 count=count, 
                 pageCount=pageCount,
                 currentSort=sort,  # 当前排序字段
                 currentOrder=order  # 当前排序方向
                )
                
        context['data']['commodityInfos'] = d
        return Response(context)


class detailView(APIView):
    '''
    商品详情页
    '''
    authentication_classes = []
    permission_classes = []

    # GET请求
    def get(self, request, id):
        context = {'state': 'success', 'msg': '获取成功', 'data': {}}
        c = CommodityInfos.objects.filter(id=id).first()
        context['data']['commoditys'] = CommodityInfosSerializer(instance=c).data
        r = CommodityInfos.objects.exclude(id=id).order_by('-sold')[:5]
        context['data']['recommend'] = CommodityInfosSerializer(instance=r, many=True).data
        if id in request.session.get('likes', []):
            context['data']['likes'] = True
        else:
            context['data']['likes'] = False
        return Response(context)


class collectView(APIView):
    '''
    商品收藏
    '''
    authentication_classes = []
    permission_classes = []

    def post(self, request):
        json_str = json.loads(request.body.decode())
        id = json_str.get('id', '')
        context = {'state': 'fail', 'msg': '收藏失败'}
        likes = request.session.get('likes', [])
        if id and not int(id) in likes:
            # 对商品的收藏数量执行自增加1
            CommodityInfos.objects.filter(id=id).update(likes=F('likes') + 1)
            # 根据Session信息判断用户是否已收藏
            request.session['likes'] = likes + [int(id)]
            context = {'state': 'success', 'msg': '收藏成功'}
        return Response(context)
class CommoditySuggestionView(APIView):
    """
    商品搜索建议接口
    用于实现搜索框的实时提示功能
    """
    authentication_classes = []
    permission_classes = []
    def get(self, request):
        # 获取查询参数
        query = request.GET.get('q', '').strip()
        limit = request.GET.get('limit', 5)
        
        # 尝试将limit转换为整数，如果转换失败，使用默认值5
        try:
            limit = int(limit)
            # 限制最大返回数量，防止请求过大
            if limit > 20:
                limit = 20
        except (ValueError, TypeError):
            limit = 5
            
        # 如果查询字符串为空，直接返回空结果
        if not query:
            return Response({
                'state': 'success',
                'msg': '搜索关键词为空',
                'data': []
            })
            
        # 构建查询条件: 查询商品名称包含搜索关键词的商品
        # 使用Q对象进行复杂查询: 名称包含搜索词 或 类型包含搜索词
        queryset = CommodityInfos.objects.filter(
            Q(name__icontains=query) | 
            Q(types__icontains=query)
        )
        
        # 限制返回数量并优先返回有库存的商品
        # 先按照是否有库存排序(库存量大于0的排前面)，然后按照销量排序(销量高的排前面)
        queryset = queryset.filter(inventory__gt=0).order_by('-sold')[:limit]
        
        # 如果按照上面条件没有结果，就不考虑库存限制，直接按销量排序
        if not queryset.exists():
            queryset = CommodityInfos.objects.filter(
                Q(name__icontains=query) | 
                Q(types__icontains=query)
            ).order_by('-sold')[:limit]
        
        # 使用序列化器处理查询结果
        serializer = CommoditySuggestionSerializer(queryset, many=True)
        
        return Response({
            'state': 'success',
            'msg': '获取搜索建议成功',
            'data': serializer.data
        })