import json
import time
from django.contrib.auth import logout, login, authenticate
from django.shortcuts import get_object_or_404
from django.views import View
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authentication import SessionAuthentication
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from .models import *
from .form import *
from .pays import get_pay
from .serializers import OrderInfosSerializer, CartInfosSerializer, PurchaseInfosSerializer, AddressSerializer
from .refunds import refund
from django.db.models import Q
from django.http import Http404, JsonResponse

class MySessionAuthentication(SessionAuthentication):
    '''
    自定义SessionAuthentication，取消CSRF验证
    '''
    def authenticate(self, request):
        user = getattr(request._request, 'user', None)
        if not user or not user.is_active:
            return None
        return (user, None)


class loginView(APIView):
    '''
    用户登录与注册
    '''
    # 取消所有认证
    authentication_classes = []
    permission_classes = []

    def post(self, request):
        context = {'state': 'fail', 'msg': '注册或登录失败'}
        json_str = json.loads(request.body.decode())
        infos = LoginModelForm(data=json_str)
        d = infos.data
        username = d['username']
        password = d['password']
        last_login = ''
        # 用户存在则进行登录验证
        if User.objects.filter(username=username).first():
            user = authenticate(username=username, password=password)
            if user:
                login(request, user)
                last_login = user.last_login
                context = {'state': 'success', 'msg': '登录成功'}
        else:
            # 用户不存在进行用户注册
            context = {'state': 'success', 'msg': '注册成功'}
            d = dict(username=username, password=password, is_staff=1, is_active=1)
            user = User.objects.create_user(**d)
            user.save()
            login(request, user)
        context['username'] = username
        context['last_login'] = last_login
        return Response(context)


class logoutView(APIView):
    '''
    退出用户登录
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        context = {'state': 'fail', 'msg': '退出失败'}
        # 使用内置函数logout退出用户登录状态
        if request.user.username:
            logout(request)
            context = {'state': 'success', 'msg': '退出成功'}
        return Response(context)


class shopperView(APIView):
    '''
    个人中心
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]
    def get(self, request):
        context = {'state': 'success', 'msg': '获取成功', 'data': {}}
        t = request.GET.get('t', '')
        payTime = request.session.get('payTime', '')
        print(request.session.get('payInfo', ''))
        
        # 从Session获取并处理已支付的订单信息，写入订单信息表
        if t and payTime and t == payTime:
            payInfo = request.session.get('payInfo', '')
            
            # 提取商品项信息并从payInfo中移除，因为OrderInfos表中没有items字段
            items = payInfo.pop('items', [])
            
            # 处理address_id，将其转换为address外键
            address_id = payInfo.pop('address_id', None)
            if address_id:
                try:
                    address = AddressInfos.objects.get(id=address_id)
                    payInfo['address'] = address
                except AddressInfos.DoesNotExist:
                    pass  # 如果地址不存在，则不设置address字段
            
            # 将user_id转换为user外键
            user_id = payInfo.pop('user_id', None)
            if user_id:
                try:
                    user = User.objects.get(id=user_id)
                    payInfo['user'] = user
                except User.DoesNotExist:
                    payInfo['user'] = request.user
            else:
                payInfo['user'] = request.user
            print('订单：',payInfo)
            # 创建订单记录
            order = OrderInfos.objects.create(**payInfo)
            
            # 创建订单商品项记录
            for item in items:

                try:
                    commodity_id = item.get('commodity_id')
                    quantity = item.get('quantity', 1)
                    
                    # 获取商品信息
                    commodity = CommodityInfos.objects.get(id=commodity_id)
                    print('商品项',order,commodity,quantity,commodity.price)
                    # 创建购买信息记录
                    PurchaseInfos.objects.create(
                        order=order,
                        commodityInfos_id=commodity,
                        quantity=quantity,
                        unit_price=commodity.price
                    )
                    commodity.sold = commodity.sold + quantity  # 更新商品销量
                    commodity.save()
                except CommodityInfos.DoesNotExist:
                    continue  # 如果商品不存在，跳过此项
                except Exception as e:
                    print(f"Error creating purchase info: {e}")
            
            # 清除session中的支付信息
            del request.session['payTime']
            del request.session['payInfo']
        
        # 根据当前用户查询用户所有订单信息
        orders = OrderInfos.objects.filter(user=request.user).order_by('-created').all()
        
        # 为每个订单添加商品项信息
        orders_data = OrderInfosSerializer(instance=orders, many=True).data
        for i, order in enumerate(orders):
            purchase_items = PurchaseInfos.objects.filter(order=order)
            orders_data[i]['items'] = PurchaseInfosSerializer(instance=purchase_items, many=True).data
        
        context['data']['orders'] = orders_data
        return Response(context)


