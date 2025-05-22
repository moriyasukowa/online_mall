import random
import django
import datetime
import os
from django.utils import timezone
from decimal import Decimal
from django.db import transaction

# 设置 Django 环境
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'server.settings')  # 替换为您的项目名称
django.setup()

# 导入需要的模型
from django.contrib.auth.models import User
from commodity.models import CommodityInfos  # 替换为您的应用名称
from shopper.models import OrderInfos, PurchaseInfos, AddressInfos
def generate_random_orders(order_count=100):
    """
    生成随机的已支付订单和相应的购买信息
    """
    # 预先定义的 IDs
    address_ids = [1, 2, 4, 5, 9, 11, 12]
    commodity_ids = list(range(1, 9))  # 从1到8
    user_ids = list(range(1, 22))  # 从1到21
    
    # 获取真实的数据库记录以确保外键正确
    addresses = list(AddressInfos.objects.filter(id__in=address_ids))
    commodities = list(CommodityInfos.objects.filter(id__in=commodity_ids))
    users = list(User.objects.filter(id__in=user_ids))
    
    if not addresses or not commodities or not users:
        print("警告: 部分预定义的ID在数据库中不存在。请检查您的数据库记录。")
        if not addresses:
            print(f"找不到地址ID: {address_ids}")
        if not commodities:
            print(f"找不到商品ID: {commodity_ids}")
        if not users:
            print(f"找不到用户ID: {user_ids}")
        return

    orders_created = 0
    purchase_items_created = 0
    
    # 生成过去30天内的随机日期
    today = timezone.now().date()
    
    with transaction.atomic():  # 使用事务确保数据一致性
        for _ in range(order_count):
            # 随机选择用户和地址
            user = random.choice(users)
            address = random.choice(addresses)
            
            # 为该订单生成1-5个随机购买项
            item_count = random.randint(1, 5)
            selected_commodities = random.sample(commodities, min(item_count, len(commodities)))
            
            # 生成随机日期 (过去30天内)
            random_days = random.randint(0, 30)
            order_date = today - datetime.timedelta(days=random_days)
            
            # 计算总价格
            total_price = 0
            purchase_items = []
            
            for commodity in selected_commodities:
                quantity = random.randint(1, 3)
                # 使用当前商品价格或随机价格
                unit_price = getattr(commodity, 'price', random.uniform(50, 1000))
                item_price = quantity * unit_price
                total_price += item_price
                
                purchase_items.append({
                    'commodity': commodity,
                    'quantity': quantity,
                    'unit_price': unit_price
                })
            
            # 创建订单
            pay_id = f"{int(timezone.now().timestamp())}{random.randint(1000, 9999)}"
            order = OrderInfos(
                price=total_price,
                created=order_date,
                user=user,
                state='已支付',
                pay_id=pay_id,
                address=address
            )
            order.save()
            orders_created += 1
            
            # 创建购买信息
            for item in purchase_items:
                purchase_info = PurchaseInfos(
                    order=order,
                    commodityInfos_id=item['commodity'],
                    quantity=item['quantity'],
                    unit_price=item['unit_price']
                )
                purchase_info.save()
                purchase_items_created += 1
            
            # 打印进度
            if orders_created % 10 == 0:
                print(f"已创建 {orders_created} 个订单...")
    
    print(f"成功创建 {orders_created} 个订单，共 {purchase_items_created} 个购买项。")

if __name__ == "__main__":
    print("开始生成随机订单...")
    generate_random_orders(100)
    print("订单生成完成！")
