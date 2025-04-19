// static/logistics/js/custom_filter_horizontal.js
(function($) {

    // ★ 格式化函数：使用简单分隔符，移除 padding
    function formatOrderOptionText(originalText) {
        if (!originalText || typeof originalText !== 'string') return { text: '', title: originalText || '' };

        const parts = originalText.split('@');
        if (parts.length >= 5) {
            const id    = parts[0].trim();
            const user  = parts[1].trim();
            const date  = parts[2].trim();
            const state = parts[3].trim();
            const price = parts[4].trim();

            // ★ 使用多个空格或 | 作为分隔符，不再依赖 padding
            //   你可以调整空格数量或改用 |
            const separator = '   '; // 三个空格
            // const formatted = `${id}${separator}${user}${separator}${date}${separator}${state}${separator}${price}`;
            const formatted = `${id} | ${user} | ${date} | ${state} | ${price}`;

            return {
                 text: formatted, // 显示的文本
                 title: originalText.replace(/@/g, ' | ') // Title 提示
            };
        }
        return { text: originalText, title: originalText };
    }

    // 重新格式化指定 select 中的选项 (保持不变)
    function reformatOptionsInSelect(selectElement) {
        $(selectElement).find('option').each(function() {
            const $option = $(this);
            let originalText = $option.data('original-text');
            if (typeof originalText === 'undefined') {
                originalText = $option.text();
                $option.data('original-text', originalText);
            }
            const formattedResult = formatOrderOptionText(originalText);
            $option.text(formattedResult.text);
            $option.attr('title', formattedResult.title);
        });
    }

    // ★ 添加表头函数：修改插入逻辑
    function addHeaderIfNeeded() {
        $('.selector-available, .selector-chosen').each(function() {
            const $container = $(this);
            // 检查是否已存在 header
            if ($container.find('.selector-header').length === 0) {
                const headerHtml = `
                    <div class="selector-header">
                        <div class="header-id">ID</div>
                        <div class="header-user">用户</div>
                        <div class="header-date">日期</div>
                        <div class="header-state">状态</div>
                        <div class="header-price">金额</div>
                    </div>`;
                // ★ 直接插入到 select 元素之前
                $container.find('select').before(headerHtml);
            }
        });
    }

    // === 主逻辑 (保持不变, 使用 MutationObserver) ===
    $(document).ready(function() {
        const selectAvailable = document.getElementById('id_sales_orders_from');
        const selectChosen = document.getElementById('id_sales_orders_to');

        if (!selectAvailable || !selectChosen) {
            console.error("Filter horizontal select elements not found! Check IDs: id_sales_orders_from, id_sales_orders_to");
            return;
        }

        addHeaderIfNeeded(); // 添加表头
        reformatOptionsInSelect(selectAvailable); // 初始格式化
        reformatOptionsInSelect(selectChosen);

        const observerCallback = function(mutationsList, observer) {
            reformatOptionsInSelect(selectAvailable);
            reformatOptionsInSelect(selectChosen);
        };
        const observer = new MutationObserver(observerCallback);
        const config = { childList: true };
        observer.observe(selectAvailable, config);
        observer.observe(selectChosen, config);
    });

})(django.jQuery);