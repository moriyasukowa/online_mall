
document.addEventListener('DOMContentLoaded', function () {
    const $ = django.jQuery;
    console.log('页面加载完成');
    console.log(typeof jQuery);
    console.log($.fn.select2); // 检查是否正确加载了 Select2
    // 创建统一的函数以绑定事件
    function bindSelect2Event(selectElement) {
        console.log('绑定 select2:select 事件:', selectElement);
        $(selectElement).select2();
        console.log($(selectElement).data('select2')); // 检查其数据是否存在

        $(selectElement).on('select2:select', function (event) {
            console.log('触发 select2:select 事件', event.target);

            const selectedOption = event.params.data;
            if (selectedOption) {
                console.log('选中的商品数据:', selectedOption);

                const row = selectElement.closest('.form-row');
                console.log('当前行:', row);
                if (row) {
                    const unitPriceInput = row.querySelector('input[id$="-unit_price"]');
                    if (unitPriceInput && selectedOption.element) {
                        const price = parseFloat(selectedOption.element.dataset.price || 0);
                        const discountedPrice = (price * 0.8).toFixed(2);

                        unitPriceInput.value = discountedPrice;
                        console.log('已将折后价格填入:', discountedPrice);

                        unitPriceInput.dispatchEvent(new Event('change'));
                    }
                }
            }
        });
    }

    // 为已有的 `<select>` 元素绑定事件
    const selectElements = document.querySelectorAll('select[id^="id_items-"][id$="-commodity"]');
    selectElements.forEach(bindSelect2Event);

    // 监听动态添加的行
    document.addEventListener('formset:added', function (event) {
        console.log('检测到新行加入');

        const row = event.detail.row;
        const selectElement = row.querySelector('select[id^="id_items-"][id$="-commodity"]');
        if (selectElement) {
            console.log('绑定新行的 select2:select 事件:', selectElement);
            bindSelect2Event(selectElement);
        }
    });
});
