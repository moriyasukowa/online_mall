document.addEventListener('DOMContentLoaded', function () {
    const $ = django.jQuery;

    // 绑定Select2事件和价格自动填充功能
    function bindSelect2Event(selectElement) {
        if (!$(selectElement).data('select2')) {
            $(selectElement).select2();
        }

        $(selectElement).off('select2:select').on('select2:select', function (event) {
            const selectedOption = event.params.data;
            if (!selectedOption) return;

            const row = $(selectElement).closest('.form-row');
            if (!row.length) return;

            const unitPriceInput = row.find('input[id$="-unit_price"]')[0];
            if (!unitPriceInput) return;

            const commodityId = selectedOption.id;
            if (!commodityId) return;

            fetch(`/commodity/get_commodity_price/?commodity_id=${commodityId}`)
                .then(response => {
                    if (!response.ok) throw new Error('Network response was not ok');
                    return response.json();
                })
                .then(data => {
                    if (data.price !== null && data.price !== undefined) {
                        const discountedPrice = (parseFloat(data.price) * 0.8).toFixed(2);
                        unitPriceInput.value = discountedPrice;
                        $(unitPriceInput).trigger('change');
                    }
                })
                .catch(error => {
                    alert('获取商品价格失败，请稍后重试');
                    unitPriceInput.value = '';
                    $(unitPriceInput).trigger('change');
                });
        });
    }

    // 初始化已存在的select元素
    function initializeExistingSelects() {
        const selector = 'select[id^="id_items-"][id$="-commodity"]:not([id*="__prefix__"])';
        document.querySelectorAll(selector).forEach(selectElement => {
            setTimeout(() => bindSelect2Event(selectElement), 100);
        });
    }

    // 监听新添加的行
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            mutation.addedNodes.forEach(function(node) {
                if (node.nodeType === 1) {
                    const newSelects = node.querySelectorAll('select[id^="id_items-"][id$="-commodity"]');
                    newSelects.forEach(selectElement => {
                        setTimeout(() => bindSelect2Event(selectElement), 50);
                    });
                }
            });
        });
    });

    // 观察表单变化
    const formContainer = document.querySelector('.inline-group');
    if (formContainer) {
        observer.observe(formContainer, {
            childList: true,
            subtree: true
        });
    }

    // 初始化页面加载时的select元素
    initializeExistingSelects();

    // 监听Django动态添加行的事件
    $(document).on('formset:added', function(event, $row) {
        if ($row && $row.length) {
            const newSelects = $row.find('select[id^="id_items-"][id$="-commodity"]');
            newSelects.each(function() {
                bindSelect2Event(this);
            });
        }
    });
});
