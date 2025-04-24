(function($) {
    $(document).ready(function() {
        // 监听 outbound_order 变化
        $('#id_outbound_order').on('change', function() {
            var outboundOrderId = $(this).val();
            
            // 如果选择了出库单，则提交表单刷新页面以更新订单选项
            if (outboundOrderId) {
                // 获取当前 URL
                var url = new URL(window.location.href);
                // 添加/更新 outbound_order 参数
                url.searchParams.set('outbound_order', outboundOrderId);
                // 刷新页面
                window.location.href = url.toString();
            }
        });
    });
})(django.jQuery);
