<template>
    <base-page :activation="activation"></base-page>
    <div class="checkout-container w1200">
      <div class="checkout-header">
        <h2>确认订单</h2>
      </div>
      
      <!-- 收货地址选择 -->
      <div class="address-section">
        <div class="section-title">
          <h3>收货地址</h3>
          <a href="javascript:;" @click="showAddressForm(null)" class="add-address-btn">
            <i class="layui-icon layui-icon-add-1"></i> 新增地址
          </a>
        </div>
        
        <div class="address-list">
          <div v-if="addressList.length === 0" class="empty-address">
            <p>您还没有添加收货地址，请先添加收货地址</p>
          </div>
          <div v-else class="address-items">
            <div 
              v-for="address in addressList" 
              :key="address.id" 
              class="address-item"
              :class="{ 'selected': selectedAddress && selectedAddress.id === address.id }"
              @click="selectAddress(address)"
            >
              <div class="address-info">
                <div class="address-top">
                  <span class="recipient">{{ address.recipient_name }}</span>
                  <span class="phone">{{ formatPhone(address.phone_number) }}</span>
                  <span v-if="address.is_default" class="default-tag">默认地址</span>
                </div>
                <div class="address-detail">
                  {{ address.province.name }} {{ address.city.name }} {{ address.district.name }} {{ address.detail }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 订单商品信息 -->
      <div class="order-items-section">
        <div class="section-title">
          <h3>商品清单</h3>
        </div>
        
        <div class="order-table">
          <div class="order-table-header">
            <div class="col-product">商品</div>
            <div class="col-price">单价</div>
            <div class="col-quantity">数量</div>
            <div class="col-subtotal">小计</div>
          </div>
          
          <div class="order-table-body">
            <div v-for="(item, index) in checkoutItems" :key="index" class="order-item">
              <div class="col-product">
                <div class="product-info">
                  <img :src="path + item.commodityInfos_id.img" alt="商品图片">
                  <div class="product-details">
                    <div class="product-name">{{ item.commodityInfos_id.name }}</div>
                    <div class="product-specs">{{ item.commodityInfos_id.sezes }}</div>
                  </div>
                </div>
              </div>
              <div class="col-price">¥{{ item.commodityInfos_id.price }}</div>
              <div class="col-quantity">{{ item.quantity }}</div>
              <div class="col-subtotal">¥{{ (item.commodityInfos_id.price * item.quantity).toFixed(2) }}</div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 订单备注 -->
      <div class="order-remark-section">
        <div class="section-title">
          <h3>订单备注</h3>
        </div>
        <div class="remark-input">
          <textarea v-model="orderRemark" placeholder="请输入订单备注信息（选填）"></textarea>
        </div>
      </div>
      
      <!-- 订单汇总 -->
      <div class="order-summary">
        <div class="summary-item">
          <span>商品件数：</span>
          <span>{{ totalQuantity }}件</span>
        </div>
        <div class="summary-item">
          <span>商品总价：</span>
          <span>{{ totalAmount }}</span>
        </div>
        <div class="summary-item total">
          <span>应付金额：</span>
          <span class="total-price">{{ totalAmount }}</span>
        </div>
        
        <div class="checkout-actions">
          <button class="layui-btn layui-btn-primary" @click="backToCart">返回购物车</button>
          <button class="layui-btn" @click="submitOrder" :disabled="!selectedAddress">提交订单</button>
        </div>
      </div>
    </div>
    
    <!-- 地址表单弹窗 -->
    <div v-if="showForm" class="address-form-dialog">
      <div class="dialog-content">
        <div class="dialog-header">
          <h3>{{ isEdit ? '编辑地址' : '新增地址' }}</h3>
          <span class="close-btn" @click="showForm = false">&times;</span>
        </div>
        <div class="dialog-body">
          <form @submit.prevent="saveAddress">
            <div class="form-item">
              <label>收件人姓名</label>
              <input type="text" v-model="addressForm.recipient_name" required>
            </div>
            <div class="form-item">
              <label>联系电话</label>
              <input type="tel" v-model="addressForm.phone_number" required pattern="[0-9]{11}">
            </div>
            <div class="form-item address-select">
              <label>所在地区</label>
              <div class="select-group">
                <select v-model="addressForm.province_id" @change="provinceChange" required>
                  <option value="">请选择省份</option>
                  <option v-for="item in provinces" :key="item.id" :value="item.id">{{ item.name }}</option>
                </select>
                <select v-model="addressForm.city_id" @change="cityChange" required>
                  <option value="">请选择城市</option>
                  <option v-for="item in cities" :key="item.id" :value="item.id">{{ item.name }}</option>
                </select>
                <select v-model="addressForm.district_id" required>
                  <option value="">请选择区县</option>
                  <option v-for="item in districts" :key="item.id" :value="item.id">{{ item.name }}</option>
                </select>
              </div>
            </div>
            <div class="form-item">
              <label>详细地址</label>
              <input type="text" v-model="addressForm.detail" required>
            </div>
            <div class="form-item checkbox">
              <input type="checkbox" id="is_default" v-model="addressForm.is_default">
              <label for="is_default">设为默认地址</label>
            </div>
            <div class="form-actions">
              <button type="button" class="layui-btn layui-btn-primary" @click="showForm = false">取消</button>
              <button type="submit" class="layui-btn">保存</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    
    <footer-page></footer-page>
  </template>
  
  <script>
  export default {
    name: "Checkout",
    data() {
      return {
        activation: 'shopcart',
        checkoutItems: [],
        totalAmount: '¥0.00',
        addressList: [],
        selectedAddress: null,
        orderRemark: '',
        path: this.$store.state.lookImgUrl,
        
        // 地址表单相关数据
        showForm: false,
        isEdit: false,
        addressForm: {
          id: null,
          recipient_name: '',
          phone_number: '',
          province_id: '',
          city_id: '',
          district_id: '',
          detail: '',
          is_default: false
        },
        provinces: [],
        cities: [],
        districts: []
      }
    },
    computed: {
      totalQuantity() {
        return this.checkoutItems.reduce((total, item) => total + parseInt(item.quantity), 0);
      }
    },
    mounted() {
      this.loadCheckoutData();
      this.getAddressList();
      this.getProvinces();
    },
    methods: {
      // 加载结算数据
      loadCheckoutData() {
        const checkoutData = JSON.parse(sessionStorage.getItem('checkoutData') || '{"items":[],"total":"¥0.00"}');
        this.checkoutItems = checkoutData.items;
        this.totalAmount = checkoutData.total;
      },
      
      // 获取地址列表
      getAddressList() {
        this.axios.get('/api/v1/shopper/address/').then(response => {
          if (response.data.state === 'success') {
            this.addressList = response.data.data.addresses;
            
            // 如果有默认地址，自动选择默认地址
            const defaultAddress = this.addressList.find(addr => addr.is_default);
            if (defaultAddress) {
              this.selectedAddress = defaultAddress;
            } else if (this.addressList.length > 0) {
              // 如果没有默认地址但有地址，选择第一个
              this.selectedAddress = this.addressList[0];
            }
          }
        }).catch(error => {
          console.log(error);
        });
      },
      
      // 选择地址
      selectAddress(address) {
        this.selectedAddress = address;
      },
      
      // 返回购物车
      backToCart() {
        this.$router.push('/shopper/shopcart');
      },
      
      // 提交订单并跳转到支付页面
      submitOrder() {
        if (!this.selectedAddress) {
          alert('请选择收货地址');
          return;
        }
        
        // 构建订单数据
        const orderData = {
          address_id: this.selectedAddress.id,
          remark: this.orderRemark,
          total: this.totalAmount.replace('¥', ''),
          items: this.checkoutItems.map(item => ({
            commodity_id: item.commodityInfos_id.id,
            quantity: item.quantity
          }))
        };
        
        
        sessionStorage.removeItem('checkoutData');

        this.axios.post('/api/v1/shopper/pays/', orderData).then(payResponse => {
            if (payResponse.data.data !== '') {
            window.location.href = payResponse.data.data;
            }
        }).catch(error => {
            console.log(error);
        });
      },
      
      // 格式化手机号
      formatPhone(phone) {
        const phoneStr = phone.toString();
        return phoneStr.substring(0, 3) + '****' + phoneStr.substring(7);
      },
      
      // 以下是地址表单相关方法
      showAddressForm(address) {
        if (address) {
          // 编辑模式
          this.isEdit = true;
          this.addressForm = {
            id: address.id,
            recipient_name: address.recipient_name,
            phone_number: address.phone_number,
            province_id: address.province.id,
            city_id: address.city.id,
            district_id: address.district.id,
            detail: address.detail,
            is_default: address.is_default
          };
          
          // 加载城市和区县数据
          this.axios.get(`/shopper/region_list/?parent_id=${address.province.id}`).then(response => {
            this.cities = response.data.data;
            
            this.axios.get(`/shopper/region_list/?parent_id=${address.city.id}`).then(response => {
              this.districts = response.data.data;
            });
          });
        } else {
          // 新增模式
          this.isEdit = false;
          this.addressForm = {
            id: null,
            recipient_name: '',
            phone_number: '',
            province_id: '',
            city_id: '',
            district_id: '',
            detail: '',
            is_default: false
          };
        }
        
        this.showForm = true;
      },
      
      // 获取省份列表
      getProvinces() {
        this.axios.get('/shopper/region_list/?parent_id=0').then(response => {
          this.provinces = response.data.data;
        }).catch(error => {
          console.log(error);
        });
      },
      
      // 省份变更时获取城市列表
      provinceChange() {
        this.addressForm.city_id = '';
        this.addressForm.district_id = '';
        this.cities = [];
        this.districts = [];
        
        if (this.addressForm.province_id) {
          this.axios.get(`/shopper/region_list/?parent_id=${this.addressForm.province_id}`).then(response => {
            this.cities = response.data.data;
          }).catch(error => {
            console.log(error);
          });
        }
      },
      
      // 城市变更时获取区县列表
      cityChange() {
        this.addressForm.district_id = '';
        this.districts = [];
        
        if (this.addressForm.city_id) {
          this.axios.get(`/shopper/region_list/?parent_id=${this.addressForm.city_id}`).then(response => {
            this.districts = response.data.data;
          }).catch(error => {
            console.log(error);
          });
        }
      },
      
      // 保存地址
      saveAddress() {
        const url = this.isEdit ? 
          `/api/v1/shopper/address/${this.addressForm.id}/` : 
          '/api/v1/shopper/address/';
        
        const method = this.isEdit ? 'put' : 'post';
        
        const data = {
          recipient_name: this.addressForm.recipient_name,
          phone_number: parseInt(this.addressForm.phone_number),
          province: this.addressForm.province_id,
          city: this.addressForm.city_id,
          district: this.addressForm.district_id,
          detail: this.addressForm.detail,
          is_default: this.addressForm.is_default
        };
        
        this.axios[method](url, data)
          .then(response => {
            if (response.data.state === 'success') {
              alert(this.isEdit ? '地址更新成功' : '地址添加成功');
              this.showForm = false;
              this.getAddressList();
            } else {
              alert(response.data.msg || '操作失败');
            }
          })
          .catch(error => {
            console.error('Error:', error);
            alert('操作失败');
          });
      }
    }
  }
  </script>
  
  <style scoped>
  .checkout-container {
    background-color: #fff;
    padding: 20px;
    margin: 20px auto;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  }
  
  .checkout-header {
    border-bottom: 1px solid #eee;
    padding-bottom: 15px;
    margin-bottom: 20px;
  }
  
  .section-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .section-title h3 {
    font-size: 16px;
    font-weight: bold;
  }
  
  .address-section, .order-items-section, .order-remark-section {
    margin-bottom: 30px;
  }
  
  /* 地址列表样式 */
  .address-items {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
  }
  
  .address-item {
    border: 1px solid #ddd;
    padding: 15px;
    border-radius: 4px;
    width: calc(33.33% - 10px);
    cursor: pointer;
    transition: all 0.3s;
  }
  
  .address-item:hover {
    border-color: #1E9FFF;
  }
  
  .address-item.selected {
    border-color: #1E9FFF;
    background-color: #f0f9ff;
  }
  
  .recipient {
    font-weight: bold;
    margin-right: 10px;
  }
  
  .phone {
    color: #666;
  }
  
  .default-tag {
    background-color: #1E9FFF;
    color: white;
    padding: 2px 6px;
    border-radius: 2px;
    font-size: 12px;
    margin-left: 10px;
  }
  
  .address-detail {
    margin-top: 10px;
    color: #666;
  }
  
  /* 订单表格样式 */
  .order-table {
    border: 1px solid #eee;
    border-radius: 4px;
  }
  
  .order-table-header {
    display: flex;
    background-color: #f8f8f8;
    padding: 12px 0;
    font-weight: bold;
  }
  
  .order-item {
    display: flex;
    padding: 15px 0;
    border-top: 1px solid #eee;
  }
  
  .col-product {
    flex: 5;
    padding: 0 15px;
  }
  
  .col-price, .col-quantity, .col-subtotal {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .product-info {
    display: flex;
    align-items: center;
  }
  
  .product-info img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    margin-right: 15px;
  }
  
  .product-name {
    font-weight: bold;
    margin-bottom: 5px;
  }
  
  .product-specs {
    color: #999;
    font-size: 12px;
  }
  
  /* 备注区域样式 */
  .remark-input textarea {
    width: 100%;
    height: 80px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    resize: none;
  }
  
  /* 订单汇总样式 */
  .order-summary {
    background-color: #f8f8f8;
    padding: 20px;
    border-radius: 4px;
  }
  
  .summary-item {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 10px;
  }
  
  .summary-item span:first-child {
    margin-right: 15px;
  }
  
  .summary-item.total {
    font-size: 18px;
    font-weight: bold;
    color: #FF5722;
  }
  
  .checkout-actions {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
  }
  
  .checkout-actions button {
    margin-left: 15px;
  }
  
  /* 地址表单弹窗样式 */
  .address-form-dialog {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }
  
  .dialog-content {
    background-color: white;
    width: 500px;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  }
  
  .dialog-header {
    padding: 15px 20px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .close-btn {
    cursor: pointer;
    font-size: 20px;
  }
  
  .dialog-body {
    padding: 20px;
  }
  
  .form-item {
    margin-bottom: 15px;
  }
  
  .form-item label {
    display: block;
    margin-bottom: 5px;
  }
  
  .form-item input, .form-item select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
  
  .select-group {
    display: flex;
    gap: 10px;
  }
  
  .select-group select {
    flex: 1;
  }
  
  .form-item.checkbox {
    display: flex;
    align-items: center;
  }
  
  .form-item.checkbox input {
    width: auto;
    margin-right: 5px;
  }
  
  .form-actions {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
  }
  
  .form-actions button {
    margin-left: 10px;
  }
  
  .add-address-btn {
    color: #1E9FFF;
    font-size: 14px;
  }
  
  .empty-address {
    text-align: center;
    padding: 30px;
    color: #999;
  }
  </style>
  