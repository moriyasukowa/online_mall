# logistics/models.py
from django.db import models
from commodity.models import CommodityInfos
from shopper.models import User, OrderInfos, RefundInfos, AddressInfos
from django.core.exceptions import ValidationError
from django.utils import timezone
from datetime import timedelta

# 定义一个函数来计算默认的到期日期
def get_default_due_date():
    """返回当前时间加上3天"""
    return timezone.now() + timedelta(days=7)


class ProcurementOrder(models.Model):
    """采购订单"""
    order_number = models.CharField('采购单号', max_length=50, unique=True)
    supplier = models.CharField('供应商', max_length=100)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='创建人')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    due_date = models.DateTimeField(
        '计划完成日期',
        default=get_default_due_date  # 使用上面定义的函数作为默认值
    )
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
        verbose_name = '采购计划'
        verbose_name_plural = '采购计划'

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
    """采购计划商品项"""
    order = models.ForeignKey(
        ProcurementOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='采购计划'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.CASCADE,
        verbose_name='商品'
    )
    unit_price = models.DecimalField(verbose_name='采购单价', max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField('采购数量')

    class Meta:
        verbose_name = '采购订单项'
        verbose_name_plural = '采购订单项'

    def __str__(self):
        return f"{self.order.order_number} - {self.commodity.name} x{self.quantity}"


class PurchaseOrder(models.Model):
    """采购订单"""
    order_number = models.CharField('采购单号', max_length=50, unique=True)
    procurement_plan = models.ForeignKey(ProcurementOrder, on_delete=models.CASCADE, verbose_name='关联采购计划', null=True, blank=True)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='创建人')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    supplier = models.CharField('供应商', max_length=100)
    due_date = models.DateTimeField(
        '计划完成日期',
        default=get_default_due_date  # 使用上面定义的函数作为默认值
    )
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
        return f"订单号：{self.order_number}"

    @property
    def total_quantity(self):
        """计算订单的总采购数量"""
        return sum(item.quantity_actual for item in self.items.all())

    @property
    def item_count(self):
        """返回订单中商品的种类数"""
        return self.items.count()


class PurchaseOrderItem(models.Model):
    """采购订单商品项"""
    order = models.ForeignKey(
        PurchaseOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='采购订单'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.CASCADE,
        verbose_name='商品'
    )
    unit_price = models.DecimalField(verbose_name='采购单价', max_digits=10, decimal_places=2)
    quantity_plan = models.PositiveIntegerField('计划采购数量')
    quantity_actual = models.PositiveIntegerField('实际采购数量', default=0)  # 实际采购数量

    class Meta:
        verbose_name = '采购订单项'
        verbose_name_plural = '采购订单项'

    def __str__(self):
        return f"{self.order.order_number} - {self.commodity.name} x{self.quantity_actual}"


class OutboundOrder(models.Model):
    """销售出库单"""
    order_number = models.CharField('出库单号', max_length=50, unique=True)
    sales_orders = models.ManyToManyField(  # 改为多对多关系
        OrderInfos,
        related_name='outbound_orders',
        verbose_name='关联销售订单',
    )
    created_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='操作人',
    )
    created_at = models.DateTimeField('创建时间', default=timezone.now)
    outbound_date = models.DateTimeField('实际出库时间', default=timezone.now)
    status = models.CharField(
        '状态',
        max_length=20,
        choices=[
            ('pending', '待揽收'),
            ('shipped', '已发货'),
            ('completed', '已完成'),
        ],
        default='pending'
    )
    notes = models.TextField('备注', blank=True, null=True)

    class Meta:
        verbose_name = '销售出库单'
        verbose_name_plural = '销售出库单'
        ordering = ['-created_at']

    def __str__(self):
        # 显示关联的销售订单数量
        return f"出库单号: {self.order_number} (关联销售单数: {self.sales_orders.count()})"

    @property
    def total_quantity(self):
        """计算出库单的总出库数量"""
        return sum(item.quantity for item in self.items.all())

    @property
    def item_count(self):
        """返回出库单中商品的种类数"""
        return self.items.count()

    @property
    def related_order_numbers(self):
        """获取所有关联销售订单号的字符串表示"""
        return ", ".join([str(order.id) for order in self.sales_orders.all()])


class OutboundOrderItem(models.Model):
    """出库单商品项"""
    order_number = models.ForeignKey(  # 字段名改为更清晰的outbound_order
        OutboundOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='关联出库单'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.CASCADE,
        verbose_name='商品'
    )
    quantity = models.PositiveIntegerField('出库数量')
    # 新增字段，记录这个商品项来自哪个销售订单
    source_order = models.ForeignKey(
        OrderInfos,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name='来源销售订单'
    )

    class Meta:
        verbose_name = '出库单项'
        verbose_name_plural = '出库单项'

    def __str__(self):
        commodity_name = self.commodity.name if self.commodity else '未知商品'
        return f"{self.order_number.order_number} - {commodity_name} x{self.quantity}"


