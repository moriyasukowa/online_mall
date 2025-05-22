from rest_framework import serializers
from .models import *
# 定义ModelSerializer类
class TypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Types
        fields = '__all__'

class CommodityInfosSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommodityInfos
        fields = '__all__'


class CommoditySuggestionSerializer(serializers.ModelSerializer):
    """
    商品搜索建议的序列化器
    只返回搜索下拉框中需要的字段
    """
    class Meta:
        model = CommodityInfos
        fields = ['id', 'name', 'price', 'discount', 'img', 'sold', 'inventory']
        
    def to_representation(self, instance):
        """
        自定义序列化表示
        处理图片URL等特殊字段
        """
        representation = super().to_representation(instance)
        
        # 如果img是FileField，获取URL
        if representation['img'] and hasattr(instance.img, 'url'):
            representation['img'] = instance.img.url
            
        return representation
