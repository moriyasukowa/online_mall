<template>
    <base-page :activation="activation"></base-page>
    <div class="carts w1200">
        <div class="copy_cart-table-th">
            <div class="copy_th th-chk">
                <div class="select-all">
                    <div class="cart-checkbox">
                        <input class="check-all check" id="allCheckked" type="checkbox" value="true">
                    </div>
                    <label>全选</label>
                </div>
            </div>
            <div class="copy_th th-item">
                <div class="th-inner">商品</div>
            </div>
            <div class="copy_th th-price">
                <div class="th-inner">单价</div>
            </div>
            <div class="copy_th th-amount">
                <div class="th-inner">数量</div>
            </div>
            <div class="copy_th th-sum">
                <div class="th-inner">小计</div>
            </div>
            <div class="copy_th th-op">
                <div class="th-inner">操作</div>
            </div>
        </div>
        <div class="OrderList">
            <div class="order-content" id="list-cont">

                <ul class="item-content layui-clear" v-for="(c, key) in cartInfos" :key="key">
                    <li class="copy_th th-chk">
                        <div class="select-all">
                            <div class="cart-checkbox">
                                <input class="CheckBoxShop check" id=""
                                       type="checkbox" num="all" name="select-all" value="true">
                            </div>
                        </div>
                    </li>
                    <li class="copy_th th-item">
                        <div class="item-cont">
                            <a href="javascript:;"><img :src="pacopy_th + c.commodityInfos_id.img"></a>
                            <div class="text">
                                <div class="title">{{ c.commodityInfos_id.name }}</div>
                                <p><span>{{ c.commodityInfos_id.sezes }}</span></p>
                            </div>
                        </div>
                    </li>
                    <li class="copy_th th-price">
                        <span class="th-su">{{ c.commodityInfos_id.price }}</span>
                    </li>
                    <li class="copy_th th-amount">
                        <div class="box-btn layui-clear">
                            <div class="less layui-btn" >-</div>
                            <input class="Quantity-input" :value="c.quantity" disabled="disabled">
                            <div class="add layui-btn" 
                            >+</div>
                        </div>
                    </li>
                    <li class="copy_th th-sum">
                        <span class="sum">0</span>
                    </li>
                    <li class="copy_th th-op" @click="delCarInfo(c.id)">
                        <span>删除</span>
                        <p hidden="hidden">{{ c.id }}</p>
                    </li>
                </ul>

            </div>
        </div>
        <div class="FloatBarHolder layui-clear">
            <div class="copy_th th-chk">
                <div class="select-all">
                    <div class="cart-checkbox">
                        <input class="check-all check" name="select-all" type="checkbox" value="true">
                    </div>
                    <label>&nbsp;&nbsp;已选<span class="Selected-pieces">0</span>件</label>
                </div>
            </div>
            <div class="copy_th batch-deletion" @click="delCarInfo(username)">
                <span class="batch-dele-btn">删除全部</span>
                <p hidden="hidden" id="userId">{{ username }}</p>
            </div>
            <div class="copy_th Settlement">
                <button class="layui-btn" @click="goToCheckout">结算</button>
            </div>
            <div class="copy_th total">
                <p>应付：<span class="pieces-total">￥0.00</span></p>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Shopcart",
        data() {
            return {
                activation: 'shopcart',
                cartInfos: [],
                username: this.$store.state.username,
                path: this.$store.state.lookImgUrl
            }
        },
        beforeMount: function(){
            this.getcode(); //页面加载时自动执行
        },
        updated: function () {
            this.getSum(); //页面更新完成执行JS计算价钱
        },
        methods: {
            getcode () {
                this.axios.get('/api/v1/shopper/shopcart/').then(response => {
                    this.cartInfos = response.data.data
                    this.getSum()
                })
                    .catch(function (error) {
                        console.log(error)
                    })
            },
            // 修改结算按钮的处理函数
            goToCheckout: function () {
                // 获取选中的商品和总金额
                const selectedItems = [];
                const checkboxes = document.querySelectorAll('.CheckBoxShop.check:checked');
                
                checkboxes.forEach((checkbox, index) => {
                    const item = this.cartInfos[index];
                    if (item) {
                        selectedItems.push(item);
                    }
                });
                
                // 如果没有选中商品，提示用户
                if (selectedItems.length === 0) {
                    alert('请选择要结算的商品');
                    return;
                }
                
                // 将选中的商品信息和总金额存入 store 或 sessionStorage
                const total = window.layui.$(".pieces-total").text();
                const checkoutData = {
                    items: selectedItems,
                    total: total
                };
                
                // 使用 sessionStorage 存储结算数据
                sessionStorage.setItem('checkoutData', JSON.stringify(checkoutData));
                
                // 跳转到结算页面
                this.$router.push('/checkout');
            },
            delCarInfo(style) {
                var d
                if (style === this.username) {
                    d = {username: this.username}
                } else {
                    d = {carId: style}
                }
                this.axios.post('/api/v1/shopper/delete/', d).then(response => {
                    if (response.data.state === 'success') {
                        // 删除成功
                        this.getcode(); //重新加载购物车
                    }
                })
                    .catch(function (error) {
                        console.log(error)
                    })
            },
            getSum: function () {
                window.layui.config({
                    base: 'js/'
                }).use(['jquery', 'element', 'car'], function () {
                    var $ = window.layui.$;
                    var car = window.layui.car;
                    car.init();
                    $(function () {
                        var counts = 0;
                        $(".sum").each(function (i, e) {
                            var quantity = $('.th-su')[i].innerHTML
                            var price = $('.Quantity-input')[i].value
                            e.innerHTML = (quantity * price).toFixed(2)
                            counts = counts * 1 + e.innerHTML * 1
                        });
                        $(".pieces-total").text("￥" + counts.toFixed(2))
                    });
                });
            }
        },
    }
</script>

<style>

</style>