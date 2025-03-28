document.addEventListener('DOMContentLoaded', function() {
    const planField = document.getElementById('id_procurement_plan');
    const commodityField = document.getElementById('id_commodity');
    const quantityField = document.getElementById('id_quantity');
    const companyField = document.getElementById('id_company');
    console("执行");
    if (planField) {
        planField.addEventListener('change', function() {
            
            const planId = this.value;
            if (!planId) return;

            // 显示加载状态
            const loading = document.createElement('div');
            loading.className = 'loading';
            loading.innerHTML = '正在加载采购计划数据...';
            document.body.appendChild(loading);

            // 获取计划详情
            fetch(`/admin/logistics/purchaseorder/get-plan-details/${planId}/`)
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert(data.error);
                        return;
                    }

                    // 填充商品字段
                    if (commodityField) {
                        const option = new Option(data.commodity.text, data.commodity.id, true, true);
                        commodityField.appendChild(option);
                        commodityField.dispatchEvent(new Event('change'));
                    }

                    // 填充供应商
                    if (companyField) {
                        companyField.value = data.company;
                    }

                    // 填充数量
                    if (quantityField) {
                        quantityField.value = data.default_quantity;
                        quantityField.setAttribute('max', data.planned_quantity);
                        quantityField.previousElementSibling.textContent = 
                            `计划数量: ${data.planned_quantity} (库存: ${data.commodity.stock})`;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('获取采购计划数据失败');
                })
                .finally(() => {
                    document.body.removeChild(loading);
                });
        });
    }
});