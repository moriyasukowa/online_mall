(function($) {
    $(document).ready(function() {
        console.log("Custom Order Select2 script loaded and document ready.");

        // Target the specific Order select field (Update if your ID is different)
        const selectElementSelector = '#id_order';

        function initializeOrderSelect2(element) {
            // Basic checks
            if (!$(element).length) {
                 console.warn("Order select element not found:", selectElementSelector);
                 return;
            }
            if ($(element).data('select2-initialized')) {
                console.log("Order select already initialized by custom script:", element);
                return;
            }

            console.log("Attempting custom initialization for Order select:", element);

            // Destroy potentially existing instance if needed (less likely for non-inline)
            if ($(element).data('select2')) {
                try {
                    console.log("Destroying potentially existing Select2 instance...");
                    $(element).select2('destroy');
                    $(element).removeData('select2'); // Clean up data
                    console.log("Existing Select2 instance destroyed.");
                } catch (e) {
                    console.warn("Error destroying previous Select2 instance:", e);
                }
            }

            // --- Configuration ---
            // Use Django Admin's default autocomplete URL unless you have a custom one
            const adminUrl = $(element).data('ajax--url') || "/admin/autocomplete/";
            // Define the correct app, model, and field names for Orders
            const appLabel = 'shopper'; // Updated
            const modelName = 'refundinfos'; // Updated (lowercase model name)
            const fieldName = 'order'; // Assuming the field name is 'order'

            const finalOptions = {
                ajax: {
                    url: adminUrl,
                    dataType: 'json',
                    delay: $(element).data('ajax--delay') || 250, // Standard delay
                    cache: $(element).data('ajax--cache') || true,
                    data: function(params) {
                        return {
                            term: params.term, // Search term
                            page: params.page || 1, // Pagination
                            app_label: appLabel,
                            model_name: modelName,
                            field_name: fieldName
                        };
                    },
                    processResults: function(data, params) {
                        // Assuming Django Admin autocomplete returns {results: [{id: '', text: ''}]}
                        // The 'text' contains our custom formatted string
                        return {
                            results: data.results || []
                        };
                    }
                },
                minimumInputLength: 0, // Allow searching without typing
                placeholder: $(element).data('placeholder') || '搜索或选择订单',
                allowClear: $(element).data('allow-clear') || true, // Usually good to allow clearing
                theme: $(element).data('theme') || 'default', // Use Django's theme
                escapeMarkup: function(markup) { return markup; }, // Needed for custom HTML in results
                templateResult: formatOrderResult, // Custom function to format dropdown items
                templateSelection: formatOrderSelection, // Custom function to format the selected item
                dropdownCssClass: "order-table-dropdown" // Custom CSS class for the dropdown
            };

            // Initialize Select2
            console.log("Initializing Order Select2 with options, URL:", finalOptions.ajax.url);
            try {
                $(element).select2(finalOptions).on('select2:open', handleSelect2Open);
                console.log("Order Select2 initialized successfully.");
                $(element).data('select2-initialized', true); // Mark as initialized
            } catch(e) {
                 console.error("Error during Order Select2 initialization:", e);
            }
        }

        // Format each result row in the dropdown
        function formatOrderResult(order) {
            if (order.loading) {
                return '<div class="select2-result-order-row">加载中...</div>';
            }
            // The 'text' property from Django Admin autocomplete contains our formatted string
            const combinedText = order.text || '';
            // Split the string: ID@OrderSN@Date@Status@Price
            const parts = combinedText.split('@');

            // Assign parts to variables, providing defaults if split fails
            const orderSN = parts[1] ? parts[1].trim() : 'N/A';
            const orderDate = parts[2] ? parts[2].trim() : 'N/A';
            const orderStatus = parts[3] ? parts[3].trim() : 'N/A';
            const orderPrice = parts[4] ? parseFloat(parts[4].trim()).toFixed(2) : 'N/A'; // Format price

            // Create the HTML structure for the row
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

        // Format the display of the selected item in the main select box
        function formatOrderSelection(order) {
            if (!order.id) { // Handle placeholder or cleared state
                return order.text; // Return the placeholder text
            }
            // Extract Order SN from the text for display
            const combinedText = order.text || '';
            const parts = combinedText.split('@');
            const orderSN = parts[1] ? parts[1].trim() : order.id; // Fallback to ID if SN not found
            return "用户:" + orderSN + ", 订单号: "+order.id; // Display Order SN when selected
        }

        // Add the header row when the dropdown opens
        function handleSelect2Open() {
            // Use setTimeout to allow the dropdown to render first
            setTimeout(function() {
                // Target the specific dropdown using the custom class
                var $dropdown = $('.select2-dropdown.order-table-dropdown');
                // Check if the dropdown exists and header isn't already added
                if ($dropdown.length && !$dropdown.find('.select2-results__header').length) {
                    // Prepend the header HTML to the results options list
                    $dropdown.find('.select2-results__options').before(
                        '<div class="select2-results__header">' +
                            '<div class="select2-result-order__sn">用户</div>' +
                            '<div class="select2-result-order__date">日期</div>' +
                            '<div class="select2-result-order__status">状态</div>' +
                            '<div class="select2-result-order__price">总价</div>' +
                        '</div>'
                    );
                }
            }, 0); // Timeout of 0 ms is usually sufficient
        }

        // --- Initialization Trigger ---
        // Directly initialize the target select element on page load
        initializeOrderSelect2($(selectElementSelector));

    });
})(django.jQuery);