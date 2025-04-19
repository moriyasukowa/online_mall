(function($) {
    $(document).ready(function() {
        const $selector = $('.selector');
        const $chosenSelect = $selector.find('.selector-chosen select');
        const $inlineForm = $('#items-group');
        const $totalForms = $('#id_items-TOTAL_FORMS');
        const orderItemsCache = {};

        function initializeListeners() {
            const observer = new MutationObserver(function() {
                syncOrdersToItems();
            });

            observer.observe($chosenSelect[0], {
                childList: true,
                subtree: true,
                characterData: true
            });

            $chosenSelect.on('change', syncOrdersToItems);

            $(document).on('dblclick', '.selector-available select option, .selector-chosen select option', function() {
                setTimeout(syncOrdersToItems, 100);
            });

            $selector.find('.selector-add, .selector-remove').on('click', function() {
                setTimeout(syncOrdersToItems, 100);
            });

            syncOrdersToItems();
        }

        function syncOrdersToItems() {
            const selectedOrderIds = [];
            $chosenSelect.find('option').each(function() {
                selectedOrderIds.push($(this).val());
            });

            if (selectedOrderIds.length === 0) {
                clearAllInlineItems();
                return;
            }

            collectOrderItems(selectedOrderIds, function(allItems) {
                rebuildInlineItems(allItems);
            });
        }

        function collectOrderItems(orderIds, callback) {
            const allItems = [];
            let pendingRequests = orderIds.length;

            if (pendingRequests === 0) {
                callback(allItems);
                return;
            }

            orderIds.forEach(orderId => {
                if (orderItemsCache[orderId]) {
                    const items = orderItemsCache[orderId];
                    items.forEach(item => {
                        item.orderId = orderId;
                        allItems.push(item);
                    });

                    pendingRequests--;
                    if (pendingRequests === 0) {
                        callback(allItems);
                    }
                } else {
                    $.ajax({
                        url: '/shopper/get-sales-order-items/',
                        data: { order_id: orderId },
                        dataType: 'json',
                        success: function(data) {
                            if (data.items && data.items.length > 0) {
                                orderItemsCache[orderId] = data.items;
                                data.items.forEach(item => {
                                    item.orderId = orderId;
                                    allItems.push(item);
                                });
                            } else {
                                orderItemsCache[orderId] = [];
                            }

                            pendingRequests--;
                            if (pendingRequests === 0) {
                                callback(allItems);
                            }
                        },
                        error: function() {
                            orderItemsCache[orderId] = [];
                            pendingRequests--;
                            if (pendingRequests === 0) {
                                callback(allItems);
                            }
                        }
                    });
                }
            });
        }

        function clearAllInlineItems() {
            const rows = $('.dynamic-items').not('.empty-form');

            if (rows.length > 0) {
                const $firstRow = rows.first();
                $firstRow.find('select[id$="-commodity"]').val(null).trigger('change');
                $firstRow.find('input[id$="-quantity"]').val('').trigger('change');
                $firstRow.removeAttr('data-commodity-id data-order-id');

                if (rows.length > 1) {
                    for (let i = rows.length - 1; i > 0; i--) {
                        rows.eq(i).find('.inline-deletelink').trigger('click');
                    }
                }
            }

            updateFormCount();
        }

        function rebuildInlineItems(items) {
            clearAllInlineItems();

            if (items.length === 0) {
                return;
            }

            let rows = $('.dynamic-items').not('.empty-form');
            let $firstRow = rows.length > 0 ? rows.first() : null;

            if (!$firstRow) {
                $('.add-row a').trigger('click');
                rows = $('.dynamic-items').not('.empty-form');
                $firstRow = rows.first();
            }

            const firstItem = items[0];
            setRowData($firstRow, firstItem, 0);

            if (items.length > 1) {
                for (let i = 1; i < items.length; i++) {
                    $('.add-row a').trigger('click');
                }

                setTimeout(() => {
                    const allRows = $('.dynamic-items').not('.empty-form');
                    for (let i = 1; i < items.length; i++) {
                        if (i < allRows.length) {
                            const $row = allRows.eq(i);
                            setRowData($row, items[i], i);
                        }
                    }
                    updateFormCount();
                }, 200);
            } else {
                updateFormCount();
            }
        }

        function setRowData($row, item, index) {
            if (!$row || !$row.length) {
                return;
            }

            $row.attr('data-commodity-id', item.commodity_id);
            $row.attr('data-order-id', item.orderId);

            const commoditySelect = $row.find('select[id$="-commodity"]');
            if (commoditySelect.length) {
                if (commoditySelect.hasClass('select2-hidden-accessible')) {
                    const newOption = new Option(item.name, item.commodity_id, true, true);
                    commoditySelect.append(newOption).trigger('change');
                } else {
                    try {
                        commoditySelect.empty();
                        const newOption = new Option(item.name, item.commodity_id, true, true);
                        commoditySelect.append(newOption);
                        commoditySelect.select2();
                        commoditySelect.trigger('change');
                    } catch (e) {
                        commoditySelect.val(item.commodity_id).trigger('change');
                    }
                }
            }

            const quantityInput = $row.find('input[id$="-quantity"]');
            if (quantityInput.length) {
                quantityInput.val(item.quantity).trigger('change');
            }
        }

        function updateFormCount() {
            const count = $('.dynamic-items').not('.empty-form').length;
            $totalForms.val(count);
        }

        initializeListeners();
    });
})(django.jQuery);