class LogisticsOrder(models.Model):
    """物流单（可关联采购、出库或退款）"""
    tracking_number = models.CharField('物流单号', max_length=50, unique=True)
    carrier = models.CharField('承运商', max_length=100, default='顺丰速递')
    status = models.CharField(
        '物流状态',
        max_length=20,
        choices=[
            ('shipped', '已发货'),
            ('delivered', '已签收'),
        ],
        default='shipped'
    )
    estimated_delivery = models.DateField('预计送达日期', null=True, blank=True, default=get_default_due_date())
    actual_delivery = models.DateField('实际送达日期', null=True, blank=True)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    notes = models.TextField('备注', blank=True, null=True)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='操作人')
    destination_address = models.ForeignKey(
        AddressInfos,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name='目的地地址',
        related_name='logistics_destinations'  # 添加这一行
    )
    origin_address = models.ForeignKey(
        AddressInfos,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name='发货地址',
        related_name='logistics_origins',  # 添加这一行
        default=11  # 修改默认值的写法
    )


    # 关联来源单据 (三选一)
    purchase_order = models.ForeignKey(
        PurchaseOrder,
        on_delete=models.SET_NULL,  # 或 CASCADE，根据业务逻辑决定删除采购单时如何处理物流单
        verbose_name='关联采购单',
        null=True,
        blank=True,
        related_name='logistics_orders'
    )
    outbound_order = models.ForeignKey(
        OutboundOrder,
        on_delete=models.SET_NULL,  # 或 CASCADE
        verbose_name='关联出库单',
        null=True,
        blank=True,
        related_name='logistics_orders'
    )

    order_infos = models.ForeignKey(
        OrderInfos,
        on_delete=models.SET_NULL,  # 或 CASCADE
        verbose_name='关联销售单',
        null=True,
        blank=True,
        related_name='logistics_orders'
    )

    refund_info = models.ForeignKey(
        RefundInfos,
        on_delete=models.SET_NULL,  # 或 CASCADE
        verbose_name='关联退款单',
        null=True,
        blank=True,
        related_name='logistics_orders'
    )

    def clean(self):
        """验证必须且仅能关联一个来源单据"""
        linked_sources = sum([
            self.purchase_order is not None,
            self.outbound_order is not None,
            self.refund_info is not None
        ])
        if linked_sources == 0:
            raise ValidationError("物流单必须关联一个来源单据（采购单、出库单或退款单）")
        if linked_sources > 1:
            raise ValidationError("物流单只能关联一个来源单据")

    class Meta:
        verbose_name = '物流单'
        verbose_name_plural = '物流单'
        ordering = ['-created_at']
        
    def __str__(self):
        source = ""
        if self.purchase_order:
            source = f"采购单: {self.purchase_order.order_number}"
        elif self.outbound_order:
            source = f"出库单: {self.outbound_order.order_number}: 销售单: {self.order_infos.id}"
        elif self.refund_info:
            source = f"退款单: {self.refund_info.refund_id}"
        return f"物流单: {self.tracking_number} ({source})"

    @property
    def total_quantity(self):
        """计算物流单的总商品数量"""
        return sum(item.quantity for item in self.items.all())

    @property
    def item_count(self):
        """返回物流单中商品的种类数"""
        return self.items.values('commodity').distinct().count()


class LogisticsOrderItem(models.Model):
    """物流单商品项"""
    logistics_order = models.ForeignKey(
        LogisticsOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='关联物流单'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.PROTECT,  # 防止商品被删除导致物流信息不完整
        verbose_name='商品'
    )
    quantity = models.PositiveIntegerField('数量')

    class Meta:
        verbose_name = '物流单项'
        verbose_name_plural = '物流单项'
        unique_together = ('logistics_order', 'commodity')  # 同一物流单同一商品只有一项

    def __str__(self):
        return f"{self.logistics_order.tracking_number} - {self.commodity.name} x{self.quantity}"


class StockInOrder(models.Model):
    """入库单（可关联采购单或退款单）"""
    stock_in_number = models.CharField('入库单号', max_length=50, unique=True)
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, verbose_name='操作人')
    created_at = models.DateTimeField('入库时间', default=timezone.now)
    notes = models.TextField('备注', blank=True, null=True)
    status = models.CharField(
        '状态',
        max_length=20,
        choices=[
            ('pending', '待处理'),
            ('completed', '已完成'),
        ],
        default='completed'
    )

    sales_orders = models.ManyToManyField(  # 改为多对多关系
        LogisticsOrder,
        related_name='logistics_orders',
        verbose_name='关联物流单',
    )

    @property
    def total_quantity(self):
        """计算入库单的总入库数量"""
        return sum(item.quantity for item in self.items.all())

    @property
    def item_count(self):
        """返回入库单中商品的种类数"""
        return self.items.values('commodity').distinct().count()
    
    
    class Meta:
        verbose_name = '入库单'
        verbose_name_plural = '入库单'


class StockInOrderItem(models.Model):
    """入库单商品项"""
    stock_in_order = models.ForeignKey(
        StockInOrder,
        on_delete=models.CASCADE,
        related_name='items',
        verbose_name='关联入库单'
    )
    commodity = models.ForeignKey(
        CommodityInfos,
        on_delete=models.PROTECT,
        verbose_name='商品'
    )
    quantity = models.PositiveIntegerField('入库数量')
    reason = models.CharField('入库原因', max_length=40, blank=True, null=True)  # 入库原因

    class Meta:
        verbose_name = '入库单项'
        verbose_name_plural = '入库单项'
        unique_together = ('stock_in_order', 'commodity')  # 同一入库单同一商品只有一项

    def __str__(self):
        return f"{self.stock_in_order.stock_in_number} - {self.commodity.name} x{self.quantity}"

