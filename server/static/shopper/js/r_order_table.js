(function($) {
    $(document).ready(function() {
        console.log("Custom Order Select2 script loaded and document ready.");

        const selectElementSelector = '#id_refund_orders';

        function initializeOrderSelect2(element) {
            if (!$(element).length) {
                console.warn("Order select element not found:", selectElementSelector);
                return;
            }
            if ($(element).data('select2-initialized')) {
                console.log("Order select already initialized by custom script:", element);
                return;
            }

            console.log("Attempting custom initialization for Order select:", element);

            if ($(element).data('select2')) {
                try {
                    console.log("Destroying potentially existing Select2 instance...");
                    $(element).select2('destroy');
                    $(element).removeData('select2');
                    console.log("Existing Select2 instance destroyed.");
                } catch (e) {
                    console.warn("Error destroying previous Select2 instance:", e);
                }
            }

            const adminUrl = $(element).data('ajax--url') || "/admin/autocomplete/";
            const appLabel = 'shopper';
            const modelName = 'refundstockinOrder';
            const fieldName = 'refund_orders';

            console.log("Select2 AJAX URL:", adminUrl);
            console.log("App Label:", appLabel, "Model Name:", modelName, "Field Name:", fieldName);

            const finalOptions = {
                ajax: {
                    url: adminUrl,
                    dataType: 'json',
                    delay: $(element).data('ajax--delay') || 250,
                    cache: false,
                    data: function(params) {
                        let requestData = {
                            term: params.term || '',
                            page: params.page || 1,
                            app_label: appLabel,
                            model_name: modelName,
                            field_name: fieldName,
                        };
                        console.log("AJAX request data:", requestData);
                        return requestData;
                    },
                    processResults: function(data, params) {
                        console.log("AJAX response data:", data);
                        params.page = params.page || 1;

                        let filteredResults = [];
                        if (data.results && data.results.length) {
                            filteredResults = data.results.filter(function(item) {
                                if (!item.text) return false;
                                const parts = item.text.split('@');
                                const orderStatus = parts[3] ? parts[3].trim() : '';
                                return orderStatus === '退货中';
                            });
                        }

                        console.log("Processed results (count):", filteredResults.length);
                        
                        // 关键修改：如果有过滤后的结果，则清除"未找到结果"消息
                        if (filteredResults.length > 0) {
                            // 移除可能存在的"未找到结果"消息
                            setTimeout(function() {
                                $('.select2-results__message').hide();
                            }, 0);
                        }

                        return {
                            results: filteredResults,
                            pagination: {
                                more: data.pagination && data.pagination.more
                            }
                        };
                    }
                },
                minimumInputLength: 0,
                placeholder: $(element).data('placeholder') || '搜索或选择退货中订单',
                allowClear: $(element).data('allow-clear') || true,
                theme: $(element).data('theme') || 'default',
                escapeMarkup: function(markup) { return markup; },
                templateResult: formatOrderResult,
                templateSelection: formatOrderSelection,
                dropdownCssClass: "order-table-dropdown",
                language: {
                    noResults: function() {
                        return "没有找到退货中的订单";
                    },
                    searching: function() {
                        return "搜索中...";
                    },
                    loadingMore: function() {
                        return "加载更多结果...";
                    }
                }
            };

            console.log("Initializing Order Select2 with options...");
            try {
                $(element).select2(finalOptions)
                    .on('select2:open', handleSelect2Open)
                    .on('select2:opening', function(e) {
                        console.log("Select2 opening. Current value:", $(this).val());
                    })
                    // 添加事件处理程序，在结果渲染后检查是否有结果
                    .on('select2:results', function(e) {
                        console.log("Results rendered, checking if empty...");
                        const $dropdown = $('.select2-dropdown.order-table-dropdown');
                        const $results = $dropdown.find('.select2-results__option');
                        
                        // 如果有结果项但仍显示"未找到结果"消息，则隐藏该消息
                        if ($results.length > 1 || ($results.length === 1 && !$results.hasClass('select2-results__message'))) {
                            $dropdown.find('.select2-results__message').hide();
                        }
                    });
                
                console.log("Order Select2 initialized successfully.");
                $(element).data('select2-initialized', true);
            } catch(e) {
                 console.error("Error during Order Select2 initialization:", e);
            }
        }

        function formatOrderResult(order) {
            if (order.loading) {
                return '<div class="select2-result-order-row">加载中...</div>';
            }
            const combinedText = order.text || '';
            const parts = combinedText.split('@');
            const orderSN = parts[1] ? parts[1].trim() : 'N/A';
            const orderDate = parts[2] ? parts[2].trim() : 'N/A';
            const orderStatus = parts[3] ? parts[3].trim() : 'N/A';
            const orderPrice = parts[4] ? parseFloat(parts[4].trim()).toFixed(2) : 'N/A';

            if (orderStatus !== '退货中') {
                 console.log("formatOrderResult filtering out:", order.text);
                 return null;
            }

            const $row = $(
                '<div class="select2-result-order-row">' +
                    '<div class="select2-result-order__sn" title="' + orderSN + '">' + orderSN + '</div>' +
                    '<div class="select2-result-order__date" title="' + orderDate + '">' + orderDate + '</div>' +
                    '<div class="select2-result-order__status" title="' + orderStatus + '">' + orderStatus + '</div>' +
                    '<div class="select2-result-order__price" title="' + orderPrice + '">¥ ' + orderPrice + '</div>' +
                '</div>'
            );
            return $row;
        }

        function formatOrderSelection(order) {
            if (!order.id) {
                return order.text;
            }
            const combinedText = order.text || '';
            const parts = combinedText.split('@');
            const orderId = parts[0] ? parts[0].trim() : 'N/A';
            const orderSN = parts[1] ? parts[1].trim() : order.id;
            return "用户:" + orderSN + ", 订单号: " + orderId;
        }

        function handleSelect2Open() {
            setTimeout(function() {
                var $dropdown = $('.select2-dropdown.order-table-dropdown');
                if ($dropdown.length && !$dropdown.find('.select2-results__header').length) {
                    $dropdown.find('.select2-results__options').before(
                        '<div class="select2-results__header">' +
                            '<div class="select2-result-order__sn">用户</div>' +
                            '<div class="select2-result-order__date">日期</div>' +
                            '<div class="select2-result-order__status">状态</div>' +
                            '<div class="select2-result-order__price">总价</div>' +
                        '</div>'
                    );
                    
                    
                    // 检查结果是否为空，如果不为空，隐藏默认的"未找到结果"消息
                    setTimeout(function() {
                        const $results = $dropdown.find('.select2-results__option');
                        const hasResults = $results.length > 1 || ($results.length === 1 && !$results.hasClass('select2-results__message'));
                        
                        if (hasResults) {
                            $dropdown.find('.select2-results__message').hide();
                            $('.custom-select2-message').show();
                        } else {
                            $('.custom-select2-message').hide();
                        }
                    }, 100);
                }
            }, 100); // 增加延时，确保DOM渲染完成
        }

        // 添加一个辅助函数来处理结果渲染后的状态
        function handleResultsRendered() {
            setTimeout(function() {
                const $dropdown = $('.select2-dropdown.order-table-dropdown');
                const $results = $dropdown.find('.select2-results__option');
                const $noResults = $dropdown.find('.select2-results__message');
                
                // 检查是否有结果项
                if ($results.length > 1 || ($results.length === 1 && !$results.eq(0).hasClass('select2-results__message'))) {
                    // 有结果，隐藏"未找到结果"消息
                    $noResults.hide();
                }
            }, 150);
        }

        // 初始化Select2
        initializeOrderSelect2($(selectElementSelector));
        
        // 监听Select2的结果渲染事件
        $(document).on('select2:results', handleResultsRendered);
        
        // 为了确保兼容性，也监听DOM变化
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.addedNodes.length) {
                    const $added = $(mutation.addedNodes);
                    if ($added.hasClass('select2-results__option') || $added.find('.select2-results__option').length) {
                        handleResultsRendered();
                    }
                }
            });
        });
        
        // 开始观察Select2结果容器的变化
        setTimeout(function() {
            const $resultsContainer = $('.select2-results');
            if ($resultsContainer.length) {
                observer.observe($resultsContainer[0], { childList: true, subtree: true });
            }
        }, 500);
    });
})(django.jQuery);
