from django.contrib import admin
from .models import *
from django.http import JsonResponse
from django.urls import path

# admin.site.register(Types)
# admin.site.register(CommodityInfos)

# 修改title和header
admin.site.site_title = '测试系统'
admin.site.site_header = '测试后台管理系统'
admin.site.index_title = '测试平台管理'

@admin.register(Types)
class TypesAdmin(admin.ModelAdmin):
    list_display = [x for x in list(Types._meta._forward_fields_map.keys())]
    search_fields = ['firsts', 'seconds']
    list_filter = ['firsts']
    list_editable = ['firsts', 'seconds']

# @admin.register(CommodityInfos)
# class CommodityInfosAdmin(admin.ModelAdmin):
#     list_display = [x for x in list(CommodityInfos._meta._forward_fields_map.keys())]
#     search_fields = ['name']
#     date_hierarchy = 'created'
#
#     def formfield_for_dbfield(self, db_field, **kwargs):
#         if db_field.name == 'types':
#             db_field.choices = [(x['seconds'], x['seconds'])for x in Types.objects.values('seconds')]
#         return super().formfield_for_dbfield(db_field, **kwargs)

@admin.register(CommodityInfos)
class CommodityInfosAdmin(admin.ModelAdmin):
    # 改变数据新增页或数据修改页的网页布局
    fieldsets = (
        ('商品信息', {
            'fields': ('name','sezes','types','price','discount','sold','img','details', 'inventory'),
        }),
        ('收藏数量', {
            # 设置隐藏与显示
            'classes': ('collapse',),
            'fields': ('likes',),
        }),
    )

    ordering = ['id']

    # 设置数据列表页的每列数据是否可排序显示
    sortable_by = ['price', 'discount']

    # 在数据列表页设置显示的模型字段
    list_display = ['id', 'name', 'sezes', 'types', 'price', 'discount','img','details','inventory']
    list_display.append('colored_name')

    list_filter = ['types']

    # 在数据列表页设置每一页显示的数据量
    list_per_page = 100

    list_max_show_all = 200

    list_editable = ['name','sezes','types','price','discount','img','details']

    search_fields = ['name', 'types']

    date_hierarchy = 'created'

    save_as = True

    def formfield_for_dbfield(self, db_field, **kwargs):
        if db_field.name == 'types':
            db_field.choices = [(x['seconds'], x['seconds'])for x in Types.objects.values('seconds')]
        return super().formfield_for_dbfield(db_field, **kwargs)
    def get_search_results(self, request, queryset, search_term):
        """
        用于 Select2 dropdown 的搜索逻辑 (Django 默认调用)。
        确保返回的数据格式满足 Select2 基本要求 (id, text)。
        """
        queryset, use_distinct = super().get_search_results(request, queryset, search_term)
        # 如果存在 search_term，应用自定义过滤逻辑
        if search_term:
             queryset = queryset.filter(
                 models.Q(name__icontains=search_term) |
                 models.Q(sezes__icontains=search_term) |
                 models.Q(types__icontains=search_term)
             )
        return queryset, use_distinct

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                'autocomplete/',
                self.admin_site.admin_view(self.autocomplete_view),
                # *** 非常重要：给你的自定义 URL 命名 ***
                name='commodity_autocomplete'
            ),
        ]
        print(custom_urls + urls) # 可以保留用于调试
        return custom_urls + urls

    def autocomplete_view(self, request):
        """
        处理 Select2 的 AJAX 请求。
        支持 'term' (用于搜索) 和 'id' (用于获取单个项的详细信息)。
        """
        results = []
        term = request.GET.get('term')
        item_id = request.GET.get('id') # 新增：处理根据 ID 获取详情的请求
        qs = self.get_queryset(request)
        if item_id:
            # 如果请求指定了 ID，只查找这个 ID 的商品
            qs = qs.filter(pk=item_id)
        elif term:
            # 否则，使用 term 进行搜索
            search_fields = self.get_search_fields(request)
            if search_fields and term:
                search_q = models.Q()
                for field in search_fields:
                    search_q |= models.Q(**{f'{field}__icontains': term})
                qs = qs.filter(search_q)
        else:
            # 如果既没有 term 也没有 id，可以返回空或前几个作为默认
            qs = qs[:20] # 限制数量
        for obj in qs:
            results.append({
                "id": obj.id,
                # Select2 dropdown 显示的文本 (保持简洁)
                "text": f"{obj.name} (规格: {obj.sezes} | 库存: {obj.stock})",
                # --- 额外数据 ---
                "name": obj.name,
                "sezes": obj.sezes,
                "types": obj.types,
                # 返回格式化的价格用于显示 (如果需要), 和原始价格用于计算
                "price_display": f"¥{obj.price:.2f}",
                "price_raw": obj.price, # **关键：返回原始数字价格**
                "stock": obj.stock,
                "inventory": obj.inventory, # 你模型中的字段
                "img": obj.img.url if obj.img else ""
            })
        # Select2 需要 'results' 键
        # Django autocomplete 通常不需要 pagination key，但 Select2 Ajax 可以用
        return JsonResponse({"results": results})