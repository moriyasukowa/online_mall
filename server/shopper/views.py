import json
import time
from django.contrib.auth import logout, login, authenticate
from django.shortcuts import get_object_or_404
from django.views import View
from django.utils import timezone
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
from shopper.admin import RefundInfosAdmin
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

class LoginView(APIView):
    '''
    用户登录视图
    接收 POST 请求: {'username': 'xxx', 'password': 'yyy'}
    '''
    authentication_classes = []  # 通常登录接口不需要预认证
    permission_classes = []      # 公开访问
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        context = {'state': 'fail', 'msg': '登录失败'}
        if not username or not password:
            context['msg'] = '用户名和密码不能为空'
            return Response(context, status=400) # Bad Request
        user = authenticate(request, username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                # 更新 last_login 时间戳 (Django 会在 authenticate 成功时自动更新)
                # user.last_login = timezone.now() # Django 1.10+ 自动处理
                # user.save(update_fields=['last_login'])
                
                # 确保 last_login 存在并且格式化 (前端可能需要特定格式)
                last_login_str = user.last_login.strftime('%Y-%m-%d %H:%M:%S') if user.last_login else ''
                
                context = {
                    'state': 'success',
                    'msg': '登录成功',
                    'username': user.username,
                    'last_login': last_login_str
                }
                return Response(context)
            else:
                context['msg'] = '账户已被禁用'
                return Response(context, status=403) # Forbidden
        else:
            context['msg'] = '用户名或密码错误'
            return Response(context, status=401) # Unauthorized (more specific than 400)
class RegisterView(APIView):
    '''
    用户注册视图
    接收 POST 请求: {'username': 'xxx', 'password': 'yyy', 'password2': 'yyy'}
    前端还会发送 captcha_code 和 captcha_text，但根据你的要求后端简化逻辑，暂时不处理验证码
    '''
    authentication_classes = []
    permission_classes = []
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        password2 = request.data.get('password2') # 从前端 Register.vue 获取
        # captcha_code = request.data.get('captcha_code') # 预留给验证码
        # captcha_text = request.data.get('captcha_text') # 预留给验证码
        context = {'state': 'fail', 'msg': '注册失败'}
        if not all([username, password, password2]):
            context['msg'] = '手机号和密码不能为空'
            return Response(context, status=400)
        # 1. 验证手机号格式 (虽然前端验证，后端最好也验证)
        #    这里简化，假设前端验证有效
        #    一个简单的例子：
        #    import re
        #    if not re.match(r"^1[3-9]\d{9}$", username):
        #        context['msg'] = '手机号格式不正确'
        #        return Response(context, status=400)
        # 2. 验证两次密码是否一致
        if password != password2:
            context['msg'] = '两次输入的密码不一致'
            return Response(context, status=400)
        # 3. 检查用户名（手机号）是否已存在
        if User.objects.filter(username=username).exists():
            context['msg'] = '该手机号已被注册'
            return Response(context, status=409) # Conflict
        # 4. 创建用户 (根据你原始逻辑，新用户也设为 is_staff=1, is_active=1)
        try:
            # Django的create_user会自动处理密码哈希
            user = User.objects.create_user(
                username=username,
                password=password,
                is_staff=True, # 与你原逻辑一致
                is_active=True  # 与你原逻辑一致
            )
            # user.save() # create_user 已经保存
            # 注册后自动登录 (根据你原始逻辑)
            login(request, user)
            
            last_login_str = user.last_login.strftime('%Y-%m-%d %H:%M:%S') if user.last_login else ''
            context = {
                'state': 'success',
                'msg': '注册成功',
                'username': user.username,
                'last_login': last_login_str # 注册后首次登录，last_login可能是None或当前时间
            }
            return Response(context, status=201) # Created
        except Exception as e:
            # print(e) # for debugging
            context['msg'] = f'创建用户时发生错误: {str(e)[:50]}' # 避免暴露过多错误细节
            return Response(context, status=500) # Internal Server Error


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
        print("增加订单信息",request.body)

        context = {'state': 'success', 'msg': '获取成功', 'data': {}}
        t = request.GET.get('t', '')
        payTime = request.session.get('payTime', '')
        print("支付信息",request.session.get('payInfo', ''))
        print("支付时间",payTime, "校验时间", t)
        # 从Session获取并处理已支付的订单信息，写入订单信息表
        if payTime:
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
        print("支付信息",request.body)
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
from logistics.models import LogisticsOrder, PurchaseOrder, PurchaseOrderItem
def get_purchase_order_items(request):
    """获取采购订单的商品项信息"""
    order_id = request.GET.get('order_id')
    try:
        order = PurchaseOrder.objects.get(id=order_id)
        items = PurchaseOrderItem.objects.filter(order=order)
        
        response_data = {
            'order_number': order.id,
            'items': [
                {
                    'commodity_id': item.commodity.id,
                    'name': str(item.commodity.name),
                    'unit_price': float(item.unit_price) if item.unit_price else 0,
                    'quantity': item.quantity_actual
                }
                for item in items
            ]
        }
        return JsonResponse(response_data)
    except PurchaseOrder.DoesNotExist:
        return JsonResponse({'error': '采购订单不存在'}, status=404)
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
        

# --- 新增的 AdminOrderDetailView (供管理员使用) ---
class AdminOrderDetailView(APIView):
    '''
    (管理员) 获取单个订单详情 - 无需用户验证
    URL: (需要单独配置, 例如 /api/v1/admin/orders/<int:pk>/)
    '<int:pk>' 会作为参数 pk 传递给 get 方法
    '''
    # 移除认证和权限类，允许任何访问
    authentication_classes = []
    permission_classes = []

    def get(self, request, pk): # 'pk' 来自 URL 中定义的 <int:pk>
        """
        处理获取单个订单详情的 GET 请求 (管理员)
        """
        context = {'state': 'fail', 'msg': '', 'data': {}}
        try:
            # 1. 获取订单对象，仅通过 ID 查询，不检查用户
            order = get_object_or_404(OrderInfos, id=pk) # <--- 修改这里，移除了 user=request.user
            
            # 2. 获取与订单关联的商品项 (PurchaseInfos)
            purchase_items = PurchaseInfos.objects.filter(order=order)
            
            # 3. 序列化数据
            order_serializer = OrderInfosSerializer(order)
            items_serializer = PurchaseInfosSerializer(purchase_items, many=True)

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
            # print('管理员查询订单详情', context['data']) # 可以取消注释用于调试
            return Response(context, status=status.HTTP_200_OK)
        
        except Http404: # 由 get_object_or_404 抛出
            context['msg'] = f'ID 为 {pk} 的订单不存在' # 修改错误消息
            return Response(context, status=status.HTTP_404_NOT_FOUND)
        
        except Exception as e:
            # 捕获其他潜在错误
            print(f"Error fetching order detail (admin) for order {pk}: {e}") # 打印错误日志方便调试
            context['msg'] = f'获取订单详情时发生错误: {e}'
            return Response(context, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ... rest of your views.py code ...
@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def get_refund_info(request, order_id):
    """获取指定订单的退款信息"""
    try:
        # 确保订单属于当前用户
        order = get_object_or_404(OrderInfos, id=order_id, user=request.user)
        
        # 查找与订单关联的退款信息
        refund = RefundInfos.objects.filter(order=order).first()
        
        if refund:
            # 构建退款信息响应
            refund_data = {
                'id': refund.id,
                'refund_id': refund.refund_id,
                'price': refund.price,
                'created': refund.created.strftime('%Y-%m-%d'),
                'state': refund.state,
                'reason': refund.reason,
                'attach': request.build_absolute_uri(refund.attach.url) if refund.attach else None,
                'status_before': refund.status_before
            }
            
            return JsonResponse({
                'state': 'success',
                'data': refund_data
            })
        else:
            # 没有找到退款信息
            return JsonResponse({
                'state': 'success',
                'data': None
            })
            
    except Exception as e:
        return JsonResponse({
            'state': 'error',
            'msg': f'获取退款信息失败: {str(e)}'
        }, status=500)

def generate_refund_id():
    """按照Admin后台相同的逻辑生成退款单号"""
    today = timezone.now().date()
    date_str = today.strftime('%Y%m%d')
    
    last_refund = RefundInfos.objects.filter(
        refund_id__startswith=f'RF-{date_str}-'
    ).order_by('-refund_id').first()
    if last_refund:
        last_num = int(last_refund.refund_id.split('-')[-1])
        new_num = last_num + 1
    else:
        new_num = 1
        
    return f'RF-{date_str}-{new_num:03d}'

@api_view(['POST'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def apply_refund(request):
    """提交退款申请"""
    try:
        # 获取表单数据
        order_id = request.POST.get('order_id')
        price = float(request.POST.get('price', 0))
        reason = request.POST.get('reason', '')
        attach_file = request.FILES.get('attach')
        
        # 获取订单信息
        order = get_object_or_404(OrderInfos, id=order_id, user=request.user)
        
        # 检查是否已有退款申请
        existing_refund = RefundInfos.objects.filter(order=order).first()
        if existing_refund:
            return JsonResponse({
                'state': 'error',
                'msg': '该订单已有退款申请，请勿重复提交'
            })
        
        # 检查退款金额是否合理
        if price <= 0 or price > order.price:
            return JsonResponse({
                'state': 'error',
                'msg': f'退款金额无效，应在0-{order.price}之间'
            })
        
        # 生成退款单号
        refund_id = generate_refund_id()
        
        # 根据订单状态确定处理方式
        response_code = 0
        new_order_state = ''
        refund_state = ''
        
        if order.state in ['待支付', '已支付', '待揽收']:
            # 直接通过申请
            new_order_state = '退款成功'
            refund_state = '退款成功'
            response_code = 1
        elif order.state == '已签收':
            # 提交申请，等待审核
            new_order_state = '退款成功'
            refund_state = '退款申请中'
            response_code = 2
        else:
            # 其他状态不允许申请退款
            return JsonResponse({
                'state': 'error',
                'msg': f'当前订单状态"{order.state}"不支持申请退款'
            })
        
        # 保存退款信息
        refund = RefundInfos(
            order=order,
            refund_id=refund_id,
            price=price,
            user=request.user,
            state=refund_state,
            reason=reason,
            attach=attach_file,
            status_before=order.state
        )
        refund.save()
        
        # 更新订单状态
        order.state = new_order_state
        order.refund_id = refund_id
        order.save()
        
        return JsonResponse({
            'state': 'success',
            'msg': '退款申请提交成功',
            'code': response_code,
            'data': {
                'refund_id': refund_id,
                'order_state': new_order_state,
                'refund_state': refund_state
            }
        })
        
    except OrderInfos.DoesNotExist:
        return JsonResponse({
            'state': 'error',
            'msg': '订单不存在或不属于当前用户'
        }, status=404)
    except ValueError as e:
        return JsonResponse({
            'state': 'error',
            'msg': f'参数错误: {str(e)}'
        }, status=400)
    except Exception as e:
        return JsonResponse({
            'state': 'error',
            'msg': f'退款申请提交失败: {str(e)}'
        }, status=500)


def get_customer_order_details(request):
    """
    获取客户订单 (OrderInfos) 的详细信息，用于自动填充表单。
    包括客户的收货地址和关联的商品项 (来自 PurchaseInfos)。
    """
    order_id = request.GET.get('order_id') # 从 GET 请求中获取订单 ID
    if not order_id:
        return JsonResponse({'error': '未提供订单 ID'}, status=400)

    try:
        # 1. 查询指定的客户订单，同时预加载关联的地址
        #    使用 select_related 优化地址查询
        order = OrderInfos.objects.select_related('address').get(id=order_id)

        # 2. 准备地址信息
        address_data = None
        if order.address:
            address_data = {
                'id': order.address.id,
                # 使用地址模型的 __str__ 方法，或自定义更详细的表示
                'text': str(order.address)
            }

        # 3. 准备商品项信息 (根据你提供的逻辑修改)
        #    查询关联的 PurchaseInfos 记录
        #    使用 select_related 预加载商品信息 (假设 commodityInfos_id 指向商品模型)
        items_queryset = PurchaseInfos.objects.filter(order=order).select_related('commodityInfos_id') # 使用 select_related('commodityInfos_id') 优化

        items_data = []
        for item in items_queryset:
             # 检查关联的商品信息是否存在
             # 注意：这里的字段名是 commodityInfos_id
            if item.commodityInfos_id:
                items_data.append({
                    # 使用 item.commodityInfos_id.id 获取商品 ID
                    'commodity_id': item.commodityInfos_id.id,
                    # 使用 str(item.commodityInfos_id) 或 item.commodityInfos_id.name 获取商品名称/描述
                    'name': str(item.commodityInfos_id), # 假设商品模型有 __str__ 方法
                    'quantity': item.quantity,
                    # 如果需要单价，也可以从 item.unit_price 获取
                    # 'unit_price': float(item.unit_price) if item.unit_price else 0,
                })
            else:
                print(f"警告: PurchaseInfo ID {item.id} 关联的 commodityInfos_id 为空或无效。") # 调试信息


        # 4. 构建完整的响应数据
        response_data = {
            'address': address_data, # 包含收货地址信息
            'items': items_data      # 包含从 PurchaseInfos 获取的商品项列表
        }
        return JsonResponse(response_data)

    except OrderInfos.DoesNotExist:
        return JsonResponse({'error': '客户订单不存在'}, status=404)
    # 可以保留之前的其他异常捕获
    except Exception as e:
        print(f"获取客户订单详情时出错: {e}") # 记录日志
        import traceback
        traceback.print_exc() # 打印详细的错误堆栈
        return JsonResponse({'error': f'发生服务器内部错误: {e}'}, status=500)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
@authentication_classes([MySessionAuthentication, BasicAuthentication])
def confirm_order_delivery(request, order_id):
    """
    确认订单签收。
    同时更新订单状态和关联的物流单状态。
    """
    try:
        with transaction.atomic():  # 使用事务确保数据一致性
            # 1. 获取订单并验证状态
            order = OrderInfos.objects.select_for_update().get(id=order_id)
            
            # 检查订单当前状态是否允许签收
            if order.state != '已发货':  # 请根据实际的状态值调整
                return JsonResponse({
                    'error': f'当前订单状态（{order.state}）不允许签收确认'
                }, status=400)
            # 2. 查找关联的物流单
            # 使用物流单模型中的外键反向查询
            logistics_orders = LogisticsOrder.objects.select_for_update().filter(
                order_infos=order  # 使用物流单模型中定义的外键字段名
            )
            
            if not logistics_orders.exists():
                return JsonResponse({
                    'error': '未找到关联的物流单'
                }, status=400)
            # 3. 更新订单状态
            order.state = '已签收'  # 请根据实际的状态值调整
            order.save(update_fields=['state'])
            # 4. 更新所有关联的物流单状态
            current_time = timezone.now()
            logistics_orders.update(
                status='delivered',  # 请根据实际的状态值调整
                actual_delivery=current_time  # 假设物流单模型中有 actual_delivery 字段
            )
            return JsonResponse({
                'message': '订单签收确认成功',
                'order_id': order_id,
                'status': 'delivered',
                'logistics_orders_updated': logistics_orders.count(),
                'state': 'success'
            })
    except OrderInfos.DoesNotExist:
        return JsonResponse({
            'error': '订单不存在'
        }, status=404)
    
    except Exception as e:
        # 记录错误日志
        print(f"确认订单签收时发生错误 (Order ID: {order_id}): {e}")
        import traceback
        traceback.print_exc()
        
        return JsonResponse({
            'error': '服务器处理请求时发生错误'
        }, status=500)
    
# --- 新增的 AdminOrderDetailView (供管理员使用) ---
class AdminOrderDetailViewRF(APIView):
    '''
    (管理员) 获取单个订单详情 - 无需用户验证
    URL: (需要单独配置, 例如 /api/v1/admin/orders/<int:pk>/)
    '<int:pk>' 会作为参数 pk 传递给 get 方法
    '''
    # 移除认证和权限类，允许任何访问
    authentication_classes = []
    permission_classes = []

    def get(self, request, pk): # 'pk' 来自 URL 中定义的 <int:pk>
        """
        处理获取单个订单详情的 GET 请求 (管理员)
        """
        context = {'state': 'fail', 'msg': '', 'data': {}}
        try:
            # 1. 获取订单对象，仅通过 ID 查询，不检查用户
            refund_order = get_object_or_404(RefundInfos, id=pk) # <--- 修改这里，移除了 user=request.user

            order = refund_order.order # 获取关联的订单对象
            
            # 2. 获取与订单关联的商品项 (PurchaseInfos)
            purchase_items = PurchaseInfos.objects.filter(order=order)
            
            # 3. 序列化数据
            order_serializer = OrderInfosSerializer(order)
            items_serializer = PurchaseInfosSerializer(purchase_items, many=True)

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
            # print('管理员查询订单详情', context['data']) # 可以取消注释用于调试
            return Response(context, status=status.HTTP_200_OK)
        
        except Http404: # 由 get_object_or_404 抛出
            context['msg'] = f'ID 为 {pk} 的订单不存在' # 修改错误消息
            return Response(context, status=status.HTTP_404_NOT_FOUND)
        
        except Exception as e:
            # 捕获其他潜在错误
            print(f"Error fetching order detail (admin) for order {pk}: {e}") # 打印错误日志方便调试
            context['msg'] = f'获取订单详情时发生错误: {e}'
            return Response(context, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
