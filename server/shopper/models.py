from django.db import models
from commodity.models import CommodityInfos
from django.contrib.auth.models import User

STATE = (
    ('待支付', '待支付'),
    ('已支付', '已支付'),
    ('发货中', '发货中'),
    ('已签收', '已签收'),
    ('退货中', '退货中'),
    ('退款成功', '退款成功'),
)

REFUND_STATE = (
    ('退款申请中', '退款申请中'),
    ('退款失败', '退款失败'),
    ('退货中', '退货中'),
    ('退款成功', '退款成功'),
)

class CartInfos(models.Model):
    id = models.AutoField(primary_key=True)
    quantity = models.IntegerField('购买数量')
    commodityInfos_id = models.ForeignKey(CommodityInfos, on_delete=models.SET_NULL, null=True, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '购物车'
        verbose_name_plural = '购物车'

class OrderInfos(models.Model):
    id = models.AutoField(primary_key=True)
    price = models.FloatField('订单总价')
    created = models.DateField('创建时间', auto_now_add=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    state = models.CharField('订单状态', max_length=20, choices=STATE)
    pay_id = models.CharField('支付订单ID', max_length=50, null=True, blank=True)
    refund_id = models.CharField('退款订单ID', max_length=50, null=True, blank=True)

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '订单信息'
        verbose_name_plural = '订单信息'

class RefundInfos(models.Model):
    id = models.AutoField(primary_key=True)
    order = models.ForeignKey(OrderInfos, on_delete=models.CASCADE)
    refund_id = models.CharField('退款订单ID', max_length=50)
    price = models.FloatField('退款金额')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created = models.DateField('创建时间', auto_now_add=True)
    state = models.CharField('退款状态', max_length=20, choices=REFUND_STATE)
    reason = models.TextField('退款原因')
    attach = models.FileField('退款凭证', upload_to=r'details')

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '退款信息'
        verbose_name_plural = '退款信息'

class AddressInfos(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField('收货人', max_length=50)
    phone = models.CharField('联系电话', max_length=20)
    address = models.TextField('收货地址')
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '收货地址'
        verbose_name_plural = '收货地址'

class PurchaseInfos(models.Model):
    id = models.AutoField(primary_key=True)
    order = models.ForeignKey(OrderInfos, on_delete=models.SET_NULL, null=True, blank=True)
    commodityInfos_id = models.ForeignKey(CommodityInfos, on_delete=models.SET_NULL, null=True, blank=True)
    quantity = models.IntegerField('购买数量')
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '购买信息'
        verbose_name_plural = '购买信息'