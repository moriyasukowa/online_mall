from django.db import models
from commodity.models import CommodityInfos
from django.contrib.auth.models import User
from django.utils import timezone

STATE = (
    ('待支付', '待支付'),
    ('已支付', '已支付'),
    ('待揽收', '待揽收'),
    ('已发货', '已发货'),
    ('已签收', '已签收'),
    ('退款中', '退款中'),
    ('退款成功', '退款成功'),
)

REFUND_STATE = (
    ('退款申请中', '退款申请中'),
    ('申请成功', '申请成功'),
    ('退款失败', '退款失败'),
    ('退货中', '退货中'),
    ('退款成功', '退款成功'),
)

class CartInfos(models.Model):
    id = models.AutoField(primary_key=True, verbose_name='购物车ID')
    quantity = models.IntegerField('购买数量', default=0)
    commodityInfos_id = models.ForeignKey(CommodityInfos, on_delete=models.SET_NULL, null=True, blank=True, verbose_name='商品')
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='用户ID')

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '购物车'
        verbose_name_plural = '购物车'

class OrderInfos(models.Model):
    id = models.AutoField(primary_key=True)
    price = models.FloatField('订单总价',default=0.0)
    created = models.DateField('创建时间', auto_now_add=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE,verbose_name='购买人')
    state = models.CharField('订单状态', max_length=20, choices=STATE ,default='已支付')
    pay_id = models.CharField('支付订单ID', max_length=50, null=True, blank=True)
    refund_id = models.CharField('退款订单ID', max_length=50, null=True, blank=True)
    address = models.ForeignKey('AddressInfos', on_delete=models.SET_NULL, null=True, blank=True,verbose_name='地址')

    def __str__(self):
        return f"{self.id}@{self.user.username if self.user else '无用户'}@{self.created.strftime('%Y-%m-%d')}@{self.get_state_display()}@{self.price}"


    class Meta:
        verbose_name = '订单信息'
        verbose_name_plural = '订单信息'

class RefundInfos(models.Model):
    id = models.AutoField(primary_key=True)
    order = models.ForeignKey(OrderInfos, on_delete=models.CASCADE, verbose_name='关联订单号')
    refund_id = models.CharField('退款订单ID', max_length=50)
    price = models.FloatField('退款金额')
    user = models.ForeignKey(User, on_delete=models.CASCADE,verbose_name='购买人')
    created = models.DateField('创建时间', auto_now_add=True)
    state = models.CharField('退款状态', max_length=20, choices=REFUND_STATE, default='退款申请中')
    reason = models.TextField('退款原因', null=True, blank=True)
    attach = models.FileField('退款凭证', upload_to=r'details', null=True, blank=True)
    status_before = models.CharField('退款前状态', max_length=20, choices=STATE, default='已支付', null=True, blank=True)

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '退款信息'
        verbose_name_plural = '退款信息'

class PurchaseInfos(models.Model):
    id = models.AutoField(primary_key=True)
    order = models.ForeignKey(OrderInfos, on_delete=models.CASCADE, null=True, blank=True)
    commodityInfos_id = models.ForeignKey(CommodityInfos, on_delete=models.CASCADE, verbose_name='商品')
    quantity = models.IntegerField('购买数量', default=0)
    unit_price = models.FloatField('单价')

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '购买信息'
        verbose_name_plural = '购买信息'

class Region(models.Model):
    """省市区三级联动基础数据"""
    name = models.CharField('名称', max_length=50)
    parent = models.ForeignKey('self', null=True, blank=True, 
                             on_delete=models.CASCADE, verbose_name='上级区域')
    level = models.PositiveSmallIntegerField('层级', choices=(
        (1, '省'), 
        (2, '市'), 
        (3, '区县')
    ))
    
    class Meta:
        verbose_name = '行政区域'
        verbose_name_plural = verbose_name
        ordering = ['level', 'id']
        
    def __str__(self):
        return self.name

class AddressInfos(models.Model):
    """用户收货地址"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='所属用户')
    province = models.ForeignKey(Region, on_delete=models.PROTECT, 
                               related_name='province_addresses',
                               limit_choices_to={'level': 1},
                               verbose_name='省')
    city = models.ForeignKey(Region, on_delete=models.PROTECT,
                            related_name='city_addresses',
                            limit_choices_to={'level': 2},
                            verbose_name='市')
    district = models.ForeignKey(Region, on_delete=models.PROTECT,
                                related_name='district_addresses',
                                limit_choices_to={'level': 3},
                                verbose_name='区县')
    detail = models.CharField('详细地址', max_length=200)
    phone_number = models.BigIntegerField('联系电话')
    recipient_name = models.CharField('收件人姓名', max_length=50)
    is_default = models.BooleanField('默认地址', default=False)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    
    class Meta:
        verbose_name = '收货地址'
        verbose_name_plural = verbose_name
        ordering = ['-is_default', '-created_at']
        
    def __str__(self):
        return f"{self.province}{self.city}{self.district}{self.detail}"
    
class RefundStockInOrder(models.Model):
    """退款入库单（关联退款单）"""
    order_number = models.CharField('退款入库单号', max_length=50, unique=True)
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, verbose_name='操作人')
    created_at = models.DateTimeField('入库时间', default=timezone.now)

    notes = models.TextField('备注', blank=True, null=True)
    status = models.CharField(
        '状态',
        max_length=20,
        choices=[
            ('completed', '已完成'),
        ],
        default='completed'
    )

    refund_orders = models.ForeignKey(
        RefundInfos,
        on_delete=models.CASCADE,
        blank=True,
        related_name='refund_stock_in_orders',
        verbose_name='关联退款单',
    )
    
    @property
    def total_quantity(self):
        """计算退款入库单的总入库数量"""
        return sum(item.quantity for item in self.items.all())

    @property
    def item_count(self):
        """返回退款入库单中商品的种类数"""
        return self.items.values('commodity').distinct().count()
    
    
    class Meta:
        verbose_name = '退款入库单'
        verbose_name_plural = '退款入库单'


class RefundStockInOrderItem(models.Model):
    """退款入库单商品项"""
    order_number = models.ForeignKey(
        RefundStockInOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='关联退款入库单'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.PROTECT,
        verbose_name='商品'
    )
    quantity = models.PositiveIntegerField('入库数量')

    class Meta:
        verbose_name = '退款入库单项'
        verbose_name_plural = '退款入库单项'
        unique_together = ('order_number', 'commodity')  # 同一退款入库单同一商品只有一项

    def __str__(self):
        return f"{self.order_number.order_number} - {self.commodity.name} x{self.quantity}"