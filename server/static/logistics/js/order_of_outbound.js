(function($) {
    'use strict';

    // --- 格式化函数（保持不变） ---
    function formatOrderResult(order) {
        if (order.loading) { return $('<div class="select2-result-order-row">加载中...</div>'); }
        if (!order.text) { return null; } // 如果 text 为空，不渲染

        const combinedText = order.text;
        const parts = combinedText.split('@');
        // ... (rest of the formatOrderResult function - keep it the same) ...
        // Example:
        const orderId = parts[0] ? parts[0].trim() : 'N/A';
        const orderNumber = parts[1] ? parts[1].trim() : 'N/A';
        const date = parts[2] ? parts[2].trim() : 'N/A';
        const status = parts[3] ? parts[3].trim() : 'N/A';
        const amount = parts[4] ? parts[4].trim() : 'N/A';

        const $row = $(
            '<div class="select2-result-order-row">' +
                '<div class="select2-result-order__id" title="ID: ' + orderId + '">' + orderId + '</div>' +
                '<div class="select2-result-order__number" title="顾客ID: ' + orderNumber + '">' + orderNumber + '</div>' +
                '<div class="select2-result-order__date" title="日期: ' + date + '">' + date + '</div>' +
                '<div class="select2-result-order__status" title="状态: ' + status + '">' + status + '</div>' +
                '<div class="select2-result-order__amount" title="金额: ' + amount + '">' + amount + '</div>' +
            '</div>'
        );
        return $row;
    }

    function formatOrderSelection(order) {

        if (order.text) {
            const parts = order.text.split('@');
            return '订单ID：' + parts[0] + '(顾客：' + parts[1] + '，金额:￥' + parts[4] + ')' || order.text; // Display order number
        }
        if (order.id && !order.text && order.element && order.element.textContent) {
             // Attempt to parse pre-rendered text if available (might need adjustment)
             const parts = order.element.textContent.split('@');
             return '订单ID：' + parts[0] + '(顾客：' + parts[1] + '，金额:￥' + parts[4] + ')' || order.element.textContent;
        }
        return order.id ? '订单 ID: ' + order.id : '选择关联订单'; // Fallback
    }

    // --- 事件处理函数：添加下拉列表的表头 (保持不变，但加强判断) ---
    function handleOrderSelect2Open(e) {
        const selectId = e.target.id;
        if (selectId !== 'id_order_infos') { return; } // Only act on our target select

        setTimeout(function() {
            // Find the dropdown specific to this instance if possible, or use the class
            var $dropdown = $('.select2-dropdown.order-table-dropdown');
            if ($dropdown.length === 1 && !$dropdown.find('.select2-results__header').length) {
                // ... (rest of the handleOrderSelect2Open function - keep it the same) ...
                $dropdown.find('.select2-results__options').before(
                    '<div class="select2-results__header">' +
                        '<div class="select2-result-order__id">ID</div>' +
                        '<div class="select2-result-order__number">顾客ID</div>' +
                        '<div class="select2-result-order__date">日期</div>' +
                        '<div class="select2-result-order__status">状态</div>' +
                        '<div class="select2-result-order__amount">金额</div>' +
                    '</div>'
                );
            }
        }, 0);
    }

    $(document).ready(function() {
        const $outboundOrderSelect = $('#id_outbound_order');
        const $orderInfosSelect = $('#id_order_infos');

        // --- 基本 Select2 配置 (不含 AJAX，用于禁用状态) ---
        const baseSelect2Options = {
            placeholder: "请先选择出库单",
            allowClear: true,
            disabled: true, // Initially disabled
            theme: 'default', // Or your admin theme if needed
            width: '320px', // Or '100%' or fixed width
            dropdownCssClass: 'order-table-dropdown' // Keep CSS class
             // templateResult/templateSelection are not strictly needed when disabled
        };

        // --- 初始化订单选择框为禁用状态 ---
        $orderInfosSelect.select2(baseSelect2Options);

        // --- 绑定表头添加事件 ---
        // Note: If Select2 is destroyed and recreated, this binding on the original element persists.
        $orderInfosSelect.on('select2:open', handleOrderSelect2Open);


        // --- 出库单变更事件处理 ---
        $outboundOrderSelect.on('change', function() {
            const outboundOrderId = $(this).val();

            // 先销毁旧实例，准备重建
            if ($orderInfosSelect.data('select2')) {
                $orderInfosSelect.select2('destroy');
            }
            // 清空当前值和可能存在的旧 <option>
             $orderInfosSelect.val(null).html(''); // Clear selection and existing options

            if (outboundOrderId) {
                // --- 定义包含 AJAX 的 Select2 选项 ---
                const ajaxSelect2Options = {
                    // Inherit some base options maybe? Or define explicitly
                    ajax: {
                        url: '/logistics/get-related-orders/', // Your API endpoint
                        dataType: 'json',
                        delay: 250, // Delay in ms while typing
                        cache: true, // Cache results
                        data: function(params) {
                            // Data sent TO the server
                            return {
                                term: params.term, // Search term from Select2 input
                                page: params.page || 1, // Page number for pagination
                                outbound_order_id: outboundOrderId // **Crucial: Pass the selected outbound ID**
                            };
                        },
                        processResults: function(data, params) {
                            // IMPORTANT: Adapt this to your actual backend response structure!
                            // Assuming backend returns: { "orders": [{ "id": 1, "text": "..."}, ...] }
                            params.page = params.page || 1;

                            return {
                                results: data.orders || [], // Map your data array to 'results'
                                // pagination: { // Optional: if backend supports pagination
                                //     more: (params.page * 10) < data.total_count // Example logic
                                // }
                            };
                        }
                    },
                    disabled: false, // Enable the select
                    minimumInputLength: 0, // Trigger search even with empty input when dropdown opens
                    placeholder: "搜索或选择关联订单",
                    allowClear: true,
                    theme: 'default', // Consistent theme
                    escapeMarkup: function(markup) { return markup; }, // Allow HTML in results
                    templateResult: formatOrderResult, // Use our custom formatter
                    templateSelection: formatOrderSelection, // Use our custom selection formatter
                    dropdownCssClass: "order-table-dropdown", // Apply the custom class
                    width: '320px' // Or '100%' or fixed width
                };

                // --- 使用 AJAX 选项重新初始化订单选择框 ---
                $orderInfosSelect.select2(ajaxSelect2Options);
                // ---------- 新增逻辑：自动获取并选中第一个订单 ----------
                console.log("出库单已变更，尝试获取并自动选择第一个关联订单..."); // 调试信息
                // 手动发起一次 AJAX 请求，获取第一页数据
                $.ajax({
                    url: ajaxSelect2Options.ajax.url, // 使用上面定义的 URL
                    dataType: 'json',
                    data: { // 发送获取第一页所需的参数
                        outbound_order_id: outboundOrderId,
                        page: 1, // 请求第一页
                        term: '' // 无搜索词
                    }
                }).done(function(data) { // 请求成功的回调
                    console.log("成功获取到初始关联订单列表:", data); // 调试信息
                    // 检查后端是否成功返回了 `orders` 数组，并且数组不为空
                    if (data.orders && data.orders.length > 0) {
                        const firstOrder = data.orders[0]; // 获取第一个订单对象
                        const firstOrderId = firstOrder.id;
                        const firstOrderText = firstOrder.text; // 确保后端返回了 text
                        console.log(`找到 ${data.orders.length} 个关联订单，将自动选择第一个: ID=${firstOrderId}, Text=${firstOrderText}`); // 调试信息
                        // ✨ 步骤 1: 确保第一个订单的 <option> 存在于 <select> 中
                        // Select2 需要对应的 <option> 才能正确显示选中的项
                        // 检查是否已存在 (可能 Select2 内部机制已添加，或避免重复添加)
                        if ($orderInfosSelect.find("option[value='" + firstOrderId + "']").length === 0) {
                           // 如果不存在，手动创建一个 Option 对象并添加到 select 元素中
                           // 参数: text, value, defaultSelected, selected
                           const firstOption = new Option(firstOrderText, firstOrderId, true, true);
                           $orderInfosSelect.append(firstOption);
                           console.log("已为第一个订单创建并添加了 <option>"); // 调试信息
                        } else {
                            console.log("第一个订单的 <option> 已存在"); // 调试信息
                        }
                        // ✨ 步骤 2: 设置 Select2 的值为第一个订单的 ID
                        // 这会更新 Select2 的内部状态并显示选中的项 (使用 formatOrderSelection)
                        // .trigger('change') 是 Select2 推荐的标准做法，确保内部状态同步
                        $orderInfosSelect.val(firstOrderId).trigger('change');
                        console.log("已将 Select2 的值设置为第一个订单 ID，并触发了 change 事件"); // 调试信息
                        // ✨ 步骤 3: 手动触发 'select2:select' 事件
                        // 这是关键！因为我们之前的地址/商品填充逻辑是绑定到 'select2:select' 事件的。
                        // 我们需要模拟这个事件，并将选中的订单数据传递过去。
                        // 事件处理器期望的格式通常是 event.params.data
                         console.log("准备手动触发 select2:select 事件，传递数据:", { params: { data: firstOrder } }); // 调试信息
                        $orderInfosSelect.trigger('select2:select', { params: { data: firstOrder } });
                        console.log("已手动触发 select2:select 事件"); // 调试信息
                    } else {
                        console.log("未找到与此出库单关联的 '待揽收' 订单，或返回数据格式错误。");
                        // 可选：如果希望在这种情况下显示提示，可以设置占位符
                        // $orderInfosSelect.attr('data-placeholder', '无可用关联订单').select2(ajaxSelect2Options);
                    }
                }).fail(function(jqXHR, textStatus, errorThrown) { // 请求失败的回调
                    console.error("自动获取初始关联订单失败:", textStatus, errorThrown, jqXHR.responseText);
                    alert("加载关联订单列表失败，请检查网络或稍后重试。");
                    // 发生错误时，可以选择将订单选择框重置回禁用状态
                    $orderInfosSelect.select2('destroy').select2(baseSelect2Options);
                });
                // ---------- 结束新增逻辑 ----------
            } else {
                 // --- 未选择出库单，重置为初始禁用状态 ---
                 $orderInfosSelect.select2(baseSelect2Options);
            }
        });

        // --- 页面加载时触发一次 change 事件处理初始状态 ---
        // (如果出库单初始有值，则会启用并配置 AJAX)
        $outboundOrderSelect.trigger('change');

    });
})(django.jQuery);
