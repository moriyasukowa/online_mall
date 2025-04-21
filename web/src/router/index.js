import {createRouter, createWebHashHistory} from 'vue-router'
import Commodity from '../components/Commodity.vue'
import Detail from '../components/Detail.vue'
import Shopper from '../components/Shopper.vue'
import Login from '../components/Login.vue'
import Shopcart from '../components/Shopcart.vue'
import Error from '../components/Error.vue'
import AISupport from '../components/AISupport.vue'
import Refund from '../components/Refund.vue'
import AddressManagement from '../components/AddressManagement.vue'
import Checkout from '../components/Checkout.vue'
import OrderDetail from '../components/OrderDetail.vue'
// 定义路由
const routes = [
    {path: '/', redirect:'/commodity'},
    {path: '/commodity', component: Commodity, meta: {title: '商品列表页'}},
    // :id是设置路由变量
    {path: '/commodity/detail/:id', component: Detail, meta: {title: '商品详细页'}},
    {path: '/shopper', component: Shopper, meta: {title: '个人中心页'}},
    {path: '/aisupport', component: AISupport, meta: {title: 'AI客服'}},
    {path: '/shopper/login', component: Login, meta: {title: '用户登录页'}},
    {path: '/shopper/shopcart', component: Shopcart, meta: {title: '我的购物车'}},
    {path: '/shopper/refund', component: Refund, meta: {title: '退款'}},
    {path: '/shopper/address/add', component: AddressManagement, meta: {title: '地址管理'}},
    {
        path: '/checkout',
        name: 'Checkout',
        component: Checkout
      },
      {
        path: '/shopper/order/:orderId',
        name: 'OrderDetail',
        component: OrderDetail
    },
    // 路由匹配
    {path: '/:pathMatch(.*)*', component: Error, meta: {title: '页面丢失'}},
]

// 创建路由对象
const router = createRouter({
    // 设置历史记录模式
    history: createWebHashHistory(),
    // routes: routes的缩写
    routes,
})
export default router
