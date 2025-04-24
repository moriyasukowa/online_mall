import { createApp } from 'vue'
import VueAxios from 'vue-axios'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from './axios'
import base from './components/Base'
import footer from './components/Footer'
import ElementPlus from 'element-plus'
import * as ElementPlusIconsVue from '@element-plus/icons-vue' // 如果使用了图标
import 'element-plus/dist/index.css'

// 创建Vue对象
const app = createApp(App)
// 注册组件
app.component('base-page', base)
app.component('footer-page', footer)
// 将路由对象绑定到Vue对象
app.use(router)
app.use(store)
app.use(ElementPlus)
// 注册 Element Plus Icons (如果需要)
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
  }
// 将vue-axios与axios关联并绑定到Vue对象
app.use(VueAxios, axios)
// 挂载使用Vue对象
app.mount('#app')
