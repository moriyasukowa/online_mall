document.addEventListener('DOMContentLoaded', function () {
    const $ = django.jQuery;

    // 初始化订单选择的 Select2
    function initializeOrderSelect() {
        const orderSelect = $('#id_refund_orders');

        console.log('初始化订单选择器:', orderSelect); // 调试信息
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
        fetch(`/shopper/order-detail-refund/${orderId}/`)
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
        console.log('订单数据:', orderData); // 调试信息
        
        // 填充订单相关基础信息
        if (orderData.price !== undefined && orderData.price !== null) {
            let total_amount = orderData.price;
            total_amount = parseFloat(total_amount).toFixed(2); // 保留两位小数
            $('#id_price').val(total_amount).trigger('change');
        }

        if (orderData.user !== undefined && orderData.user !== null) {
            const userSelect = $('#id_user');
            // 检查选项是否已存在，避免重复添加
            if (userSelect.find("option[value='" + orderData.user + "']").length === 0) {
                 // 创建新选项，值为用户ID，文本也为用户ID
                const newOption = new Option(String(orderData.user), orderData.user, true, true);
                userSelect.append(newOption);
            }
            // 选中该用户
            userSelect.val(orderData.user).trigger('change');
        }

        if (orderData.state !== undefined && orderData.state !== null) {
            const statusSelect = $('#id_status_before');
            if (statusSelect.find("option[value='" + orderData.state + "']").length === 0) {
                const newOption = new Option(orderData.state, orderData.state, true, true);
                statusSelect.append(newOption);
            }
            statusSelect.val(orderData.state).trigger('change');
        }
        
        // 处理内联表项目 - 商品项
        if (data.items && data.items.length > 0) {
            // 过滤掉 quantity 为 0 的项目
            const validItems = data.items.filter(item => item.quantity > 0);
            if (validItems.length > 0) {
                fillRefundItems(validItems);
            }
        }
    }
    
    // 填充退款商品内联表
    function fillRefundItems(items) {
        // 清空所有现有的内联表项目
        clearAllInlineItems();
        
        // 如果没有有效项目，直接返回
        if (items.length === 0) {
            return;
        }
        
        // 处理第一行
        let rows = $('.dynamic-items').not('.empty-form');
        let $firstRow = rows.length > 0 ? rows.first() : null;
        
        // 如果没有第一行，创建一个
        if (!$firstRow) {
            $('.add-row a').trigger('click');
            setTimeout(() => {
                rows = $('.dynamic-items').not('.empty-form');
                $firstRow = rows.first();
                setRowData($firstRow, items[0], 0);
                
                // 如果有多个商品，继续添加行
                addRemainingRows(items);
            }, 100);
        } else {
            // 设置第一行数据
            setRowData($firstRow, items[0], 0);
            
            // 如果有多个商品，继续添加行
            addRemainingRows(items);
        }
    }
    
    // 添加剩余的行
    function addRemainingRows(items) {
        if (items.length <= 1) {
            return;
        }
        
        // 为剩余的商品项添加行
        for (let i = 1; i < items.length; i++) {
            $('.add-row a').trigger('click');
        }
        
        // 给新添加的行设置数据
        setTimeout(() => {
            const allRows = $('.dynamic-items').not('.empty-form');
            for (let i = 1; i < items.length; i++) {
                if (i < allRows.length) {
                    const $row = allRows.eq(i);
                    setRowData($row, items[i], i);
                }
            }
            updateFormCount(); // 更新表单计数
        }, 200);
    }
    
    // 设置行数据
    function setRowData($row, item, index) {
        // 查找当前行中的商品选择器
        const commoditySelect = $row.find('select[id$="-commodity"]');
        
        // 如果找到了商品选择器，设置其值
        if (commoditySelect.length > 0) {
            const commodityId = item.commodityInfos_id.id;
            const commodityName = item.commodityInfos_id.name;
            
            // 检查选项是否已存在
            if (commoditySelect.find(`option[value='${commodityId}']`).length === 0) {
                // 创建新选项 - 商品名称可能需要显示更多信息，如尺寸和类型
                const displayName = `${commodityName} [${item.commodityInfos_id.sezes}][${item.commodityInfos_id.types}]`;
                const newOption = new Option(displayName, commodityId, true, true);
                commoditySelect.append(newOption);
            }
            
            // 选择该商品
            commoditySelect.val(commodityId).trigger('change');
        }
        
        // 设置数量
        const quantityInput = $row.find('input[id$="-quantity"]');
        if (quantityInput.length > 0) {
            quantityInput.val(item.quantity).trigger('change');
        }
        
        // 设置单价（如果需要）
        const unitPriceInput = $row.find('input[id$="-unit_price"]');
        if (unitPriceInput.length > 0) {
            unitPriceInput.val(item.unit_price).trigger('change');
        }
        
        console.log(`为第 ${index + 1} 行设置了数据:`, item);
    }
    
    // 清空所有内联表项目
    function clearAllInlineItems() {
        const rows = $('.dynamic-items').not('.empty-form');
        if (rows.length > 0) {
            // 保留第一行，删除其他行
            rows.not(':first').each(function() {
                $(this).find('.inline-deletelink').trigger('click');
            });
            
            // 清空第一行的数据
            const $firstRow = rows.first();
            $firstRow.find('select, input, textarea').val('').trigger('change');
        }
    }
    
    // 更新表单计数（用于Django的表单管理）
    function updateFormCount() {
        // 这里可能需要重新计算总表单数并更新表单计数字段
        // 如果Django的formset已经处理了这个，可能不需要此函数
        const totalForms = $('.dynamic-items').not('.empty-form').length;
        $('#id_items-TOTAL_FORMS').val(totalForms);
    }

    // 清空退款相关字段的函数
    function clearRefundFields() {
        $('#id_price').val('').trigger('change'); // 清空金额
        // 可以选择是否清空用户字段
        // $('#id_user').val(null).trigger('change');
        // 清空状态字段
        $('#id_status_before').val('').trigger('change');
        
        // 清空所有内联表项目
        clearAllInlineItems();
        
        console.log('退款相关字段已清空');
    }

    // 初始化
    initializeOrderSelect();
});
