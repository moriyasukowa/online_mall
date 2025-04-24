document.addEventListener('DOMContentLoaded', function () {
    const $ = django.jQuery;

    // 初始化采购订单的 Select2
    function initializePurchaseOrderSelect() {
        const orderSelect = $('#id_purchase_order');
        if (!orderSelect.data('select2')) {
            orderSelect.select2();
        }

        // 监听采购订单选择事件
        orderSelect.on('select2:select', handlePurchaseOrderSelection);
    }

    // 处理采购订单选择
    function handlePurchaseOrderSelection(event) {
        const order_id = event.target.value;
        if (!order_id) return;

        fetchPurchaseOrderDetails(order_id);
    }

    // 获取采购订单详情
    function fetchPurchaseOrderDetails(order_id) {
        fetch(`/logistics/get_purchase_order/?order_id=${order_id}`)
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(handlePurchaseOrderData)
            .catch(error => {
                console.error('Error:', error);
                alert('获取采购订单详情失败，请稍后重试');
            });
    }

    // 处理采购订单数据
    function handlePurchaseOrderData(data) {
        // 设置默认地址
        setDefaultAddresses();
        
        // 清空现有的商品项
        $('.dynamic-items').not(':first').remove();
        
        // 填充商品项
        if (data.items && data.items.length > 0) {
            fillOrderItems(data.items);
        }
    }

    // 设置默认地址
    function setDefaultAddresses() {
        // 设置目的地地址 (ID=11)
        const destAddressId = 11;
        const destOption = new Option('北京市市辖区朝阳区本所在公司地址', destAddressId, true, true);
        $('#id_destination_address').append(destOption).trigger('change');
        
        // 设置发货地址 (ID=12)
        const originAddressId = 12;
        const originOption = new Option('山西省太原市杏花岭区采购公司所在地', originAddressId, true, true);
        $('#id_origin_address').append(originOption).trigger('change');
        
        // 更新Select2显示容器
        $('#select2-id_destination_address-container').text('北京市市辖区朝阳区本所在公司地址');
        $('#select2-id_origin_address-container').text('山西省太原市杏花岭区采购公司所在地');
    }

    // 填充订单项
    function fillOrderItems(items) {
        items.forEach((item, index) => {
            if (index > 0) {
                // 点击添加按钮创建新行
                $('.add-row a').click();
            }

            // 等待DOM更新后填充数据
            setTimeout(() => {
                const rows = $('.dynamic-items');
                const currentRow = rows.eq(index);
                console.log(index, currentRow);
                
                // 设置商品 - Select2 方式
                const commoditySelect = currentRow.find('select[id$="-commodity"]');
                const newOption = new Option(String(item.name), item.commodity_id, true, true);
                commoditySelect.append(newOption).trigger('change');
                    
                // 设置数量
                const quantityInput = currentRow.find('input[id$="-quantity"]');
                quantityInput.val(item.quantity);

                // 触发change事件以确保所有相关联的计算都能执行
                commoditySelect.trigger('change');
                quantityInput.trigger('change');
            }, 100);
        });
    }

    // 初始化
    initializePurchaseOrderSelect();
});