class shopcartView(APIView):
    '''
    GET：获取购物车列表
    POST：商品加入购物车
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        context = {'state': 'success', 'msg': '获取成功', 'data': []}
        # 根据当前用户信息查找对应购物车信息
        c = CartInfos.objects.filter(user_id=request.user.id).all()
        context['data'] = CartInfosSerializer(instance=c, many=True).data
        return Response(context)

    def post(self, request):
        context = {'state': 'fail', 'msg': '加购失败'}
        json_str = json.loads(request.body.decode())
        id = json_str.get('id', '')
        quantity = json_str.get('quantity', 1)
        userID = request.user.id
        commodityInfos = CommodityInfos.objects.filter(id=id).first()
        # 根据请求信息写入购物车
        if id and commodityInfos and quantity:
            d = dict(commodityInfos_id=commodityInfos, user_id=userID, quantity=quantity)
            f = dict(commodityInfos_id=commodityInfos, user_id=userID)
            CartInfos.objects.update_or_create(d, **f)
            context = {'state': 'success', 'msg': '加购成功'}
        return Response(context)


class paysView(APIView):
    '''
    支付接口
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        context = {'state': 'fail', 'msg': '支付失败', 'data': ''}
        json_str = json.loads(request.body.decode())
        total = json_str.get('total', 0)
        total = float(str(total).replace('￥', ''))            
        print(json_str)
        if total:
            out_trade_no = str(int(time.time()))
            print(out_trade_no)
            user_id = request.user.id
            payInfo = dict(price=total, user_id=user_id, state='已支付', pay_id=out_trade_no, address_id = json_str.get('address_id', ''), items = json_str.get('items', []))
            # 将支付信息存入Session，方便后续处理
            request.session['payInfo'] = payInfo
            request.session['payTime'] = out_trade_no
            # return_url为前端的路由地址
            # 如果无法确认路由地址，前端可以通过请求参数传递
            return_url = 'http://localhost:8010/#/shopper'
            data = get_pay(out_trade_no, total, return_url)
            print('testdata',data)
            context = {'state': 'success', 'msg': '支付成功', 'data': data}
        return Response(context)


class deleteView(APIView):
    '''
    购物车删除商品
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        context = {'state': 'success', 'msg': '删除成功'}
        json_str = json.loads(request.body.decode())
        username = json_str.get('username', '')
        carId = json_str.get('carId', '')
        # 根据请求信息删除购物车信息
        if username:
            CartInfos.objects.filter(user_id=request.user.id).delete()
        elif carId:
            CartInfos.objects.filter(id=carId).delete()
        else:
            context = {'state': 'fail', 'msg': '删除失败'}
        return Response(context)

class refundView(APIView):
    '''
    退款接口
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        print(request.body)
        context = {'state': 'fail', 'msg': '退款失败', 'data': ''}
        json_str = json.loads(request.body.decode())
        order_id = json_str.get('order_id', '')
        if order_id:
            order = OrderInfos.objects.filter(id=order_id, user_id=request.user.id).first()
            if order and order.state == '已支付':
                return_url = 'http://localhost:8010/#/shopper'
                refund_data = refund(order.pay_id, order.price, return_url)  # 调用退款函数
                if refund_data.get('state') == 'success':
                    order.state = '退款成功'
                    order.save()
                    context = {'state': 'success', 'msg': '退款成功', 'data': refund_data}
                else:
                    context['msg'] = refund_data.get('msg', '退款失败')
        return Response(context)

