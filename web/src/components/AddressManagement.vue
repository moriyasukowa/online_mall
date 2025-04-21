<template>
    <base-page :activation="activation"></base-page>
    <div class="data-cont-wrap w1200">
      <div class="address-container">
        <div class="address-header">
          <h2>收货地址管理</h2>
          <button class="layui-btn" @click="showAddressForm(null)">
            <i class="layui-icon layui-icon-add-1"></i> 新增地址
          </button>
        </div>
        
        <!-- 地址列表 -->
        <div class="address-list">
          <div v-if="addressList.length === 0" class="empty-address">
            <p>您还没有添加收货地址</p>
          </div>
          <div v-else v-for="address in addressList" :key="address.id" class="address-item">
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
            <div class="address-actions">
              <a href="javascript:;" @click="showAddressForm(address)">编辑</a>
              <a href="javascript:;" @click="deleteAddress(address.id)">删除</a>
              <a v-if="!address.is_default" href="javascript:;" @click="setDefaultAddress(address.id)">设为默认</a>
            </div>
          </div>
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
    name: "AddressManagement",
    data() {
      return {
        activation: "user",
        addressList: [],
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
    mounted() {
      this.getAddressList();
      this.getProvinces();
    },
    methods: {
      // 获取地址列表
      getAddressList() {
        this.axios.get('/api/v1/shopper/address/').then(response => {
          if (response.data.state === 'success') {
            this.addressList = response.data.data.addresses;
          }
        }).catch(error => {
          console.log(error);
          this.$message.error('获取地址列表失败');
        });
      },
      
      // 获取省份列表
      getProvinces() {
        this.axios.get('/shopper/region_list/?parent_id=0').then(response => {
          this.provinces = response.data.data;
          console.log(this.provinces);
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
      
      // 显示地址表单
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
      
      // 保存地址
      saveAddress() {
        const url = this.isEdit ? 
          `/api/v1/shopper/address/${this.addressForm.id}/` : 
          '/api/v1/shopper/address/';
        
        const method = this.isEdit ? 'put' : 'post';
        
        const data = {
          recipient_name: this.addressForm.recipient_name,
          phone_number: parseInt(this.addressForm.phone_number), // 确保是整数
          province: this.addressForm.province_id,
          city: this.addressForm.city_id,
          district: this.addressForm.district_id,
          detail: this.addressForm.detail,
          is_default: this.addressForm.is_default
        };
        
        console.log('Sending address data:', data);
        
        this.axios[method](url, data)
    .then(response => {
      if (response.data.state === 'success') {
        this.$message.success(this.isEdit ? '地址更新成功' : '地址添加成功');
        this.showForm = false;
        this.getAddressList();
      } else {
        this.$message.error(response.data.msg || '操作失败');
      }
    })
    .catch(error => {
      console.error('Error:', error);
      
      // 更安全的错误处理
      let errorMsg = '操作失败';
      try {
        if (error.response) {
          if (error.response.status === 403) {
            errorMsg = '没有权限执行此操作，请确认是否已登录';
          } else if (error.response.data && error.response.data.msg) {
            errorMsg = error.response.data.msg;
          }
        }
      } catch (e) {
        console.error('Error parsing error response:', e);
      }
      
      this.$message.error(errorMsg);
    });
      },
      
      // 删除地址
      deleteAddress(id) {
        if (confirm('确定要删除这个地址吗？')) {
          this.axios.delete(`/api/v1/shopper/address/${id}/`).then(response => {
            if (response.data.state === 'success') {
              this.$message.success('地址删除成功');
              this.getAddressList();
            } else {
              this.$message.error(response.data.msg || '删除失败');
            }
          }).catch(error => {
            console.log(error);
            this.$message.error('删除失败');
          });
        }
      },
      
      // 设置默认地址
      setDefaultAddress(id) {
        this.axios.post('/api/v1/shopper/address/default/', {
          address_id: id
        }).then(response => {
          if (response.data.state === 'success') {
            this.$message.success('默认地址设置成功');
            this.getAddressList();
          } else {
            this.$message.error(response.data.msg || '设置失败');
          }
        }).catch(error => {
          console.log(error);
          this.$message.error('设置失败');
        });
      },
      
      // 格式化手机号
      formatPhone(phone) {
        const phoneStr = phone.toString();
        return phoneStr.substring(0, 3) + '****' + phoneStr.substring(7);
      }
    }
  }
  </script>
  
  <style scoped>
  .address-container {
    background: #fff;
    padding: 20px;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    margin: 20px 0;
  }
  
  .address-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
  }
  
  .address-list {
    margin-top: 20px;
  }
  
  .empty-address {
    text-align: center;
    padding: 30px 0;
    color: #999;
  }
  
  .address-item {
    display: flex;
    justify-content: space-between;
    padding: 15px;
    border: 1px solid #eee;
    border-radius: 4px;
    margin-bottom: 15px;
    transition: all 0.3s;
  }
  
  .address-item:hover {
    border-color: #FF5722;
    box-shadow: 0 2px 8px rgba(0,0,0,0.09);
  }
  
  .address-info {
    flex: 1;
  }
  
  .address-top {
    margin-bottom: 8px;
  }
  
  .recipient {
    font-weight: bold;
    margin-right: 15px;
  }
  
  .phone {
    color: #666;
  }
  
  .default-tag {
    display: inline-block;
    background: #FF5722;
    color: #fff;
    font-size: 12px;
    padding: 2px 6px;
    border-radius: 2px;
    margin-left: 10px;
  }
  
  .address-detail {
    color: #333;
    line-height: 1.5;
  }
  
  .address-actions {
    display: flex;
    flex-direction: column;
    justify-content: center;
    min-width: 80px;
  }
  
  .address-actions a {
    color: #1E9FFF;
    margin: 3px 0;
    text-decoration: none;
  }
  
  .address-actions a:hover {
    color: #FF5722;
  }
  
  /* 弹窗样式 */
  .address-form-dialog {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    z-index: 1000;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .dialog-content {
    background: #fff;
    width: 500px;
    border-radius: 4px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  }
  
  .dialog-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    border-bottom: 1px solid #eee;
  }
  
  .close-btn {
    font-size: 24px;
    cursor: pointer;
    color: #999;
  }
  
  .close-btn:hover {
    color: #333;
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
    font-weight: bold;
  }
  
  .form-item input[type="text"],
  .form-item input[type="tel"] {
    width: 80%;
    padding: 8px 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
  
  .address-select .select-group {
    display: flex;
    gap: 10px;
  }
  
  .address-select select {
    flex: 1;
    padding: 8px 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
  
  .form-item.checkbox {
    display: flex;
    align-items: center;
  }
  
  .form-item.checkbox input {
    margin-right: 8px;
  }
  
  .form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
  }
  </style>
