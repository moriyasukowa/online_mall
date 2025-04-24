(function($) {
    $(document).ready(function() {
        // 首先检查是否是"增加"页面
        $('#id_order_infos').select2({
            placeholder: "选择关联订单",
            allowClear: true
        });

        var pageTitle = $('.el-page-header__content').text();
        if (pageTitle.indexOf('增加') === -1) {
            $('.field-purchase_order').show();
            $('.field-outbound_order').show();
            $('.field-order_infos').show();
            $('.field-refund_info').show();
            // 如果不是"增加"页面，则不执行后续代码
            return;
        }
        
        // 函数：根据选择的单据类型显示/隐藏相应字段
        function toggleSourceFields() {
            // 隐藏所有关联单据字段
            $('.field-purchase_order, .field-outbound_order, .field-order_infos, .field-refund_info').hide();
            
            // 获取选中的单据类型
            var selectedType = $('input[name="source_type"]:checked').val();
            
            // 根据选择显示相应字段
            if (selectedType === 'purchase') {
                $('.field-purchase_order').show();
            } else if (selectedType === 'outbound') {
                $('.field-outbound_order').show();
                $('.field-order_infos').show();
            } else if (selectedType === 'refund') {
                $('.field-refund_info').show();
            }
        }
        
        // 初始化时执行一次
        toggleSourceFields();
        
        // 监听单据类型选择变化
        $('input[name="source_type"]').change(function() {
            // 清空之前选择的值
            var selectedType = $(this).val();
            
            // 清空其他字段的值
            if (selectedType === 'purchase') {
                $('#id_outbound_order, #id_order_infos, #id_refund_info').val(null).trigger('change');
            } else if (selectedType === 'outbound') {
                $('#id_purchase_order, #id_refund_info').val(null).trigger('change');
                $('#id_order_infos').val(null).trigger('change');
            } else if (selectedType === 'refund') {
                $('#id_purchase_order, #id_outbound_order, #id_order_infos').val(null).trigger('change');
            }
            
            toggleSourceFields();
        });
        
        $('#id_outbound_order').on('select2:select', function(e) {
            var outboundOrderId = e.params.data.id;
            if (!outboundOrderId) return;
            $.get('/logistics/get_orders_of_outbound_order/', {order_id: outboundOrderId}, function(data) {
                var $orderSelect = $('#id_order_infos');
                
                // 清空并重新填充选项
                $orderSelect.empty();
                if (data.sales_orders && data.sales_orders.length > 0) {
                    $.each(data.sales_orders, function(index, order) {
                        $orderSelect.append(new Option(
                            `订单#${order.id} - ${order.user.username}`,
                            order.id
                        ));
                    });
                    
                    // 自动选中第一个订单
                    $orderSelect.val(data.sales_orders[0].id).trigger('change');
                } else {
                    $orderSelect.prop('disabled', true);
                    alert('该出库单没有关联的销售订单');
                }
            }).fail(function(xhr, status, error) {
                console.error('获取出库单详情失败:', error);
                alert('获取出库单详情失败: ' + error);
            });
        });
        // 统一 Select2 控件宽度
        function uniformSelect2Width() {
            $('.field-purchase_order .select2, .field-outbound_order .select2, .field-order_infos .select2, .field-refund_info .select2').css('width', '100%');
        }
        
        // 初始化时设置宽度
        uniformSelect2Width();
        
        // 在窗口调整大小时重新设置宽度
        $(window).resize(function() {
            uniformSelect2Width();
        });
        
        // 表单提交前验证
        $('form').submit(function(e) {
            var selectedType = $('input[name="source_type"]:checked').val();
            var isValid = true;
            
            if (!selectedType) {
                alert('请选择单据类型');
                isValid = false;
            } else {
                // 验证是否选择了对应的单据
                if (selectedType === 'purchase' && !$('#id_purchase_order').val()) {
                    alert('请选择关联的采购单');
                    isValid = false;
                } else if (selectedType === 'outbound') {
                    if (!$('#id_outbound_order').val()) {
                        alert('请选择关联的出库单');
                        isValid = false;
                    } else if (!$('#id_order_infos').val()) {
                        alert('请选择关联的销售订单');
                        isValid = false;
                    }
                } else if (selectedType === 'refund' && !$('#id_refund_info').val()) {
                    alert('请选择关联的退款单');
                    isValid = false;
                }
            }
            
            if (!isValid) {
                e.preventDefault();
                return false;
            }
        });
    });
})(django.jQuery);