class getView(APIView):
    '''
    通过订单ID查询订单信息
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        context = {'state': 'fail', 'msg': '查询失败', 'data': ''}
        order_id = request.GET.get('order_id', '')
        if order_id:
            order = OrderInfos.objects.filter(id=order_id, user_id=request.user.id).first()
            if order:
                context = {'state': 'success', 'msg': '查询成功', 'data': OrderInfosSerializer(instance=order).data}
        return Response(context)
    
class updateOrderStatusView(APIView):
    '''
    更新订单状态
    '''
    authentication_classes = [MySessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        context = {'state': 'fail', 'msg': '更新失败'}
        json_str = json.loads(request.body.decode())
        order_id = json_str.get('order_id', '')
        new_status = json_str.get('status', '')
        if order_id and new_status:
            order = OrderInfos.objects.filter(id=order_id, user_id=request.user.id).first()
            if order:
                order.state = new_status
                order.save()
                context = {'state': 'success', 'msg': '更新成功'}
        return Response(context)
    
class AddressSearchAPIView(View):
    def get(self, request, *args, **kwargs):
        term = request.GET.get('term', '')
        page = request.GET.get('page', 1) # Select2 可能发送页码
        # 你可以根据需要实现分页逻辑，或者返回少量结果让 Select2 处理

        results = []
        if len(term) == 0:
            for address in AddressInfos.objects.all():
                full_address_str = f"{address.province}{address.city}{address.district}{address.detail}"
                results.append({
                    'id': address.id,
                    'name': address.recipient_name,
                    'phone': str(address.phone_number), # 确保是字符串
                    'full_address': full_address_str,
                    'text': f"{address.recipient_name} ({address.phone_number})"
                })
            return JsonResponse({'results': results})
        if term:
            # 查询逻辑：同时搜索姓名、电话、详细地址
            query = (
                Q(recipient_name__icontains=term) |
                Q(phone_number__icontains=term) |
                Q(detail__icontains=term) |
                # 可以根据需要加入省市区的搜索
                Q(province__name__icontains=term) |
                Q(city__name__icontains=term) |
                Q(district__name__icontains=term)
            )
            addresses = AddressInfos.objects.filter(query).select_related('province', 'city', 'district')[:20] # 限制结果数量

            for address in addresses:
                full_address_str = f"{address.province}{address.city}{address.district}{address.detail}"
                results.append({
                    'id': address.id,
                    'name': address.recipient_name,
                    'phone': str(address.phone_number), # 确保是字符串
                    'full_address': full_address_str,
                    # 'text' 字段是 Select2 processResults 中方便使用的，也可以在前端生成
                    'text': f"{address.recipient_name} ({address.phone_number})"
                })

        return JsonResponse({'results': results})
    
from django.http import JsonResponse
from .models import OrderInfos, PurchaseInfos

def get_sales_order_items(request):
    """获取销售订单的商品项信息"""
    order_id = request.GET.get('order_id')
    try:
        order = OrderInfos.objects.get(id=order_id)
        items = PurchaseInfos.objects.filter(order=order)
        
        response_data = {
            'order_number': order.id,
            'items': [
                {
                    'commodity_id': item.commodityInfos_id.id,
                    'name': str(item.commodityInfos_id.name),
                    'unit_price': float(item.unit_price) if item.unit_price else 0,
                    'quantity': item.quantity
                }
                for item in items
            ]
        }
        return JsonResponse(response_data)
    except OrderInfos.DoesNotExist:
        return JsonResponse({'error': '销售订单不存在'}, status=404)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# views.py
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import SessionAuthentication
from rest_framework.response import Response
from rest_framework import status
from django.db import transaction
from .models import AddressInfos, Region
from .serializers import AddressSerializer, AddressCreateUpdateSerializer

@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def address_list_create(request):
    """获取地址列表或创建新地址"""
    if request.method == 'GET':
        # 获取当前用户的所有地址
        addresses = AddressInfos.objects.filter(user=request.user)
        serializer = AddressSerializer(addresses, many=True)
        return Response({
            'state': 'success',
            'data': {
                'addresses': serializer.data
            }
        })
    
    elif request.method == 'POST':
        # 创建新地址
        serializer = AddressCreateUpdateSerializer(data=request.data)
        if serializer.is_valid():
            # 如果设置为默认地址，需要将其他地址设为非默认
            with transaction.atomic():
                if serializer.validated_data.get('is_default', False):
                    AddressInfos.objects.filter(user=request.user).update(is_default=False)
                
                # 保存新地址
                address = serializer.save(user=request.user)
                
                # 如果这是用户的第一个地址，自动设为默认
                if AddressInfos.objects.filter(user=request.user).count() == 1:
                    address.is_default = True
                    address.save()
                
            return Response({
                'state': 'success',
                'msg': '地址添加成功',
                'data': AddressSerializer(address).data
            })
        
        return Response({
            'state': 'error',
            'msg': '数据验证失败',
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def address_detail(request, pk):
    """获取、更新或删除单个地址"""
    try:
        address = AddressInfos.objects.get(id=pk, user=request.user)
    except AddressInfos.DoesNotExist:
        return Response({
            'state': 'error',
            'msg': '地址不存在'
        }, status=status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET':
        serializer = AddressSerializer(address)
        return Response({
            'state': 'success',
            'data': serializer.data
        })
    
    elif request.method == 'PUT':
        serializer = AddressCreateUpdateSerializer(address, data=request.data)
        if serializer.is_valid():
            # 如果设置为默认地址，需要将其他地址设为非默认
            with transaction.atomic():
                if serializer.validated_data.get('is_default', False):
                    AddressInfos.objects.filter(user=request.user).exclude(id=pk).update(is_default=False)
                
                # 保存更新后的地址
                updated_address = serializer.save()
            
            return Response({
                'state': 'success',
                'msg': '地址更新成功',
                'data': AddressSerializer(updated_address).data
            })
        
        return Response({
            'state': 'error',
            'msg': '数据验证失败',
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'DELETE':
        was_default = address.is_default
        address.delete()
        
        # 如果删除的是默认地址，且还有其他地址，则将第一个地址设为默认
        if was_default:
            remaining = AddressInfos.objects.filter(user=request.user).first()
            if remaining:
                remaining.is_default = True
                remaining.save()
        
        return Response({
            'state': 'success',
            'msg': '地址删除成功'
        })

@api_view(['POST', 'GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def set_default_address(request):
    """设置默认地址"""
    address_id = request.data.get('address_id')
    
    if not address_id:
        return Response({
            'state': 'error',
            'msg': '地址ID不能为空'
        }, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        # 获取当前用户的所有地址
        with transaction.atomic():
            # 先将该用户的所有地址设为非默认
            AddressInfos.objects.filter(user=request.user).update(is_default=False)
            
            # 再将指定地址设为默认
            address = AddressInfos.objects.get(id=address_id, user=request.user)
            address.is_default = True
            address.save()
            
        return Response({
            'state': 'success',
            'msg': '默认地址设置成功'
        })
    
    except AddressInfos.DoesNotExist:
        return Response({
            'state': 'error',
            'msg': '地址不存在'
        }, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({
            'state': 'error',
            'msg': f'设置失败: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def get_default_address(request):
    """获取默认地址"""
    try:
        # 先尝试获取默认地址
        address = AddressInfos.objects.filter(user=request.user, is_default=True).first()
        
        # 如果没有默认地址，则获取最新的地址
        if not address:
            address = AddressInfos.objects.filter(user=request.user).first()
        
        if address:
            serializer = AddressSerializer(address)
            return Response({
                'state': 'success',
                'data': serializer.data
            })
        else:
            return Response({
                'state': 'success',
                'data': None,
                'msg': '没有找到地址'
            })
    
    except Exception as e:
        return Response({
            'state': 'error',
            'msg': f'获取失败: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# --- 新增的 OrderDetailView ---
class OrderDetailView(APIView):
    '''
    获取单个订单详情
    URL: /api/v1/shopper/orders/<int:pk>/
    '<int:pk>' 会作为参数 pk 传递给 get 方法
    '''
    # 使用与 shopperView 相同的认证和权限
    authentication_classes = [MySessionAuthentication, BasicAuthentication] # 保持一致
    permission_classes = [IsAuthenticated]
    def get(self, request, pk): # 'pk' 来自 URL 中定义的 <int:pk>
        """
        处理获取单个订单详情的 GET 请求
        """
        context = {'state': 'fail', 'msg': '', 'data': {}}
        try:
            # 1. 获取订单对象，同时检查订单是否属于当前用户
            order = get_object_or_404(OrderInfos, id=pk, user=request.user)
            # 2. 获取与订单关联的商品项 (PurchaseInfos)
            purchase_items = PurchaseInfos.objects.filter(order=order)
            # 3. 序列化数据
            order_serializer = OrderInfosSerializer(order)
            items_serializer = PurchaseInfosSerializer(purchase_items, many=True)
            
            # 订单模型中应该有关联到 AddressInfos 的外键，例如 'address'
            # 注意：确保 OrderInfosSerializer 也能正确处理 address 字段（可能需要嵌套 AddressInfosSerializer）
            # 如果 OrderInfosSerializer 内部没有处理地址，则需要单独序列化
            address_data = None
            if order.address: # 假设 OrderInfos 模型有 address 字段关联 AddressInfos
                address_serializer = AddressSerializer(order.address)
                address_data = address_serializer.data
            # 4. 组装返回的数据结构
            context['data'] = {
                'order': order_serializer.data,
                'items': items_serializer.data,
                'address': address_data # 直接使用 address_data (可能是序列化后的 dict 或 None)
            }
            context['state'] = 'success'
            context['msg'] = '获取订单详情成功'
            print('订单详情',context['data'])
            return Response(context, status=status.HTTP_200_OK)
        except Http404: # 由 get_object_or_404 抛出
            context['msg'] = '订单不存在或您无权访问该订单'
            return Response(context, status=status.HTTP_404_NOT_FOUND)
        
        except Exception as e:
            # 捕获其他潜在错误
            print(f"Error fetching order detail for order {pk}: {e}") # 打印错误日志方便调试
            context['msg'] = f'获取订单详情时发生错误: {e}'
            return Response(context, status=status.HTTP_500_INTERNAL_SERVER_ERROR)