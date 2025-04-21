# 1. 自定义 Inline FormSet 来处理数量验证 (Task 2)
from django.forms import BaseInlineFormSet
from logistics.models import ProcurementOrder, PurchaseOrderItem
from django import forms
from logistics.models import LogisticsOrder

class PurchaseOrderItemInlineFormSet(BaseInlineFormSet):
    
    def clean(self):
        super().clean()
        if any(self.errors) or not self.instance or not self.instance.procurement_plan:
            return
        procurement_plan = self.instance.procurement_plan
        try:
            # 一次性获取计划中的所有项目，按产品ID存入字典以便快速查找
            plan_items = {item.commodity: item.quantity for item in procurement_plan.items.all()}
        except ProcurementOrder.DoesNotExist:
            # 如果计划不存在（理论上不应发生，因为它是外键），跳过验证
            return
        total_forms = self.total_form_count()
        for i in range(total_forms):
            form = self.forms[i]
            # 跳过没有数据的表单或标记为删除的表单
            if not form.has_changed() or self.can_delete and self._should_delete_form(form):
                continue
            if 'commodity' in form.cleaned_data and 'quantity_actual' in form.cleaned_data:
                commodity = form.cleaned_data['commodity']
                quantity_actual = form.cleaned_data['quantity_actual']
                print(plan_items)
                plan_quantity = plan_items.get(commodity)                    
                print(quantity_actual,plan_quantity)

                if plan_quantity is None:
                    # 如果订单项中的产品不在原计划中（根据业务逻辑决定是否允许）
                    form.add_error('commodity', f"产品 '{commodity}' 不在采购计划 '{procurement_plan}' 中。")
                elif quantity_actual > plan_quantity:
                    form.add_error('quantity_plan', f"数量 ({quantity_actual}) 不能超过计划数量 ({plan_quantity})。")

class LogisticsOrderAdminForm(forms.ModelForm):
    SOURCE_CHOICES = [
        ('', '请选择单据类型'),
        ('purchase', '采购单'),
        ('outbound', '出库单'),
        ('refund', '退款单'),
    ]
    
    source_type = forms.ChoiceField(
        label='单据类型',
        choices=SOURCE_CHOICES,
        required=True,
        widget=forms.RadioSelect
    )


    class Meta:
        model = LogisticsOrder
        fields = '__all__'
        
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        instance = kwargs.get('instance')
        
        # 如果是编辑现有记录，设置正确的单据类型
        if instance:
            if instance.purchase_order:
                self.initial['source_type'] = 'purchase'
            elif instance.outbound_order:
                self.initial['source_type'] = 'outbound'
            elif instance.refund_info:
                self.initial['source_type'] = 'refund'
