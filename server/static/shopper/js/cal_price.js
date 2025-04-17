// shopper/js/inline_price_calculator.js

document.addEventListener('DOMContentLoaded', function() {
    // 获取总价输入框
    const totalPriceInput = document.getElementById('id_price');
    if (!totalPriceInput) return;

    const $ = django.jQuery;

    // 监听所有可能影响价格变化的事件
    function setupEventListeners() {
        const container = document.getElementById('purchaseinfos_set-group');
        if (!container) return;

        // 1. 原生表单元素的变化
        container.addEventListener('change', function(e) {
            if (e.target.matches('input[name*="-unit_price"], input[name*="-quantity"]')) {
                updateTotalPrice();
            }
        });

        // 2. Select2选择变化 (特殊处理)
        $(container).on('change', 'select[name*="-commodityInfos_id"]', function() {
            // 等待Select2更新完成
            setTimeout(updateTotalPrice, 50);
        });

        // 3. 动态加载的价格字段变化 (如果有AJAX加载价格)
        container.addEventListener('DOMSubtreeModified', function(e) {
            if (e.target.classList.contains('field-unit_price')) {
                updateTotalPrice();
            }
        });
    }

    // 初始设置监听器
    setupEventListeners();

    // 处理动态添加的行
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('add-row')) {
            // 等待新行完全渲染
            setTimeout(function() {
                setupEventListeners(); // 为新行设置监听
                updateTotalPrice();    // 更新总价
            }, 200);
        }
    });

    // 总价计算函数
    function updateTotalPrice() {
        let total = 0;
        
        document.querySelectorAll('#purchaseinfos_set-group tbody tr:not(.empty-form)').forEach(row => {
            const priceInput = row.querySelector('input[name*="-unit_price"]');
            const quantityInput = row.querySelector('input[name*="-quantity"]');
            const commoditySelect = row.querySelector('select[name*="-commodityInfos_id"]');
            
            if (commoditySelect && commoditySelect.value && priceInput && quantityInput) {
                const price = parseFloat(priceInput.value) || 0;
                const quantity = parseInt(quantityInput.value) || 0;
                total += price * quantity;
            }
        });

        totalPriceInput.value = total.toFixed(2);
        totalPriceInput.dispatchEvent(new Event('change', { bubbles: true }));
    }

    // 初始计算
    updateTotalPrice();
});
