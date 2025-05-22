from rest_framework import serializers
from .models import *
# 定义ModelSerializer类
class CartInfosSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartInfos
        fields = '__all__'
        # 参数depth是根据外键关联实现序列化嵌套功能
        depth = 1

class OrderInfosSerializer(serializers.ModelSerializer):
    items = serializers.SerializerMethodField()
    class Meta:
        model = OrderInfos
        fields = '__all__'
    def get_items(self, obj):
        """
        这个方法默认返回空列表，实际的商品项数据会在视图中手动添加
        """
        return []

    
# serializers.py
from .models import AddressInfos, Region

class RegionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Region
        fields = ['id', 'name']

class AddressSerializer(serializers.ModelSerializer):
    province = RegionSerializer(read_only=True)
    city = RegionSerializer(read_only=True)
    district = RegionSerializer(read_only=True)
    
    class Meta:
        model = AddressInfos
        fields = ['id', 'recipient_name', 'phone_number', 'province', 'city', 
                 'district', 'detail', 'is_default', 'created_at']

class AddressCreateUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = AddressInfos
        fields = ['recipient_name', 'phone_number', 'province', 'city', 
                 'district', 'detail', 'is_default']
class PurchaseInfosSerializer(serializers.ModelSerializer):
    """购买信息序列化器"""
 
    class Meta:
        model = PurchaseInfos
        fields = '__all__'  
        depth = 1  # 嵌套序列化