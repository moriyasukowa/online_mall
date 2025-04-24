<template>
  <base-page :activation="activation"></base-page>
  <div class="refund-container w1200">
    <div class="refund-header">
      <h2>申请退款</h2>
      <div class="order-status">
        <span :class="getStatusClass(orderInfo.state)">{{ getStatusText(orderInfo.state) }}</span>
      </div>
    </div>

    <!-- 订单基本信息 -->
    <div class="order-info-section">
      <div class="section-title">
        <h3>订单信息</h3>
      </div>
      <div class="order-info-content">
        <div class="info-item">
          <span class="label">订单编号：</span>
          <span class="value">{{ orderInfo.id }}</span>
        </div>
        <div class="info-item">
          <span class="label">下单时间：</span>
          <span class="value">{{ formatDateTime(orderInfo.created) }}</span>
        </div>
        <div class="info-item">
          <span class="label">订单金额：</span>
          <span class="value price">¥{{ orderInfo.price ? orderInfo.price.toFixed(2) : '0.00' }}</span>
        </div>
      </div>
    </div>

    <!-- 退款信息表单 -->
    <div class="refund-form-section">
      <div class="section-title">
        <h3>退款申请</h3>
      </div>
      <el-form ref="refundForm" :model="refundForm" :rules="rules" label-width="100px">
        <el-form-item label="退款金额" prop="price">
          <el-input-number 
            v-model="refundForm.price" 
            :min="0" 
            :max="orderInfo.price || 0" 
            :precision="2"
            controls-position="right"
          ></el-input-number>
          <span class="price-hint">最大可退金额: ¥{{ orderInfo.price ? orderInfo.price.toFixed(2) : '0.00' }}</span>
        </el-form-item>
        
        <el-form-item label="退款原因" prop="reason">
          <el-input 
            v-model="refundForm.reason" 
            type="textarea" 
            :rows="4" 
            placeholder="请详细描述退款原因"
            resize="none"
          ></el-input>
        </el-form-item>
        
        <el-form-item label="退款凭证" prop="attach">
          <el-upload
            class="upload-demo"
            action="#"
            :http-request="uploadFile"
            :limit="1"
            :file-list="fileList"
            :before-upload="beforeUpload"
          >
            <el-button type="primary" icon="el-icon-upload">上传凭证</el-button>
            <template #tip>
              <div class="el-upload__tip">
                支持上传JPG/PNG/PDF文件，大小不超过5MB
              </div>
            </template>
          </el-upload>
        </el-form-item>
        
        <el-form-item class="form-actions">
          <el-button type="primary" @click="submitRefund" :loading="submitting">
            <i class="el-icon-check"></i> 提交申请
          </el-button>
          <el-button @click="goBack">
            <i class="el-icon-back"></i> 返回
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
  <footer-page></footer-page>
</template>

<script>
import { ElMessage, ElMessageBox } from 'element-plus'

