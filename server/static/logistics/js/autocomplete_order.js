document.addEventListener('DOMContentLoaded', function () {
    const $ = django.jQuery;

    // 初始化采购计划的 Select2
    function initializeProcurementPlanSelect() {
        const planSelect = $('#id_procurement_plan');
        if (!planSelect.data('select2')) {
            planSelect.select2();
        }

        // 监听采购计划选择事件
        planSelect.on('select2:select', handleProcurementPlanSelection);
    }

    // 处理采购计划选择
    function handleProcurementPlanSelection(event) {
        const planId = event.target.value;
        if (!planId) return;

        fetchProcurementPlanDetails(planId);
    }

    // 获取采购计划详情
    function fetchProcurementPlanDetails(planId) {
        fetch(`/logistics/get_procurement_plan/?plan_id=${planId}`)
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(handleProcurementPlanData)
            .catch(error => {
                console.error('Error:', error);
                alert('获取采购计划详情失败，请稍后重试');
            });
    }

    // 处理采购计划数据
    function handleProcurementPlanData(data) {
        // 填充供应商
        if (data.supplier) {
            $('#id_supplier').val(data.supplier).trigger('change');
        }

        // 清空现有的商品项
        $('.dynamic-items').not(':first').remove();
        
        // 填充商品项
        if (data.items && data.items.length > 0) {
            fillProcurementItems(data.items);
        }
    }

    // 填充采购项
    function fillProcurementItems(items) {
        items.forEach((item, index) => {
            if (index > 2) {
                // 点击添加按钮创建新行
                $('.add-row a').click();
            }

            // 等待DOM更新后填充数据
            setTimeout(() => {
                const rows = $('.dynamic-items');
                const currentRow = rows.eq(index);
                
                // 设置商品 - Select2 方式
                const commoditySelect = currentRow.find('select[id$="-commodity"]');
                const newOption = new Option(String(item.commodity_id), item.commodity_id, true, true);
                commoditySelect.append(newOption).trigger('change');
                    
                // 设置数量
                const quantityInput = currentRow.find('input[id$="-quantity_plan"]');
                quantityInput.val(item.quantity);
                
                // 设置单价
                const unitPriceInput = currentRow.find('input[id$="-unit_price"]');
                unitPriceInput.val(item.unit_price);

                // 触发change事件以确保所有相关联的计算都能执行
                commoditySelect.trigger('change');
                quantityInput.trigger('change');
                unitPriceInput.trigger('change');
            }, 100);
        });
    }

    // 初始化
    initializeProcurementPlanSelect();
});
