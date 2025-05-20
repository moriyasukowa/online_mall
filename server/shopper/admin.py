from django.contrib import admin
from django.forms import ValidationError
from .models import *
from django.contrib import messages
from django.urls import path, reverse
from django.http import HttpResponseRedirect
from django.utils.html import format_html
from shopper.form import AddressInfosForm
from django.utils import timezone
from django.db import IntegrityError, transaction

class PurchaseInfosInline(admin.TabularInline):
    model = PurchaseInfos
    fields = ('commodityInfos_id', 'quantity', 'unit_price')
    autocomplete_fields = ['commodityInfos_id']
    extra = 1
    min_num = 1
    verbose_name = '购买商品'
    verbose_name_plural = '购买商品列表'
    class Media:
        css = {
            'all': (
                'shopper/css/select_table.css',
            )
        }

        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/complete_price_shopper.js',
            'shopper/js/shopper_s2_table.js',
        )

@admin.register(OrderInfos)
class OrderInfosAdmin(admin.ModelAdmin):
    class Media:
        css = {
            'all': (
                'shopper/css/inline_commodity.css',
                'shopper/css/address_select2-table.css',
            )
        }

        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/cal_price.js',
            'shopper/js/address_select_table2.js',
        )
    list_display = ('id', 'user_info', 'price', 'state', 'created', 'address')
    list_filter = ('state', 'created')
    search_fields = ('id', 'user__username', 'pay_id')
    autocomplete_fields = ['address']
    inlines = [PurchaseInfosInline]
    date_hierarchy = 'created'
    list_per_page = 20
    fields = ('user', 'state', 'price','pay_id','address',)
    list_editable = ('state', 'address')
    # 自定义方法：显示用户信息

    def user_info(self, obj):
        if obj.user:
            url = reverse('admin:auth_user_change', args=[obj.user.id])
            return format_html('<a href="{}">{}</a>', url, obj.user.username)
        return "-"
    user_info.short_description = '用户'
    def state_display(self, obj):
        color_map = {
            '待支付': 'orange',
            '已支付': 'green',
            '发货中': 'blue',
            '已签收': 'purple',
            '退货中': 'red',
            '退款成功': 'gray'
        }
        color = color_map.get(obj.state, 'black')
        return format_html(
            '<span style="color: {}; font-weight: bold;">{}</span>',
            color,
            obj.get_state_display()
        )
    state_display.short_description = '订单状态'
    def order_actions(self, obj):
        buttons = []
        if obj.state == 'unpaid':
            buttons.append(
                '<a class="button" href="{}">标记为已支付</a>'.format(
                    reverse('admin:mark_order_paid', args=[obj.id])
                )
            )
        elif obj.state == 'paid':
            buttons.append(
                '<a class="button" href="{}">发货</a>'.format(
                    reverse('admin:mark_order_shipped', args=[obj.id])
                )
            )
        return format_html(' '.join(buttons))
    order_actions.short_description = '操作'
    order_actions.allow_tags = True

    # 获取查询集优化
    def get_queryset(self, request):
        return super().get_queryset(request).select_related('user', 'address')


@admin.register(AddressInfos)
class AddressInfosAdmin(admin.ModelAdmin):
    form = AddressInfosForm
    list_display = ('user', 'province_city_district', 'detail', 'phone_number', 'recipient_name', 'is_default')
    list_editable = ('detail', 'phone_number', 'recipient_name', 'is_default')

    list_filter = ('province', 'city')
    search_fields = ('user__username', 'detail', 'phone_number', 'recipient_name')
    raw_id_fields = ('user',)
    autocomplete_fields = ['user']

    def province_city_district(self, obj):
        return f"{obj.province} {obj.city} {obj.district}"
    province_city_district.short_description = '省市区'
    
    class Media:
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/address_selector.js',  # 三级联动JS
        )
        css = {
            'all': (
                'shopper/css/addressinfo_admin_custom.css',
            )
        }

@admin.register(Region)
class RegionAdmin(admin.ModelAdmin):
    list_display = ('name', 'parent', 'level')
    list_filter = ('level',)
    search_fields = ('name',)

