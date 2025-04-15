(function($) {
    $(document).ready(function() {
        console.log("Custom Select2 script loaded and document ready.");

        const inlineGroupId = '#items-group';
        const selectElementSelector = 'select[id^="id_items-"][id$="-commodity"]:not([id*="__prefix__"])';

        function reinitializeCommoditySelect2(element) {
            console.log("Reinitializing Select2 for:", element.id);
            
            if ($(element).data('select2')) {
                console.log("Destroying existing Select2 instance");
                $(element).select2('destroy');
            }

            // 从元素获取Django Admin配置
            const appLabel = $(element).data('app-label') || 'commodity';
            const modelName = $(element).data('model-name') || 'commodityinfos';
            const fieldName = $(element).data('field-name') || 'commodity';
            const adminUrl = $(element).data('ajax--url') || "/admin/autocomplete/";

            const originalOptions = {
                ajax: {
                    url: adminUrl,
                    dataType: 'json',
                    delay: $(element).data('ajax--delay') || 20,
                    cache: $(element).data('ajax--cache') || true,
                    data: function(params) {
                        return {
                            term: params.term,
                            page: params.page || 1,
                            app_label: appLabel,
                            model_name: modelName,
                            field_name: fieldName
                        };
                    },
                    processResults: function(data, params) {
                        return { results: data.results };
                    }
                },
                minimumInputLength: 0,
                placeholder: $(element).data('placeholder') || '选择商品',
                allowClear: $(element).data('allow-clear') || false,
                theme: $(element).data('theme') || 'default'
            };

            const customOptions = {
                escapeMarkup: function(markup) { return markup; },
                templateResult: formatCommodityResult,
                templateSelection: formatCommoditySelection,
                dropdownCssClass: "commodity-table-dropdown"
            };

            const finalOptions = $.extend({}, originalOptions, customOptions);
            $(element).select2(finalOptions).on('select2:open', handleSelect2Open);
            
            console.log("Successfully reinitialized Select2 with custom options");
        }

        function formatCommodityResult(commodity) {
            if (commodity.loading) {
                return '<div class="select2-result-commodity-row">Loading...</div>';
            }
        
            console.log("Raw commodity data for formatting:", commodity);
       
            const combinedText = commodity.text || '';
            const parts = combinedText.split('@');

            const name = parts[0] ? parts[0].trim() : 'N/A';
            const stock = parts[1] ? parts[1].trim() : 'N/A';
            const sezes = parts[2] ? parts[2].trim() : 'N/A';
        
            console.log("Extracted parts - Name:", name, "Stock:", stock, "Sizes:", sezes);

            const $row = $(
                '<div class="select2-result-commodity-row">' +
                    '<div class="select2-result-commodity__name" title="' + name + '">' + name + '</div>' +
                    '<div class="select2-result-commodity__stock" title="Stock: ' + stock + '">' + stock + '</div>' +
                    '<div class="select2-result-commodity__sezes" title="Specs: ' + sezes + '">' + sezes + '</div>' +
                '</div>'
            );
        
            return $row;
        }

        function formatCommoditySelection(commodity) {
            return commodity.text || commodity.name || (commodity.id ? 'ID: ' + commodity.id : '选择商品');
        }

        function handleSelect2Open(e) {
            setTimeout(function() {
                var $dropdown = $('.select2-dropdown.commodity-table-dropdown');
                if ($dropdown.length && !$dropdown.find('.select2-results__header').length) {
                    $dropdown.find('.select2-results__options').before(
                        '<div class="select2-results__header">' +
                            '<div class="select2-result-commodity__name">名称</div>' +
                            '<div class="select2-result-commodity__stock">库存</div>' +
                            '<div class="select2-result-commodity__sezes">规格</div>' +
                        '</div>'
                    );
                }
            }, 0);
        }

        // 初始化现有行
        function initializeExistingSelects() {
            $(selectElementSelector).each(function() {
                reinitializeCommoditySelect2(this);
            });
        }

        // 监听新添加的行 - MutationObserver方式
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                mutation.addedNodes.forEach(function(node) {
                    if (node.nodeType === 1) {
                        const newSelects = $(node).find(selectElementSelector);
                        newSelects.each(function() {
                            setTimeout(() => reinitializeCommoditySelect2(this), 0);
                        });
                    }
                });
            });
        });

        // 观察表单变化
        const formContainer = document.querySelector(inlineGroupId);
        if (formContainer) {
            observer.observe(formContainer, {
                childList: true,
                subtree: true
            });
        }

        // 初始化页面加载时的select元素
        initializeExistingSelects();

        // 监听Django动态添加行的事件 - 双重保障
        $(document).on('formset:added', inlineGroupId, function(event, $row, formsetName) {
            const newSelects = $row.find(selectElementSelector);
            newSelects.each(function() {
                setTimeout(() => reinitializeCommoditySelect2(this), 0);
            });
        });
    });
})(django.jQuery);
