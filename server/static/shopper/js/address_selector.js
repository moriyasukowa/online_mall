(function($) {
    $(document).ready(function() {
        // 初始化选择器
        function initSelectors() {
            $('.province-select, .city-select, .district-select').select2();
            
            // 省变化时加载市
            $('.province-select').on('change', async function() {
                var provinceId = $(this).val();
                var $citySelect = $(this).closest('form').find('.city-select');
                var $districtSelect = $(this).closest('form').find('.district-select');
                
                if (provinceId) {
                    try {
                        const response = await fetch(`/shopper/region_list/?parent_id=${provinceId}`);
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        const data = await response.json();
                        
                        if (data.code === 200) {
                            $citySelect.empty().append('<option value="">-- 选择市 --</option>');
                            $.each(data.data, function(i, item) {
                                $citySelect.append($('<option>', {
                                    value: item.id,
                                    text: item.name
                                }));
                            });
                            $citySelect.trigger('change');
                            $districtSelect.empty().append('<option value="">-- 选择区县 --</option>');
                        } else {
                            console.error('API Error:', data.message);
                        }
                    } catch (error) {
                        console.error('Request Failed:', error);
                    }
                } else {
                    $citySelect.empty().append('<option value="">-- 选择市 --</option>');
                    $districtSelect.empty().append('<option value="">-- 选择区县 --</option>');
                }
            });
            
            // 市变化时加载区县
            $('.city-select').on('change', async function() {
                var cityId = $(this).val();
                var $districtSelect = $(this).closest('form').find('.district-select');
                
                if (cityId) {
                    try {
                        const response = await fetch(`/shopper/region_list/?parent_id=${cityId}`);
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        const data = await response.json();
                        
                        if (data.code === 200) {
                            $districtSelect.empty().append('<option value="">-- 选择区县 --</option>');
                            $.each(data.data, function(i, item) {
                                $districtSelect.append($('<option>', {
                                    value: item.id,
                                    text: item.name
                                }));
                            });
                        } else {
                            console.error('API Error:', data.message);
                        }
                    } catch (error) {
                        console.error('Request Failed:', error);
                    }
                } else {
                    $districtSelect.empty().append('<option value="">-- 选择区县 --</option>');
                }
            });
        }
        
        // 初始加载
        initSelectors();
        
        // 处理动态添加的内联表单
        $(document).on('formset:added', function(event, $row) {
            initSelectors();
        });
    });
})(django.jQuery);
