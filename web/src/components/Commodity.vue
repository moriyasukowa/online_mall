<template>
    <base-page :activation="activation"></base-page>
    <div class="commod-cont-wrap">
        <div class="commod-cont w1200 layui-clear">
            <div class="left-nav">
                <div class="title">商品分类</div>
                <div class="list-box">
                    <dl v-for="(t, key) in typesList" :key="key">
                        <dt>{{t.name}}</dt>
                        <dd v-for="(s, key_s) in t.value" :key="key_s">
                            <!-- 分类链接现在也保留排序信息 -->
                            <router-link :to="{ path: '/commodity', query: { 
                                            types: s,
                                            search: this.$route.query.search, 
                                            page: 1,
                                            sort: this.$route.query.sort,
                                            order: this.$route.query.order 
                                        }}">{{s}}
                            </router-link>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="right-cont-wrap">
                <div class="right-cont">
                    <div class="sort layui-clear">
                        <!-- 使用一个数组来定义排序选项，方便管理 -->
                        <a v-for="sortOption in sortOptions"
                           :key="sortOption.key"
                           href="javascript:void(0);"
                           @click="handleSort(sortOption.key)"
                           :class="{ 'active': $route.query.sort === sortOption.key }">
                            {{ sortOption.name }}
                            <span v-if="$route.query.sort === sortOption.key">
                                {{ $route.query.order === 'asc' ? '▲' : '▼' }}
                            </span>
                        </a>
                    </div>
                    <div class="prod-number">
                        <a href="javascript:;">商品列表</a>
                        <span>></span>
                        <a href="javascript:;">共{{ count }}件商品</a>
                    </div>
                    <div class="cont-list layui-clear" id="list-cont">
                        <div class="item" v-for="(c, key) in commodityInfos" :key="key">
                            <div class="img">
                                <router-link :to="`/commodity/detail/${c.id}`">
                                    <img height="280" width="280" :src="path + c.img" :alt="c.name">
                                </router-link>
                            </div>
                            <div class="text">
                                <p class="title">{{ c.name }}</p>
                                <p class="price">
                                    <span class="pri">￥{{ c.price }}</span>
                                    <span class="nub">{{ c.sold }}人付款</span> <!-- 之前是 {{c.sold}}付款 -->
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="demo0" style="text-align: center;">
                <div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
                    <!-- 分页链接现在也保留排序和顺序信息 -->
                    <router-link class="layui-laypage-prev" v-if="previousPage > 0"
                                 :to="{ path: '/commodity', query: { ...this.$route.query, page: previousPage }}">上一页
                    </router-link>
                    <a v-else href="javascript:void(0);" class="layui-laypage-prev layui-disabled">上一页</a>

                    <!-- 动态生成页码，这里简化处理，只显示上一页、当前页、下一页的简单逻辑 -->
                    <!-- 你可以根据需要扩展更复杂的页码显示 -->
                    <router-link v-if="previousPage > 0 && previousPage !== currentPage" 
                                 :to="{ path: '/commodity', query: { ...this.$route.query, page: previousPage }}">
                        {{ previousPage }}
                    </router-link>

                    <span class="layui-laypage-curr"><em class="layui-laypage-em"></em><em>{{ currentPage }}</em></span>

                    <router-link v-if="nextPage > 0 && nextPage !== currentPage && nextPage <= pageCount"
                                 :to="{ path: '/commodity', query: { ...this.$route.query, page: nextPage }}">
                        {{ nextPage }}
                    </router-link>
                    
                    <router-link class="layui-laypage-next" v-if="nextPage > 0 && nextPage <= pageCount"
                                 :to="{ path: '/commodity', query: { ...this.$route.query, page: nextPage }}">下一页
                    </router-link>
                    <a v-else href="javascript:void(0);" class="layui-laypage-next layui-disabled">下一页</a>
                </div>
            </div>
        </div>
    </div>
    <footer-page></footer-page>
</template>

