document.addEventListener('DOMContentLoaded', function () {
    const $ = django.jQuery;

    // 初始化订单选择的 Select2
    function initializeOrderSelect() {
        const orderSelect = $('#id_order'); // 假设退款单中关联订单的字段ID是 id_order
        if (!orderSelect.data('select2')) {
            orderSelect.select2({
                placeholder: "请选择要退款的订单",
                allowClear: true
            });
        }

        // 监听订单选择事件
        orderSelect.on('select2:select', handleOrderSelection);
        // 监听清除选择事件
        orderSelect.on('select2:unselect', clearRefundFields);
    }

    // 处理订单选择
    function handleOrderSelection(event) {
        const orderId = event.target.value;
        if (!orderId) {
            clearRefundFields(); // 如果没有选择订单，清空字段
            return;
        }
        fetchOrderDetails(orderId);
    }

    // 获取订单详情
    function fetchOrderDetails(orderId) {
        // 注意：请确保这里的 URL 与你的 Django URL 配置完全匹配
        fetch(`/shopper/order-detail/${orderId}/`)
            .then(response => {
                if (!response.ok) {
                    // 尝试解析错误信息
                    return response.json().then(errData => {
                        throw new Error(errData.msg || `Network response was not ok (${response.status})`);
                    });
                }
                return response.json();
            })
            .then(responseJson => {
                if (responseJson.state === 'success') {
                    handleOrderData(responseJson.data); // 传递 data 部分给处理函数
                } else {
                    throw new Error(responseJson.msg || '获取订单详情失败');
                }
            })
            .catch(error => {
                console.error('获取订单详情时出错:', error);
                alert(`获取订单详情失败: ${error.message}`);
                clearRefundFields(); // 出错时也清空字段
            });
    }

    // 处理订单数据并填充退款表单字段
    function handleOrderData(data) {
        // 确保 data.order 存在
        if (!data || !data.order) {
            console.error('API 返回的数据结构不符合预期:', data);
            alert('无法处理订单数据，请检查 API 响应。');
            clearRefundFields();
            return;
        }

        const orderData = data.order;
        console.log('订单数据:', orderData.price); // 调试信息
        if (orderData.price !== undefined && orderData.price !== null) {
            total_amount = orderData.price;
            total_amount = parseFloat(total_amount).toFixed(2); // 保留两位小数
            $('#id_price').val(total_amount).trigger('change');
        } else {
             $('#id_amount').val('').trigger('change');
        }

        if (orderData.user !== undefined && orderData.user !== null) {
            const userSelect = $('#id_user');
            // 检查选项是否已存在，避免重复添加
            if (userSelect.find("option[value='" + orderData.user + "']").length === 0) {
                 // 创建新选项，值为用户ID，文本也为用户ID (或者你可以根据需要从API获取用户名)
                const newOption = new Option(String(orderData.user), orderData.user, true, true);
                userSelect.append(newOption);
            }
            // 选中该用户
            userSelect.val(orderData.user).trigger('change');
        } else {
             $('#id_user').val(null).trigger('change'); // 清空用户选择
        }

        // 你可以在这里添加填充其他字段的逻辑，例如：
        // - 根据 data.items 填充退款商品信息（如果需要）
        // - 根据 data.address 填充地址信息（如果需要）
        // 例如，填充退款原因（如果需要基于订单信息预设）
        // $('#id_reason').val(`订单 ${orderData.order_sn} 的退款申请`).trigger('change'); // 假设退款原因字段ID是 id_reason
    }

    // 清空退款相关字段的函数
    function clearRefundFields() {
        $('#id_amount').val('').trigger('change'); // 清空金额
        // 注意：不要清空用户字段，因为退款单通常需要关联用户
        // 如果需要清空用户，取消下一行注释
        // $('#id_user').val(null).trigger('change');
        // 清空其他你可能填充的字段
        // $('#id_reason').val('').trigger('change');
        console.log('退款相关字段已清空');
    }


    // 初始化
    initializeOrderSelect();
});