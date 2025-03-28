# logistics/models.py
from django.db import models
from commodity.models import CommodityInfos  # 假设商品模型在commodity应用中
from shopper.models import User  # 假设用户模型在shopper应用中
from shopper.models import OrderInfos  # 假设订单模型在shopper应用中
from django.core.exceptions import ValidationError


class ProcurementOrder(models.Model):
    """采购订单"""
    order_number = models.CharField('采购单号', max_length=50, unique=True)
    supplier = models.CharField('供应商', max_length=100)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='创建人')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    status = models.CharField(
        '状态',
        max_length=20,
        choices=[
            ('pending', '待审核'),
            ('approved', '已批准'),
            ('completed', '已完成'),
        ],
        default='pending'
    )

    class Meta:
        verbose_name = '采购订单'
        verbose_name_plural = '采购订单'
    
    def __str__(self):
        return f"订单号：{self.order_number}"

    @property
    def total_quantity(self):
        """计算订单的总采购数量"""
        return sum(item.quantity for item in self.items.all())

    @property
    def item_count(self):
        """返回订单中商品的种类数"""
        return self.items.count()

class ProcurementOrderItem(models.Model):
    """采购订单商品项"""
    order = models.ForeignKey(
        ProcurementOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='采购订单'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.CASCADE,
        verbose_name='商品'
    )
    quantity = models.PositiveIntegerField('采购数量')

    class Meta:
        verbose_name = '采购订单项'
        verbose_name_plural = '采购订单项'

    def __str__(self):
        return f"{self.order.order_number} - {self.commodity.name} x{self.quantity}"


class PurchaseOrder(models.Model):
    """采购订单"""
    order_number = models.CharField('采购单号', max_length=50, unique=True)
    procurement_plan = models.ForeignKey(ProcurementOrder, on_delete=models.CASCADE, verbose_name='关联采购计划',null=True,blank=True)
    commodity = models.ForeignKey(CommodityInfos, on_delete=models.CASCADE, verbose_name='商品')
    quantity = models.IntegerField('计划采购数量')
    actual_quantity = models.IntegerField('实际采购数量')
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='创建人')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    supplier = models.CharField('供应商', max_length=100)

    status = models.CharField(
        '状态',
        max_length=20,
        choices=[
            ('pending', '待执行'),
            ('completed', '已完成'),
        ],
        default='pending'
    )

    class Meta:
        verbose_name = '采购订单'
        verbose_name_plural = '采购订单'

    def __str__(self):
        return f"采购订单 {self.order_number} - {self.procurement_plan.commodity.name}"

class OutboundOrder(models.Model):
    """出库单"""
    order_number = models.CharField('出库单号', max_length=50, unique=True)
    commodity = models.ForeignKey(CommodityInfos, on_delete=models.CASCADE, verbose_name='商品')
    quantity = models.IntegerField('出库数量')
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='操作人')
    created_at = models.DateTimeField('出库时间', auto_now_add=True)
    
    # 新增多对多字段，关联到 OrderInfo（假设订单模型在 shopper 应用中）
    orders = models.ManyToManyField(
        OrderInfos, 
        through="OutboundOrderItem",  # 使用中间表
        verbose_name='关联订单'
    )

    class Meta:
        verbose_name = '出库'
        verbose_name_plural = '出库'

class OutboundOrderItem(models.Model):
    """中间表：记录出库单与订单的关联关系及拣选状态"""
    outbound_order = models.ForeignKey(OutboundOrder, on_delete=models.CASCADE)
    order = models.ForeignKey(OrderInfos, on_delete=models.CASCADE)
    is_picked = models.BooleanField('是否已拣选', default=False)  # 可扩展更多字段
    
    class Meta:
        verbose_name = '中间表：出库单与订单关联关系'
        verbose_name_plural = '中间表：出库单与订单关联关系'
        unique_together = [('outbound_order', 'order')]  # 防止重复关联

class LogisticsOrder(models.Model):
    """物流单（可关联采购单或客户订单，二选一）"""
    tracking_number = models.CharField('物流单号', max_length=50, unique=True)
    
    # 关联采购单（采购物品）
    purchase_order = models.ForeignKey(
        'logistics.PurchaseOrder', 
        on_delete=models.CASCADE, 
        verbose_name='关联采购单', 
        null=True, 
        blank=True
    )
    
    # 关联客户订单（给客户发货）
    order_info = models.ForeignKey(
        OrderInfos, 
        on_delete=models.CASCADE, 
        verbose_name='关联客户订单', 
        null=True, 
        blank=True
    )

    # 其他字段保持不变
    carrier = models.CharField('承运商', max_length=100)
    status = models.CharField(
        '物流状态',
        max_length=20,
        choices=[
            ('preparing', '准备中'),
            ('shipped', '已发货'),
            ('delivered', '已签收'),
        ],
        default='preparing'
    )
    estimated_delivery = models.DateField('预计送达日期')
    actual_delivery = models.DateField('实际送达日期', null=True, blank=True)

    def clean(self):
        """验证必须关联采购单或客户订单之一，但不能同时关联两者"""
        if not (self.purchase_order or self.order_info):
            raise ValidationError("物流单必须关联采购单或客户订单")
        if self.purchase_order and self.order_info:
            raise ValidationError("物流单不能同时关联采购单和客户订单")

    class Meta:
        verbose_name = '物流信息'
        verbose_name_plural = '物流信息'
        constraints = [
            models.CheckConstraint(
                check=(
                    models.Q(purchase_order__isnull=False, order_info__isnull=True) | 
                    models.Q(purchase_order__isnull=True, order_info__isnull=False)
                ),
                name='check_purchase_or_order'
            )
        ]

class StockInOrder(models.Model):
    """入库单（可关联采购单或客户订单，二选一）"""
    stock_in_number = models.CharField('入库单号', max_length=50, unique=True)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='操作人')
    created_at = models.DateTimeField('入库时间', auto_now_add=True)
    quantity = models.IntegerField('入库数量')
    notes = models.TextField('备注', blank=True)
    
    # 关联采购单（采购入库）
    purchase_order = models.ForeignKey(
        PurchaseOrder, 
        on_delete=models.CASCADE, 
        verbose_name='关联采购单', 
        null=True, 
        blank=True
    )
    
    # 关联客户订单（退货入库）
    order_info = models.ForeignKey(
        OrderInfos, 
        on_delete=models.CASCADE, 
        verbose_name='关联客户订单', 
        null=True, 
        blank=True
    )

    def clean(self):
        """验证必须关联采购单或客户订单之一，但不能同时关联两者"""
        if not (self.purchase_order or self.order_info):
            raise ValidationError("入库单必须关联采购单或客户订单")
        if self.purchase_order and self.order_info:
            raise ValidationError("入库单不能同时关联采购单和客户订单")

    class Meta:
        verbose_name = '入库'
        verbose_name_plural = '入库'
        constraints = [
            models.CheckConstraint(
                check=(
                    models.Q(purchase_order__isnull=False, order_info__isnull=True) | 
                    models.Q(purchase_order__isnull=True, order_info__isnull=False)
                ),
                name='check_stockin_purchase_or_order'
            )
        ]

    def __str__(self):
        return self.stock_in_number