@admin.register(RefundInfos)
class RefundInfosAdmin(admin.ModelAdmin):
    class Media:
        css = {
            'all': (
                'shopper/css/select_table.css',
                'shopper/css/order_table.css',

            )
        }

        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'shopper/js/refund_autocomplete2.js',
            'shopper/js/order_table.js',
        )   
    list_display = ['refund_id', 'created', 'state', 'price', 'reason', 'status_before']

    list_editable = ['state',]
    list_filter = ['state']
    date_hierarchy = 'created'
    autocomplete_fields = ['order']
    
    search_fields = ['refund_id', 'order__user__username']
    list_per_page = 20
    actions = ['approve_refund', 'reject_refund']

    def get_changeform_initial_data(self, request):
        """设置新建表单的初始值"""
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'refund_id': self.generate_initial_refund_id(request),
            'reason' : "管理员后台操作"
        })
        return initial

    def generate_initial_refund_id(self, request):
        """生成建议订单号（用户可覆盖）"""
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        
        last_order = RefundInfos.objects.filter(
            refund_id__startswith=f'RF-{date_str}-'
        ).order_by('-refund_id').first()

        if last_order:
            last_num = int(last_order.refund_id.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
            
        return f'RF-{date_str}-{new_num:03d}'

    def save_model(self, request, obj, form, change):
        """保存模型并更新关联订单状态"""
        is_new = not change
        original_state = None
        if not is_new:
            original_state = RefundInfos.objects.get(pk=obj.pk).state

        super().save_model(request, obj, form, change)

        if is_new and obj.order:
            if obj.order.state not in ['退款中', '退款成功']:
                obj.status_before = obj.order.state
                obj.order.state = '退款中'
                obj.save(update_fields=['status_before'])
                obj.order.save(update_fields=['state'])
                self.message_user(request, f"订单 {obj.order.id} 状态已更新为退款中。", messages.SUCCESS)
        elif not is_new and obj.state != original_state:
            if obj.state == '退款成功' and obj.order and obj.order.state != '退款成功':
                obj.order.state = '退款成功'
                obj.order.save(update_fields=['state'])
                self.message_user(request, f"订单 {obj.order.id} 状态已更新为退款成功。", messages.SUCCESS)
            elif obj.state == '退款失败' and obj.order and obj.status_before:
                obj.order.state = obj.status_before
                obj.order.save(update_fields=['state'])
                self.message_user(request, f"订单 {obj.order.id} 状态已恢复为 {obj.order.get_state_display()}", messages.SUCCESS)

    @transaction.atomic
    def approve_refund(self, request, queryset):
        """批准退款申请"""
        updated_count = 0
        for refund in queryset.filter(state='退款申请中'):
            if refund.order:
                if refund.status_before != '已签收':
                    refund.state = '退款成功'
                    refund.order.state = '退款成功'
                    refund.save(update_fields=['state'])
                    refund.order.save(update_fields=['state'])
                    updated_count += 1
                else:
                    refund.state = '退货中'
                    refund.save(update_fields=['state'])
                    updated_count += 1
        if updated_count > 0:
            self.message_user(request, f"{updated_count} 个退款申请已处理。", messages.SUCCESS)
        else:
            self.message_user(request, "没有符合条件的退款申请可供处理。", messages.WARNING)
    approve_refund.short_description = "批准选中的退款申请"

    @transaction.atomic
    def reject_refund(self, request, queryset):
        """驳回退款申请"""
        updated_count = 0
        for refund in queryset.filter(state='退款申请中'):
            if refund.order and refund.status_before:
                refund.state = '退款失败'
                refund.order.state = refund.status_before
                refund.save(update_fields=['state'])
                refund.order.save(update_fields=['state'])
                updated_count += 1
        if updated_count > 0:
            self.message_user(request, f"{updated_count} 个退款申请已被驳回。", messages.SUCCESS)
        else:
            self.message_user(request, "没有符合条件的退款申请可供驳回。", messages.WARNING)
    reject_refund.short_description = "驳回选中的退款申请"


@admin.register(CartInfos)
class CartInfosAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'commodityInfos_id', 'quantity')
    search_fields = ('user__username', 'commodityInfos_id__name') # Assuming CommodityInfos has a 'name' field
    autocomplete_fields = ('user', 'commodityInfos_id')
    list_editable = ('quantity',)
    list_per_page = 20

    def get_queryset(self, request):
        # Optimize query by prefetching related user and commodity info
        return super().get_queryset(request).select_related('user', 'commodityInfos_id')
class RefundStockInOrderItemInline(admin.TabularInline):
    class Media:
        css = {
            'all': (
                'admin/css/vendor/select2/select2.css',
                'admin/css/vendor/select2/select2.min.css',
                'logistics/css/select_table.css',
            )
        }
        js = (
            'admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/select2_table.js',
        )
    model = RefundStockInOrderItem
    extra = 1
    autocomplete_fields = ['commodity']
    fields = ['commodity', 'quantity']
    min_num = 1
    verbose_name = "入库单商品项"
    verbose_name_plural = "入库单商品项"
