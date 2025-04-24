# logistics/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PurchaseOrderViewSet,
    OutboundOrderViewSet,
)

router = DefaultRouter()
router.register(r'purchase-orders', PurchaseOrderViewSet)
router.register(r'outbound-orders', OutboundOrderViewSet)


urlpatterns = [path('', include(router.urls)),]
from django.http import JsonResponse
from .models import OutboundOrder, PurchaseOrder, ProcurementOrder, ProcurementOrderItem

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
    
def get_purchase_order(request):
    """获取采购订单的详细信息，包括供应商和商品项"""
    order_id = request.GET.get('order_id')
    try:
        order = PurchaseOrder.objects.get(id=order_id)
        items = order.items.all()
        
        # 准备响应数据
        response_data = {
            'supplier': str(order.supplier) if order.supplier else None,
            'items': [
                {
                    'commodity_id': item.commodity.id,
                    'name' : str(item.commodity) if item.commodity else None,
                    'unit_price': float(item.unit_price) if item.unit_price else 0,
                    'quantity': item.quantity_plan
                }
                for item in items
            ]   
        }
        return JsonResponse(response_data)
    except PurchaseOrder.DoesNotExist:
        return JsonResponse({'error': '采购订单不存在'}, status=404)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
    
def get_outbound_order(request):
    """获取出库订单的详细信息，包括供应商和商品项"""
    order_id = request.GET.get('order_id')
    try:
        order = OutboundOrder.objects.get(id=order_id)
        items = order.items.all()
        sales_orders = order.sales_orders.all()  # 添加.all()来获取关联对象列表
        print([order.id for order in sales_orders])
        # 准备响应数据
        response_data = {
            'sales_orders': [
                {
                    'id' : order.id,
                    'address' : order.address.id,
                    'address_str': str(order.province) + str(order.city) + str(order.district) + str(order.detail)
                }
                for order in sales_orders
            ],
            'items': [
                {
                    'commodity_id': item.commodity.id,
                    'name' : str(item.commodity) if item.commodity else None,  
                    'quantity': item.quantity
                }   
                for item in items
            ]   
        }
        return JsonResponse(response_data)
    except OutboundOrder.DoesNotExist:
        return JsonResponse({'error': '出库订单不存在'}, status=404)
    except Exception as e: 
        return JsonResponse({'error': str(e)}, status=500)
    
# logistics/views.py
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from django.db.models import Prefetch
from .models import OutboundOrder, OrderInfos, OutboundOrderItem

def get_orders_of_outbound_order(request):

    order_id = request.GET.get('order_id')
    if not order_id:
        return JsonResponse({'error': '缺少order_id参数'}, status=400)

    try:
        # 获取出库订单，并预取关联数据
        order = get_object_or_404(
            OutboundOrder.objects.prefetch_related(
                Prefetch('sales_orders', queryset=OrderInfos.objects.select_related('user', 'address'))),
            id=order_id
        )
        
        # 获取出库单中的商品项
        items = order.items.all().select_related('commodity')
        
        # 准备响应数据
        response_data = {
            'order_number': order.order_number,
            'status': {
                'value': order.status,
                'display': order.get_status_display()
            },
            'created_at': order.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            'outbound_date': order.outbound_date.strftime('%Y-%m-%d %H:%M:%S'),
            'created_by': {
                'id': order.created_by.id,
                'username': order.created_by.username
            },
            'notes': order.notes,
            'total_quantity': order.total_quantity,
            'item_count': order.item_count,
            'sales_orders': [
                {
                    'id': so.id,
                    'price': so.price,
                    'created': so.created.strftime('%Y-%m-%d'),
                    'user': {
                        'id': so.user.id,
                        'username': so.user.username
                    },
                    'state': {
                        'value': so.state,
                        'display': so.get_state_display()
                    },
                    'pay_id': so.pay_id,
                    'refund_id': so.refund_id,
                    'address': {
                        'id': so.address.id,
                        'full_address': str(so.address) if so.address else None
                    } if so.address else None
                }
                for so in order.sales_orders.all()
            ],
            'items': [
                {
                    'id': item.id,
                    'commodity': {
                        'id': item.commodity.id,
                        'name': str(item.commodity),
                        # 可根据需要添加更多商品字段
                    },
                    'quantity': item.quantity,
                    # 可根据需要添加更多商品项字段
                }
                for item in items
            ]
        }
        
        return JsonResponse(response_data)
        
    except OutboundOrder.DoesNotExist:
        return JsonResponse({'error': '出库订单不存在'}, status=404)
    except Exception as e:
        return JsonResponse({'error': f'服务器错误: {str(e)}'}, status=500)