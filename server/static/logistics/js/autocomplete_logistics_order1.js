
(function($) { 
    'use strict';

    $(document).ready(function() {
        const $orderInfosSelect = $('#id_order_infos'); // 客户订单选择框
        console.log("Binding select2:select listener to:", $orderInfosSelect); // 确认绑定目标
        // ---------- 修改这里的事件处理函数 ----------
        $orderInfosSelect.on('select2:select', function(event, extraParams) {
            console.log("select2:select triggered. Event:", event, "Extra Params:", extraParams); // 增加调试信息
            let selectedData = null;
            // 尝试从标准 Select2 事件获取数据 (用户交互触发)
            if (event.params && event.params.data) {
                selectedData = event.params.data;
                console.log("Data found in event.params.data (likely user selection)");
            }
            // 尝试从手动触发事件的第二个参数获取数据
            // 我们传递的结构是 { params: { data: ... } }
            else if (extraParams && extraParams.params && extraParams.params.data) {
                selectedData = extraParams.params.data;
                console.log("Data found in extraParams.params.data (likely manual trigger)");
            }
            // 添加一个最终的检查，以防万一
            else {
                 console.warn("Could not extract selected data from event or extraParams.");
                 // 可以选择性地添加一个 fallback，比如尝试从 event.target 获取值，但这可能不包含完整数据
                 // const fallbackId = $(event.target).val();
                 // if (fallbackId) { ... }
                 return; // 如果找不到数据，则停止后续操作
            }
            const orderId = selectedData ? selectedData.id : null;
            console.log("Final Selected Data:", selectedData); // 调试最终获取的数据
            console.log("Derived Order ID:", orderId); // 调试最终获取的 ID
            if (orderId) {
                fetchCustomerOrderDetails(orderId); // 调用获取详情函数
            } else {
                 console.error("Order ID is null or undefined after processing event. Cannot fetch details.");
            }
        });

        // --- 获取客户订单详情的函数 ---
        function fetchCustomerOrderDetails(order_id) {
            // 调用我们新创建的后端 API
            fetch(`/shopper/get_customer_order_details/?order_id=${order_id}`)
                .then(response => {
                    if (!response.ok) {
                        // 如果请求失败，尝试读取错误信息
                        return response.json().then(err => { throw new Error(err.error || '网络响应错误'); });
                    }
                    return response.json(); // 解析 JSON 数据
                })
                .then(handleCustomerOrderData) // 成功后处理数据
                .catch(error => {
                    console.error('获取客户订单详情出错:', error);
                    alert(`获取客户订单详情失败: ${error.message}`);
                });
        }

        // --- 处理从后端获取的客户订单数据 ---
        function handleCustomerOrderData(data) {
            console.log("收到的订单详情:", data); // 调试信息

            // 1. 填充地址信息
            setOrderAddresses(data.address); // 将获取到的地址信息传入

            $('.dynamic-items').not(':first').not('.empty-form').remove(); // 更兼容旧版和新版 Django 的写法

            // 3. 填充新的商品项
            if (data.items && data.items.length > 0) {
                fillOrderItems(data.items); // 将获取到的商品项列表传入
            } else {
                 // 如果没有商品项，确保至少有一个空的内联表单存在（如果需要）
                 // 通常 Django Admin 会自动处理模板行，所以可能不需要额外操作
                 console.log("订单没有商品项信息");
            }
        }

        // --- 设置表单中的地址字段 ---
        function setOrderAddresses(addressData) {
            // --- 填充目的地地址 (客户收货地址) ---
            const $destAddressSelect = $('#id_destination_address'); // 目的地地址字段的选择器
            if ($destAddressSelect.length > 0) { // 检查字段是否存在
                if (addressData && addressData.id && addressData.text) {
                    // 如果后端返回了有效的地址信息
                    // 检查选项是否已存在，避免重复添加
                    if ($destAddressSelect.find("option[value='" + addressData.id + "']").length === 0) {
                        // 创建新的 Option 对象
                        const destOption = new Option(addressData.text, addressData.id, true, true);
                        // 添加到 select 中
                        $destAddressSelect.append(destOption);
                    }
                    // 无论是否已存在，都选中它并触发 change 事件
                    $destAddressSelect.val(addressData.id).trigger('change');

                    // (可选) 如果该地址字段也使用了 Select2，需要更新其显示容器
                    const $destContainer = $('#select2-id_destination_address-container'); // Select2 显示容器的选择器
                    if ($destContainer.length > 0) {
                        $destContainer.text(addressData.text).attr('title', addressData.text);
                    }
                } else {
                    // 如果没有返回地址信息，可以选择清空或设置默认值
                    $destAddressSelect.val(null).trigger('change'); // 清空选择
                    const $destContainer = $('#select2-id_destination_address-container');
                    if ($destContainer.length > 0) {
                         $destContainer.text('---').attr('title', ''); // 清空 Select2 显示
                    }
                    console.log("未找到客户收货地址信息");
                }
            } else {
                 console.warn("未在页面上找到 #id_destination_address 字段");
            }


            // --- 填充发货地址 (通常是固定地址) ---
            const $originAddressSelect = $('#id_origin_address'); // 发货地址字段的选择器
            if ($originAddressSelect.length > 0) {
                const originAddressId = 11; // 假设仓库/公司地址的 ID 固定为 11 (根据你的实际情况修改)
                const originAddressText = '北京市市辖区朝阳区本所在公司地址'; // 对应的地址文本 (根据你的实际情况修改)

                // 检查选项是否已存在
                if ($originAddressSelect.find("option[value='" + originAddressId + "']").length === 0) {
                    const originOption = new Option(originAddressText, originAddressId, true, true);
                    $originAddressSelect.append(originOption);
                }
                // 选中并触发 change
                $originAddressSelect.val(originAddressId).trigger('change');

                // (可选) 更新 Select2 显示容器
                const $originContainer = $('#select2-id_origin_address-container'); // Select2 显示容器
                if ($originContainer.length > 0) {
                    $originContainer.text(originAddressText).attr('title', originAddressText);
                }
            } else {
                 console.warn("未在页面上找到 #id_origin_address 字段");
            }
        }

        // --- 填充订单商品项到内联表单中 ---
        // 这个函数基本可以复用你之前的逻辑，只需要确保字段选择器正确
        function fillOrderItems(items) {
            // items 是从后端 API 获取的商品项数组，例如:
            // [ { commodity_id: 1, name: '商品A', quantity: 5 }, ... ]

            items.forEach((item, index) => {
                // 如果不是第一行 (Django Inline 通常自带一个空行或模板行)
                // 我们需要模拟点击 "添加" 按钮来创建新行
                 // Django 3.1+ 使用 .empty-form 作为模板类
                 // 检查现有非模板行的数量是否足够，如果不够则添加
                 const currentRowCount = $('.dynamic-items:not(.empty-form)').length;
                 console.log(`当前行数: ${currentRowCount}, 需要填充第 ${index + 1} 行`);

                if (index >= currentRowCount) {
                    // 如果当前可见行数少于需要的行数，触发添加
                    if ($('.add-row a').length > 0) { // 确保“添加”链接存在
                       console.log("模拟点击添加按钮");
                       $('.add-row a').trigger('click');
                    } else {
                       console.error("找不到 '添加' 按钮，无法添加新的商品行");
                       return; // 无法继续填充
                    }
                }

                // 使用 setTimeout 等待 DOM 更新，确保新行已经被添加到页面
                // 注意：这里的延时可能需要根据实际情况调整，或者寻找更可靠的 DOM 变化监听方式
                setTimeout(() => {
                    // 重新获取所有可见的行 (排除空模板行)
                    const $rows = $('.dynamic-items:not(.empty-form)');
                    // 获取当前要填充的行 (基于索引)
                    const $currentRow = $rows.eq(index);

                    if ($currentRow.length === 0) {
                        console.error(`无法找到要填充的第 ${index + 1} 行`);
                        return; // 跳过此项
                    }
                    console.log(`正在填充第 ${index + 1} 行`, $currentRow);

                    // --- 填充商品字段 (Select2) ---
                    const $commoditySelect = $currentRow.find('select[id$="-commodity"]'); // 假设商品字段的选择器
                    if ($commoditySelect.length > 0 && item.commodity_id && item.name) {
                         // 检查选项是否已存在，避免重复添加
                         if ($commoditySelect.find("option[value='" + item.commodity_id + "']").length === 0) {
                             // 创建新的 Option 并添加到 select 中
                             const newOption = new Option(item.name, item.commodity_id, true, true); // 设为默认选中
                             $commoditySelect.append(newOption);
                         }
                         // 选中该商品并触发 Select2 更新 (如果商品字段是 Select2)
                         $commoditySelect.val(item.commodity_id).trigger('change');
                         console.log(`设置商品为: ${item.name} (ID: ${item.commodity_id})`);
                    } else {
                        console.warn(`第 ${index + 1} 行: 未找到商品选择框或商品信息不完整`);
                    }

                    // --- 填充数量字段 ---
                    const $quantityInput = $currentRow.find('input[id$="-quantity"]'); // 假设数量字段的选择器
                    if ($quantityInput.length > 0 && item.quantity !== undefined) {
                        $quantityInput.val(item.quantity);
                        // 触发 change 事件，以防有其他 JS 依赖于数量变化
                        $quantityInput.trigger('change');
                         console.log(`设置数量为: ${item.quantity}`);
                    } else {
                        console.warn(`第 ${index + 1} 行: 未找到数量输入框或数量信息缺失`);
                    }

                }, 150 * (index + 1)); // 稍微增加延时，给 DOM 更多时间响应，特别是添加多行时

            });
        }

        // // (可选) 在页面加载时，如果 #id_order_infos 已经有值，可以触发一次获取
        // if ($orderInfosSelect.val()) {
        //     // 注意：如果 $orderInfosSelect 是多选，逻辑会更复杂
        //     // 这里假设它是单选，或者我们只关心第一个选中的值
        //     const initialOrderId = Array.isArray($orderInfosSelect.val()) ? $orderInfosSelect.val()[0] : $orderInfosSelect.val();
        //     if (initialOrderId) {
        //         fetchCustomerOrderDetails(initialOrderId);
        //     }
        // }

    }); // end document.ready
})(django.jQuery); // 传入 django.jQuery
