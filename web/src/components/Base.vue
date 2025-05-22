<template>
  <div class="app-header">
    <div class="header-container">
      <div class="header-content">
        <div class="logo-container">
          <router-link to="/" title="首页">
            <img src="img/logo1.png" alt="商城Logo" class="logo-img">
          </router-link>
        </div>
        
        <div class="search-container">
          <div class="search-box">
            <input 
              type="text" 
              v-model="search" 
              class="search-input" 
              placeholder="搜索商品..." 
              @keyup.enter="mySearch"
              @input="fetchSuggestions"
              @focus="showDropdown = true"
              @blur="handleBlur"
            >
            <button class="search-button" @click="mySearch">
              <i class="search-icon"></i>
            </button>
          </div>
          
          <!-- 搜索下拉框 -->
          <div v-if="showDropdown && searchResults.length > 0" class="search-dropdown">
            <div 
              v-for="(item, index) in searchResults" 
              :key="index" 
              class="search-item"
              @mousedown="selectSearchItem(item)"
            >
              <div class="search-item-img">
                <img :src="item.img" :alt="item.name">
              </div>
              <div class="search-item-info">
                <div class="search-item-name">{{ item.name }}</div>
                <div class="search-item-price">
                  <span class="discount-price">¥{{ item.discount }}</span>
                  <span class="original-price" v-if="item.price !== item.discount">¥{{ item.price }}</span>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 无搜索结果提示 -->
          <div v-if="showDropdown && search.trim() && searchResults.length === 0 && !isLoading" class="no-results">
            没有找到相关商品
          </div>
          
          <!-- 加载中提示 -->
          <div v-if="showDropdown && isLoading" class="loading-results">
            <div class="loading-spinner"></div>
            <span>搜索中...</span>
          </div>
        </div>
      </div>
    </div>
    
    <nav class="main-navigation">
      <div class="nav-container">
        <div class="nav-links">
          <router-link 
            to="/commodity" 
            :class="['nav-link', { 'active': activation === 'commodity' }]"
          >
            首页
          </router-link>
          <router-link 
            to="/shopper/shopcart" 
            :class="['nav-link', { 'active': activation === 'shopcart' }]"
          >
            购物车
          </router-link>
          <router-link 
            to="/shopper" 
            :class="['nav-link', { 'active': activation === 'shopper' }]"
          >
            个人中心
          </router-link>
          <router-link 
            to="/aisupport" 
            :class="['nav-link', { 'active': activation === 'AISupport' }]"
          >
            AI客服
          </router-link>
        </div>
      </div>
    </nav>
  </div>
</template>

<script>
import { debounce } from 'lodash'; // 需要安装: npm install lodash

export default {
  data() {
    return {
      search: '',
      searchResults: [],
      showDropdown: false,
      isLoading: false,
      debounceTimeout: null
    }
  },
  props: {
    activation: {
      type: String,
      default: ''
    },
  },
  created() {
    // 使用lodash的debounce方法创建一个防抖的fetchSuggestions函数
    this.debouncedFetchSuggestions = debounce(this.doFetchSuggestions, 300);
  },
  methods: {
    mySearch() {
      if (this.search.trim()) {
        this.$router.push({
          path: '/commodity', 
          query: { 
            search: this.search.trim(), 
            page: 1 
          }
        });
        this.showDropdown = false;
      }
    },
    
    // 输入时触发搜索建议
    fetchSuggestions() {
      if (this.search.trim().length < 1) {
        this.searchResults = [];
        this.isLoading = false;
        return;
      }
      
      this.isLoading = true;
      this.debouncedFetchSuggestions();
    },
    
    // 实际执行API请求的方法（防抖后）
    doFetchSuggestions() {
      const searchTerm = this.search.trim();
      if (!searchTerm) {
        this.searchResults = [];
        this.isLoading = false;
        return;
      }
      
      // 调用后端API获取搜索结果
      this.axios.get('/api/v1/commodity/search-suggestions/', {
        params: {
          q: searchTerm,
          limit: 5 // 限制返回结果数量
        }
      })
      .then(response => {
        if (response.data && response.data.state === 'success') {
          const serverBaseUrl = this.$store.state.lookImgUrl || ''; // 获取图片服务器基础URL
          
          // 处理返回的商品结果，添加完整的图片URL
          this.searchResults = response.data.data.map(item => ({
            ...item,
            img: item.img.startsWith('http') ? item.img : `${serverBaseUrl}${item.img}`
          }));
        } else {
          this.searchResults = [];
          console.error('获取搜索建议失败:', response.data.msg);
        }
        this.isLoading = false;
      })
      .catch(error => {
        console.error('获取搜索建议出错:', error);
        this.searchResults = [];
        this.isLoading = false;
      });
    },
    
    // 选择下拉框中的某个商品
    selectSearchItem(item) {
      // 可以直接跳转到商品详情页
      this.$router.push(`/commodity/detail/${item.id}`);
      this.showDropdown = false;
    },
    
    // 处理输入框失焦事件
    handleBlur() {
      // 使用setTimeout是为了让点击下拉项的事件先触发
      setTimeout(() => {
        this.showDropdown = false;
      }, 200);
    }
  }
}
</script>

