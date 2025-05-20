// static/logistics/js/custom_filter_horizontal.js
(function($) {

    function formatPurchaseOrderOption(originalText) {
        if (!originalText || typeof originalText !== 'string') return { html: originalText || '', title: originalText || '' };

        const parts = originalText.split('@');

        if (parts.length >= 5) {
            const orderNumber   = parts[0].trim();
            const totalQuantity = parts[1].trim();
            const itemCount     = parts[2].trim();
            const status        = parts[3].trim();
            const dueDate       = parts[4].trim();

            const padding1 = '   '; // 订单号后的填充 (示例)
            const padding2 = '     '; // 总数后的填充 (示例)
            const padding3 = '    '; // 物料后的填充 (示例)
            const padding4 = '   '; // 状态后的填充 (示例)
            // 日期通常靠右或居中，可能不需要右侧填充，或者填充方式不同

            // 生成带 span 的 HTML，附加了空格
            const formattedHtml = `
                <span class="col-order-number">${orderNumber}${padding1}</span>
                <span class="col-quantity">${totalQuantity}${padding2}</span>
                <span class="col-items">${itemCount}${padding3}</span>
                <span class="col-status">${status}${padding4}</span>
                <span class="col-due-date">${dueDate}</span>
            `;

             // Title 提示保持不变或按需修改
            const titleText = `${orderNumber} | 总数: ${totalQuantity} | 物料: ${itemCount} | 状态: ${status} | 日期: ${dueDate}`;

            return {
                html: formattedHtml,
                title: titleText
            };
        }
        // 如果格式不匹配
        console.warn("Option text format unexpected (expected '@' separator):", originalText);
        return { html: originalText, title: originalText };
    }

    // 重新格式化函数 (无需修改)
    function reformatOptionsInSelect(selectElement) {
        $(selectElement).find('option').each(function() {
            const $option = $(this);
            let originalText = $option.data('original-text');
            if (typeof originalText === 'undefined') {
                originalText = $option.text();
                $option.data('original-text', originalText);
            }
            if (originalText) {
                const formattedResult = formatPurchaseOrderOption(originalText);
                $option.html(formattedResult.html);
                $option.attr('title', formattedResult.title);
            }
        });
    }

    // 添加表头函数
    function addHeaderIfNeeded() {
        $('.selector-available, .selector-chosen').each(function() {
            const $container = $(this);
            if ($container.find('.selector-header').length === 0) {
                // ★ 确认表头文本没有省略号
                const headerHtml = `
                    <div class="selector-header">
                        <div class="header-order-number">采购单号</div>
                        <div class="header-quantity">总数</div>
                        <div class="header-items">物料</div>
                        <div class="header-status">状态</div>
                        <div class="header-due-date">计划日期</div>
                    </div>`;
                $container.find('select').before(headerHtml);
            }
        });
    }

    // === 主逻辑 (无需修改) ===
    $(document).ready(function() {
        const selectAvailableId = 'id_purchase_orders_from'; // <-- 确认 ID
        const selectChosenId = 'id_purchase_orders_to';     // <-- 确认 ID

        const selectAvailable = document.getElementById(selectAvailableId);
        const selectChosen = document.getElementById(selectChosenId);

        if (!selectAvailable || !selectChosen) {
            console.error(`Filter horizontal select elements not found! Check IDs: #${selectAvailableId}, #${selectChosenId}.`);
            return;
        }

        addHeaderIfNeeded();
        reformatOptionsInSelect(selectAvailable);
        reformatOptionsInSelect(selectChosen);

        const observerCallback = function(mutationsList, observer) {
            let reformatAvailable = false; let reformatChosen = false;
            for(const mutation of mutationsList) {
                if (mutation.target === selectAvailable) reformatAvailable = true;
                if (mutation.target === selectChosen) reformatChosen = true;
            }
            if (reformatAvailable) reformatOptionsInSelect(selectAvailable);
            if (reformatChosen) reformatOptionsInSelect(selectChosen);
        };
        const observer = new MutationObserver(observerCallback);
        const config = { childList: true };
        observer.observe(selectAvailable, config);
        observer.observe(selectChosen, config);
    });

})(django.jQuery);