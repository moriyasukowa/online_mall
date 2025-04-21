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
            >
            <button class="search-button" @click="mySearch">
              <i class="search-icon"></i>
            </button>
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
export default {
  data() {
    return {
      search: ''
    }
  },
  props: {
    activation: {
      type: String,
      default: ''
    },
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
        })
      }
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