export default {
  name: "RefundApplication",
  data() {
    return {
      activation: 'shopper',
      orderId: null,
      orderInfo: {},
      refundForm: {
        price: 0,
        reason: '',
        attach: null
      },
      fileList: [],
      submitting: false,
      loading: true,
      rules: {
        price: [
          { required: true, message: '请输入退款金额', trigger: 'blur' },
          { type: 'number', message: '金额必须为数字', trigger: 'blur' }
        ],
        reason: [
          { required: true, message: '请输入退款原因', trigger: 'blur' },
          { min: 5, message: '退款原因至少5个字符', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.orderId = this.$route.params.orderId;
    if (this.orderId) {
      this.fetchOrderDetail();
    } else {
      ElMessage.error("无法加载订单信息，订单ID无效");
      this.goBack();
    }
  },
  methods: {
    async fetchOrderDetail() {
      this.loading = true;
      try {
        const response = await this.axios.get(`/api/v1/shopper/orders/${this.orderId}/`);
        if (response.data.state === 'success') {
          this.orderInfo = response.data.data.order || {};
          
          // 初始化退款金额为订单总价
          if (this.orderInfo.price) {
            this.refundForm.price = this.orderInfo.price;
          }
          
          // 检查订单状态是否允许退款
          const allowedStates = ['已支付', '待揽收', '已签收'];
          if (!allowedStates.includes(this.orderInfo.state)) {
            ElMessage.warning(`当前订单状态为"${this.orderInfo.state}"，不支持申请退款`);
          }
        } else {
          ElMessage.error(response.data.msg || '获取订单详情失败');
          this.goBack();
        }
      } catch (error) {
        ElMessage.error('获取订单详情失败，请检查网络');
        this.goBack();
      } finally {
        this.loading = false;
      }
    },
    
    formatDateTime(dateTimeString) {
      if (!dateTimeString) return '';
      try {
        const date = new Date(dateTimeString);
        if (isNaN(date.getTime())) return dateTimeString;
        return date.toLocaleString();
      } catch {
        return dateTimeString;
      }
    },
    
    getStatusClass(status) {
      const statusMap = {
        '待支付': 'status-pending',
        '已支付': 'status-paid',
        '待揽收': 'status-processing',
        '已发货': 'status-shipped',
        '已签收': 'status-completed',
        '退款中': 'status-returning',
        '退款成功': 'status-refunded'
      };
      return statusMap[status] || 'status-unknown';
    },
    
    getStatusText(status) {
      return status || '未知状态';
    },
    
    beforeUpload(file) {
      const isLt5M = file.size / 1024 / 1024 < 5;
      const isImage = ['image/jpeg', 'image/png'].includes(file.type);
      const isPDF = file.type === 'application/pdf';
      
      if (!isLt5M) {
        ElMessage.error('上传文件大小不能超过5MB');
        return false;
      }
      if (!isImage && !isPDF) {
        ElMessage.error('只能上传JPG/PNG/PDF格式文件');
        return false;
      }
      return true;
    },
    
    uploadFile(options) {
      this.refundForm.attach = options.file;
      this.fileList = [{
        name: options.file.name,
        size: options.file.size
      }];
      options.onSuccess();
    },
    
    async submitRefund() {
      try {
        await this.$refs.refundForm.validate();
      } catch (error) {
        return;
      }
      
      try {
        await ElMessageBox.confirm(
          `您确定要申请退款 ¥${this.refundForm.price.toFixed(2)} 吗？`,
          '确认申请退款',
          {
            confirmButtonText: '确认申请',
            cancelButtonText: '取消',
            type: 'warning'
          }
        );
        
        this.submitting = true;
        
        const formData = new FormData();
        formData.append('order_id', this.orderId);
        formData.append('price', this.refundForm.price);
        formData.append('reason', this.refundForm.reason);
        
        if (this.refundForm.attach) {
          formData.append('attach', this.refundForm.attach);
        }
        
        const response = await this.axios.post('/api/v1/shopper/refunds/apply/', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });
        
        if (response.data.state === 'success') {
          ElMessage.success('退款申请提交成功');
          
          if (response.data.code === 1) {
            ElMessage({
              type: 'success',
              message: '您的退款申请已通过，请等待退款到账',
              duration: 5000
            });
          } else if (response.data.code === 2) {
            ElMessage({
              type: 'success',
              message: '您的退款申请已提交，请等待商家审核',
              duration: 5000
            });
          }
          
          this.goBack();
        } else {
          ElMessage.error(response.data.msg || '退款申请提交失败');
        }
      } catch (error) {
        if (error !== 'cancel') {
          console.error('退款申请失败:', error);
          ElMessage.error('退款申请提交失败，请稍后重试');
        }
      } finally {
        this.submitting = false;
      }
    },
    
    goBack() {
      this.$router.push(`/shopper/order/${this.orderId}`);
    }
  }
}
</script>

<style scoped>
.refund-container {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

.refund-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}

.refund-header h2 {
  font-size: 22px;
  color: #333;
  margin: 0;
}

.section-title {
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

.section-title h3 {
  font-size: 18px;
  color: #333;
  margin: 0;
}

/* 订单状态样式 */
.status-pending {
  background-color: #fdf6ec;
  color: #e6a23c;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-paid {
  background-color: #f0f9eb;
  color: #67c23a;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-processing {
  background-color: #ecf5ff;
  color: #409eff;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-shipped {
  background-color: #ecf5ff;
  color: #409eff;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-completed {
  background-color: #f4f4f5;
  color: #909399;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-returning {
  background-color: #fdf6ec;
  color: #e6a23c;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-refunded {
  background-color: #f0f9eb;
  color: #67c23a;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-unknown {
  background-color: #f4f4f5;
  color: #909399;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

/* 订单信息样式 */
.order-info-section, .refund-form-section {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 20px;
  margin-bottom: 20px;
}

.order-info-content {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}

.info-item {
  display: flex;
}

.info-item .label {
  width: 100px;
  color: #909399;
}

.info-item .value {
  flex: 1;
  color: #606266;
}

.info-item .value.price {
  color: #f56c6c;
  font-weight: bold;
}

/* 表单样式 */
.el-form {
  max-width: 800px;
  margin: 0 auto;
}

.price-hint {
  margin-left: 10px;
  color: #909399;
  font-size: 14px;
}

.el-input-number {
  width: 200px;
}

.el-textarea {
  max-width: 600px;
}

.upload-demo {
  max-width: 600px;
}

.el-upload__tip {
  color: #909399;
  font-size: 12px;
  margin-top: 5px;
}

/* 表单操作按钮 */
.form-actions {
  margin-top: 30px;
  text-align: center;
}

.el-button {
  padding: 10px 20px;
}

.el-button i {
  margin-right: 5px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .order-info-content {
    grid-template-columns: 1fr;
  }
  
  .el-form {
    padding: 0 10px;
  }
  
  .el-input-number {
    width: 100%;
  }
  
  .el-textarea {
    max-width: 100%;
  }
  
  .upload-demo {
    max-width: 100%;
  }
}
</style>