<script>
    export default {
        name: "Commodity",
        data() {
            return {
                activation: "commodity",
                typesList: [], // 初始化为空数组
                commodityInfos: [], // 初始化为空数组
                count: 0,
                // API 返回的 next, previous 通常是完整的 URL 或 null，我们这里处理页码
                // 我们将从 API 响应中计算出这些值或者直接使用API提供的页码（如果后端设计如此）
                currentPage: 1,
                previousPage: 0, // 上一页的页码
                nextPage: 0,     // 下一页的页码
                pageCount: 0,    // 总页数
                path: this.$store.state.lookImgUrl,
                sortOptions: [ // 定义排序选项
                    { key: 'sold', name: '销量', defaultOrder: 'desc' },
                    { key: 'price', name: '价格', defaultOrder: 'asc' }, // 价格通常期望先升序
                    { key: 'created', name: '新品', defaultOrder: 'desc' }, //新品通常期望最新的在前
                    { key: 'likes', name: '收藏', defaultOrder: 'desc' }
                ]
            }
        },
        created() { // 使用 created 代替 mounted APl获取，路由变化时 watch会触发
            this.getCommodityData();
        },
        watch: {
            // 监听路由的 query 对象变化，当查询参数改变时重新获取数据
            "$route.query": {
                handler() {
                    this.getCommodityData();
                },
                deep: true // 深度监听
            }
        },
        methods: {
            getCommodityData: function () {
                // 从路由获取当前页码、排序字段和排序顺序，如果不存在则使用默认值
                this.currentPage = parseInt(this.$route.query.page) || 1;
                const currentSortField = this.$route.query.sort || 'sold'; // 默认按销量排序
                const currentSortOrder = this.$route.query.order || this.getDefaultOrder(currentSortField); // 默认排序方向

                this.axios.get('/api/v1/commodity/list/', {
                    params: {
                        search: this.$route.query.search,
                        sort: currentSortField,
                        order: currentSortOrder, // 新增 order 参数
                        types: this.$route.query.types,
                        page: this.currentPage,
                    }
                })
                .then(response => {
                    const resData = response.data.data;
                    this.typesList = resData.types || [];
                    this.commodityInfos = resData.commodityInfos.data || [];
                    this.count = resData.commodityInfos.count || 0;
                    
                    // 后端分页数据结构可能不同，这里假设后端返回了 `page`, `page_count`, `has_next`, `has_previous`
                    // 或者像你之前那样返回 `previous` (页码), `next` (页码), `pageCount`
                    // 我们这里适配你之前的分页逻辑，但使用更清晰的变量名
                    this.pageCount = resData.commodityInfos.pageCount || 0;
                    this.previousPage = resData.commodityInfos.previous || 0; // API 返回的上一页页码
                    this.nextPage = resData.commodityInfos.next || 0;         // API 返回的下一页页码

                    // 如果API直接返回当前页，可以覆盖
                    // this.currentPage = resData.commodityInfos.current_page || this.currentPage;

                    console.log("商品信息:", this.commodityInfos);
                })
                .catch(function (error) {
                    console.error("获取商品列表失败:", error);
                    // 可以添加用户提示，比如一个toast通知
                });
            },

            handleSort: function (fieldKey) {
                const currentRouteSort = this.$route.query.sort;
                const currentRouteOrder = this.$route.query.order;
                let newOrder;

                if (currentRouteSort === fieldKey) {
                    // 如果点击的是当前排序字段，则切换排序方向
                    newOrder = currentRouteOrder === 'asc' ? 'desc' : 'asc';
                } else {
                    // 如果点击的是新的排序字段，则使用该字段的默认排序方向
                    newOrder = this.getDefaultOrder(fieldKey);
                }

                // 使用 $router.push 更新 URL，这将触发 watch 中的 $route.query 监听器
                this.$router.push({
                    path: '/commodity',
                    query: {
                        ...this.$route.query, // 保留现有的 query 参数 (如 types, search)
                        sort: fieldKey,
                        order: newOrder,
                        page: 1 // 每次改变排序时，都回到第一页
                    }
                });
            },
            
            getDefaultOrder(fieldKey) {
                const option = this.sortOptions.find(opt => opt.key === fieldKey);
                return option ? option.defaultOrder : 'desc'; // 如果找不到，默认降序
            }
        }
    }
</script>

<style scoped>
/* 样式可以保持不变，或者根据需要微调 */
.sort a {
    cursor: pointer; /* 让用户知道这是可点击的 */
    margin-right: 15px; /* 增加一些间距 */
    padding: 5px 8px;
    border-radius: 3px;
    transition: background-color 0.3s ease;
}
.sort a.active {
    background-color: #009688; /* layui 主题色示例 */
    color: white;
}
.sort a span {
    font-size: 0.8em; /* 让箭头小一点 */
    margin-left: 5px;
}

/* 简单的分页禁用样式 */
.layui-laypage-prev.layui-disabled,
.layui-laypage-next.layui-disabled {
    color: #ccc;
    cursor: not-allowed;
}
</style>
