(function($) {
    $(document).ready(function() {
        // 首先检查是否是"增加"页面
        var pageTitle = $('.el-page-header__content').text();
        if (pageTitle.indexOf('增加') === -1) {
            $('.field-purchase_order').show();
            $('.field-outbound_order').show();
            $('.field-refund_info').show();
            // 如果不是"增加"页面，则不执行后续代码
            return;
        }
        
        // 函数：根据选择的单据类型显示/隐藏相应字段
        function toggleSourceFields() {
            // 隐藏所有关联单据字段
            $('.field-purchase_order, .field-outbound_order, .field-refund_info').hide();
            
            // 获取选中的单据类型
            var selectedType = $('input[name="source_type"]:checked').val();
            
            // 根据选择显示相应字段
            if (selectedType === 'purchase') {
                $('.field-purchase_order').show();
            } else if (selectedType === 'outbound') {
                $('.field-outbound_order').show();
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
                $('#id_outbound_order, #id_refund_info').val(null);
            } else if (selectedType === 'outbound') {
                $('#id_purchase_order, #id_refund_info').val(null);
            } else if (selectedType === 'refund') {
                $('#id_purchase_order, #id_outbound_order').val(null);
            }
            
            toggleSourceFields();
        });
        
        // 统一 Select2 控件宽度
        function uniformSelect2Width() {
            $('.field-purchase_order .select2, .field-outbound_order .select2, .field-refund_info .select2').css('width', '100%');
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
                } else if (selectedType === 'outbound' && !$('#id_outbound_order').val()) {
                    alert('请选择关联的出库单');
                    isValid = false;
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