@admin.register(RefundStockInOrder)
class RefundStockInOrderAdmin(admin.ModelAdmin):
    class Media:
        css = {
            'all': (
                    'logistics/css/custom_inline.css',
                    'logistics/css/custom_filter_horizontal.css',
                    'logistics/css/inbound_custom.css',)
        }
        js = ('admin/js/vendor/jquery/jquery.js',
            'admin/js/vendor/select2/select2.full.js',
            'admin/js/jquery.init.js',
            'logistics/js/pinbound_custom.js',
            'logistics/js/inbound_complete.js',
            )
        
    list_display = ['order_number', 'status', 'created_by', 'created_at', 
                    'total_quantity', 'item_count']
    list_filter = ['status', 'created_at', 'created_by']
    search_fields = ['order_number', 'notes']
    autocomplete_fields = ['refund_orders'] 
    inlines = [RefundStockInOrderItemInline]
    fields = ['order_number', 'status', 'created_by', 'created_at','refund_orders','notes']


    def get_changeform_initial_data(self, request):
        initial = super().get_changeform_initial_data(request)
        initial.update({
            'created_by': request.user,
            'order_number': self.generate_initial_order_number(request)
        })
        return initial

    def generate_initial_order_number(self, request):
        today = timezone.now().date()
        date_str = today.strftime('%Y%m%d')
        last_order = RefundStockInOrder.objects.filter(order_number__startswith=f'PSO-{date_str}-').order_by('-order_number').first()
        if last_order:
            last_num = int(last_order.order_number.split('-')[-1])
            new_num = last_num + 1
        else:
            new_num = 1
        return f'PSO-{date_str}-{new_num:03d}'
    
    def item_count(self, obj):
        return obj.item_count
    item_count.short_description = '商品种类数'

    def total_quantity(self, obj):
        return obj.total_quantity
    total_quantity.short_description = '总出库数量'

    def save_model(self, request, obj, form, change):
        with transaction.atomic():
            # 先保存出库单（但不提交事务）
            super().save_model(request, obj, form, change)
            
            # 获取表单中提交的销售订单ID列表
            if 'refund_orders' in form.cleaned_data:
                purchase_order_ids = [order.order_number for order in form.cleaned_data['refund_orders']]
                
                # 更新这些订单的状态
                updated_count = OrderInfos.objects.filter(
                    order_number__in=purchase_order_ids
                ).update(state='completed')
                
                # 添加操作成功的消息
                messages.success(
                    request, 
                    f'成功创建入库单，并更新其关联的{updated_count}采购单状态为"已完成"'
                )
                
                # 确保多对多关系被保存（Django通常会自动处理）
                form.save_m2m()
            else:
                messages.warning(
                    request, 
                    '出库单创建成功，但没有关联任何销售订单'
                )

    # --- save_related for inventory increase and PO status update ---
    def save_related(self, request, form, formsets, change):

        super().save_related(request, form, formsets, change)

        obj = form.instance

        items_to_process = obj.items.all() # IMPORTANT: Check related_name



        if not items_to_process.exists():
            messages.warning(request, f"入库单 {obj.order_number} 没有包含任何商品明细，未执行库存增加或采购单状态更新。")
            return # Exit if no items

        try:
            with transaction.atomic():
                # --- Inventory Increase Logic ---
                commodities_to_update = []
                processed_commodity_ids = set()

                for item in items_to_process:
                    commodity_id = item.commodity_id
                    quantity_to_increase = item.quantity # Use the correct name

                    if not commodity_id or quantity_to_increase <= 0:
                        continue

                    # Optional: handle multiple lines for same commodity if needed
                    if commodity_id in processed_commodity_ids:
                        # If you sum quantities *before* locking, lock only once.
                        # For simplicity here, we process each line but lock once per commodity.
                        pass

                    try:
                        # Lock the commodity row for update
                        commodity_record = CommodityInfos.objects.select_for_update().get(id=commodity_id)

                        # Increase inventory
                        commodity_record.inventory += quantity_to_increase
                        commodities_to_update.append(commodity_record)
                        processed_commodity_ids.add(commodity_id)

                    except CommodityInfos.DoesNotExist:
                        # This indicates a data integrity issue
                        raise ValidationError(
                            f"无法找到 ID 为 {commodity_id} 的商品信息，无法入库 "
                            f"(来自入库单: {obj.order_number})"
                        )

                # --- Bulk update inventory ---
                if commodities_to_update:
                    CommodityInfos.objects.bulk_update(commodities_to_update, ['inventory'])
                    messages.success(request, f"成功更新了 {len(processed_commodity_ids)} 种商品的库存。")
                    
        except ValidationError as e:
            messages.error(request, f"处理入库单关联操作失败（库存或订单状态）：{e}")
        except IntegrityError as e:
            messages.error(request, f"数据库错误，处理关联操作失败：{e}")
        except Exception as e:
            messages.error(request, f"发生意外错误，处理关联操作失败：{e}")
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Error in save_related for purchase stock in order {obj.order_number}: {e}", exc_info=True)
    
