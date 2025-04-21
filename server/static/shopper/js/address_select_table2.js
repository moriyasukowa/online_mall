// static/path/to/your/static/admin_address_select2.js
(function($) {
    $(document).ready(function() {
        const selectElementSelector = '#id_address';

        function initializeAddressSelect2(element) {
            // 1. 基本检查
            if (!$(element).length) {
                 console.warn("Element not found:", selectElementSelector);
                 return;
            }
            // 检查是否已被我们的脚本标记为初始化
            if ($(element).data('select2-initialized')) {
                console.log("Element already initialized by custom script:", element);
                return;
            }

            console.log("Attempting custom initialization for:", element);
            console.log("Original data-ajax--url:", $(element).data('ajax--url')); // 确认原始值

            // 2. 移除 Django Admin 设置的默认 URL 属性
            // 这是关键一步，阻止 Select2 或 Django 默认脚本使用它
            $(element).removeAttr('data-ajax--url');
            console.log("Removed data-ajax--url attribute.");

            // 3. 销毁可能由 Django Admin 默认脚本创建的 Select2 实例
            // 也很重要，确保我们能完全控制初始化过程
            if ($(element).data('select2')) {
                try {
                    console.log("Destroying potentially existing Select2 instance...");
                    $(element).select2('destroy');
                    console.log("Existing Select2 instance destroyed.");
                    // 清理 select2 相关的 data，确保干净的重新初始化
                    $(element).removeData('select2');
                } catch (e) {
                    console.warn("Error destroying previous Select2 instance:", e);
                }
            } else {
                console.log("No existing Select2 instance found to destroy.");
            }


            // 4. 定义你的自定义配置
            const customApiUrl = "/api/v1/shopper/address-search/"; // 确保 URL 正确
            const finalOptions = {
                ajax: {
                    url: customApiUrl, // !!! 使用你的自定义 URL
                    dataType: 'json',
                    delay: 250,
                    data: function(params) {
                        return {
                            term: params.term,
                            page: params.page || 1
                        };
                    },
                    processResults: function(data, params) {
                        const processedResults = (data.results || []).map(item => {
                            return {
                                id: item.id,
                                text: `${item.name} (${item.phone})`,
                                name: item.name,
                                phone: item.phone,
                                full_address: item.full_address
                            };
                        });
                        return { results: processedResults };
                    }
                },
                minimumInputLength: 0,
                placeholder: '搜索或选择地址',
                allowClear: true,
                theme: $(element).data('theme') || 'default',
                escapeMarkup: function(markup) { return markup; },
                templateResult: formatAddressResult,
                templateSelection: formatAddressSelection,
                dropdownCssClass: "address-table-dropdown"
            };

            // 5. 使用你的自定义配置初始化 Select2
            console.log("Initializing Select2 with custom options, URL:", finalOptions.ajax.url);
            try {
                $(element).select2(finalOptions).on('select2:open', handleSelect2Open);
                console.log("Select2 initialized successfully with custom options.");
                // 6. 标记为已由你的脚本初始化
                $(element).data('select2-initialized', true);
            } catch(e) {
                 console.error("Error during custom Select2 initialization:", e);
            }
        }

        // formatAddressResult, formatAddressSelection, handleSelect2Open 函数保持不变...
        function formatAddressResult(address) {
            if (address.loading) return '<div class="select2-result-address-row">加载中...</div>';
            if (!address.id) return '<div class="select2-result-address-row">无结果</div>';

            const name = address.name || 'N/A';
            const phone = address.phone || 'N/A';
            const fullAddress = address.full_address || 'N/A';

            const $row = $(
                '<div class="select2-result-address-row">' +
                    '<div class="select2-result-address__name" title="' + name + '">' + name + '</div>' +
                    '<div class="select2-result-address__phone" title="' + phone + '">' + phone + '</div>' +
                    '<div class="select2-result-address__full" title="' + fullAddress + '">' + fullAddress + '</div>' +
                '</div>'
            );
            return $row;
        }

        function formatAddressSelection(address) {
            if (!address.id) return address.text;
            const name = address.name || 'N/A';
            const phone = address.phone || 'N/A';
            return name + ' (' + phone + ')';
        }

        function handleSelect2Open() {
            setTimeout(function() {
                var $dropdown = $('.select2-dropdown.address-table-dropdown');
                if ($dropdown.length && !$dropdown.find('.select2-results__header').length) {
                    $dropdown.find('.select2-results__options').before(
                        '<div class="select2-results__header">' +
                            '<div class="select2-result-address__name">收件人</div>' +
                            '<div class="select2-result-address__phone">电话</div>' +
                            '<div class="select2-result-address__full">详细地址</div>' +
                        '</div>'
                    );
                }
            }, 0);
        }

        // 页面加载时尝试初始化
        console.log("Custom address select2 script started. Waiting for document ready.");
        
        var header = document.querySelector('.el-page-header__content');
        if (header && header.textContent.includes('增加')) {
            console.log("Header contains '增加', initializing address select2.");
            initializeAddressSelect2($(selectElementSelector));
        }
    

    });
})(django.jQuery);