<style scoped>
.app-header {
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  background-color: #fff;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.header-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 15px 0;
}

.logo-container .logo-img {
  height: 50px;
  transition: transform 0.3s ease;
}

.logo-container .logo-img:hover {
  transform: scale(1.05);
}

.search-container {
  flex: 1;
  max-width: 600px;
  margin: 0 30px;
  position: relative; /* 添加这行使下拉框定位相对于搜索容器 */
}

.search-box {
  display: flex;
  border: 2px solid #ff6700;
  border-radius: 24px;
  overflow: hidden;
  transition: all 0.3s ease;
}

.search-box:focus-within {
  box-shadow: 0 0 8px rgba(255, 103, 0, 0.4);
}

.search-input {
  flex: 1;
  padding: 10px 20px;
  border: none;
  outline: none;
  font-size: 16px;
}

.search-button {
  width: 50px;
  background-color: #ff6700;
  color: white;
  border: none;
  cursor: pointer;
  transition: background-color 0.3s;
}

.search-button:hover {
  background-color: #ff8533;
}

.search-icon {
  display: inline-block;
  width: 20px;
  height: 20px;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M15.5 14h-.79l-.28-.27a6.5 6.5 0 0 0 1.48-5.34c-.47-2.78-2.79-5-5.59-5.34a6.505 6.505 0 0 0-7.27 7.27c.34 2.8 2.56 5.12 5.34 5.59a6.5 6.5 0 0 0 5.34-1.48l.27.28v.79l4.25 4.25c.41.41 1.08.41 1.49 0 .41-.41.41-1.08 0-1.49L15.5 14zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: center;
}

/* 搜索下拉框样式 */
.search-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  margin-top: 8px;
  max-height: 400px;
  overflow-y: auto;
  z-index: 1001;
}

.search-item {
  display: flex;
  padding: 12px;
  border-bottom: 1px solid #eee;
  cursor: pointer;
  transition: background-color 0.2s;
}

.search-item:last-child {
  border-bottom: none;
}

.search-item:hover {
  background-color: #f9f9f9;
}

.search-item-img {
  width: 60px;
  height: 60px;
  margin-right: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.search-item-img img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
}

.search-item-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.search-item-name {
  font-size: 14px;
  color: #333;
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.search-item-price {
  display: flex;
  align-items: center;
}

.discount-price {
  color: #ff6700;
  font-weight: bold;
  font-size: 16px;
}

.original-price {
  color: #999;
  text-decoration: line-through;
  font-size: 12px;
  margin-left: 6px;
}

/* 无结果提示样式 */
.no-results {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  margin-top: 8px;
  padding: 15px;
  text-align: center;
  color: #999;
  z-index: 1001;
}

/* 加载中提示样式 */
.loading-results {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  margin-top: 8px;
  padding: 15px;
  text-align: center;
  color: #666;
  z-index: 1001;
  display: flex;
  align-items: center;
  justify-content: center;
}

.loading-spinner {
  width: 20px;
  height: 20px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #ff6700;
  border-radius: 50%;
  margin-right: 10px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.main-navigation {
  background-color: #333;
  color: white;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
}

.nav-links {
  display: flex;
}

.nav-link {
  color: white;
  text-decoration: none;
  padding: 15px 25px;
  font-size: 16px;
  transition: all 0.3s ease;
  position: relative;
}

.nav-link:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.nav-link.active {
  background-color: #ff6700;
  color: white;
}

.nav-link.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 0;
  border-left: 8px solid transparent;
  border-right: 8px solid transparent;
  border-bottom: 8px solid white;
}
</style>
