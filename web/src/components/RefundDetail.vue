<template>
    <base-page :activation="activation"></base-page>
    <div class="refund-detail-container w1200">
      <div class="refund-header">
        <h2>退款详情</h2>
        <div class="refund-status-tag" v-if="refundInfo.state">
          <span :class="getRefundStatusClass(refundInfo.state)">{{ getRefundStatusText(refundInfo.state) }}</span>
        </div>
      </div>
  
      <!-- 状态提示信息 -->
      <div class="status-hint-section">
        <el-alert
          v-if="refundInfo.state === '退款申请中'"
          title="您的退款申请正在等待商家审核，请耐心等待。"
          type="warning"
          :closable="false"
          show-icon>
          <template #icon><i class="el-icon-loading"></i></template>
        </el-alert>
        <el-alert
          v-else-if="refundInfo.state === '申请成功'"
          title="您的退款申请已通过，请及时填写退货物流信息。"
          type="success"
          :closable="false"
          show-icon>
           <template #icon><i class="el-icon-circle-check"></i></template>
        </el-alert>
         <el-alert
          v-else-if="refundInfo.state === '退货中'"
          title="商家正在等待接收您退回的商品，请确保物流信息准确。"
          type="info"
          :closable="false"
          show-icon>
           <template #icon><i class="el-icon-truck"></i></template>
        </el-alert>
         <el-alert
          v-else-if="refundInfo.state === '退款成功'"
          title="退款已成功处理，款项将原路退回，请注意查收。"
          type="success"
          :closable="false"
          show-icon>
           <template #icon><i class="el-icon-circle-check"></i></template>
        </el-alert>
         <el-alert
          v-else-if="refundInfo.state === '退款失败'"
          title="抱歉，您的退款申请未通过，请联系客服了解详情。"
          type="error"
          :closable="false"
          show-icon>
           <template #icon><i class="el-icon-circle-close"></i></template>
        </el-alert>
      </div>
  
  
      <!-- 退款详细信息 -->
      <div class="refund-info-section">
        <div class="section-title">
          <h3>退款信息</h3>
        </div>
        <div class="refund-info-content">
          <div class="info-item">
            <span class="label">退款单号：</span>
            <span class="value">{{ refundInfo.refund_id || 'N/A' }}</span>
          </div>
          <div class="info-item">
            <span class="label">申请时间：</span>
            <span class="value">{{ formatDateTime(refundInfo.created) }}</span>
          </div>
          <div class="info-item">
            <span class="label">退款金额：</span>
            <span class="value price">¥{{ refundInfo.price ? refundInfo.price.toFixed(2) : '0.00' }}</span>
          </div>
           <div class="info-item">
            <span class="label">退款状态：</span>
            <span class="value" :class="getRefundStatusClass(refundInfo.state)">{{ getRefundStatusText(refundInfo.state) }}</span>
          </div>
          <div class="info-item info-item-full">
            <span class="label">退款原因：</span>
            <span class="value">{{ refundInfo.reason || '无' }}</span>
          </div>
          <div class="info-item" v-if="refundInfo.attach">
            <span class="label">退款凭证：</span>
            <span class="value">
               <a :href="refundInfo.attach" target="_blank" class="link">查看凭证</a>
            </span>
          </div>
          <!-- Add more fields if available from API, e.g., handler, handling time -->
           <div class="info-item" v-if="refundInfo.shipping_id && refundInfo.shipping_number">
            <span class="label">退货快递：</span>
            <span class="value">{{ refundInfo.shipping_id }} - {{ refundInfo.shipping_number }}</span>
          </div>
        </div>
      </div>
  
      <!-- 关联订单信息 -->
      <div class="order-info-section">
        <div class="section-title">
          <h3>关联订单信息</h3>
        </div>
        <div class="order-info-content">
          <div class="info-item">
            <span class="label">订单编号：</span>
            <span class="value">
                <router-link :to="`/shopper/order/${orderInfo.id}`" class="link">{{ orderInfo.id }}</router-link>
            </span>
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
  
       <!-- 操作区域 -->
      <div class="actions-section">
         <el-button @click="goBackToOrder">
           <i class="el-icon-back"></i> 返回订单详情
         </el-button>
          <el-button
            v-if="refundInfo.state === '申请成功'"
            type="primary"
            @click="openShippingDialog"
            :loading="shippingSubmitting"
          >
            <i class="el-icon-edit"></i> 填写退货物流信息
          </el-button>
      </div>
  
      <!-- 填写物流信息对话框 -->
      <el-dialog title="填写退货物流信息" v-model="shippingDialogVisible" width="400px">
         <el-form :model="shippingForm" ref="shippingFormRef" :rules="shippingRules" label-width="100px">
           <el-form-item label="快递公司" prop="shipping_id">
             <el-input v-model="shippingForm.shipping_id" placeholder="请输入快递公司名称"></el-input>
           </el-form-item>
           <el-form-item label="快递单号" prop="shipping_number">
             <el-input v-model="shippingForm.shipping_number" placeholder="请输入快递单号"></el-input>
           </el-form-item>
         </el-form>
         <template #footer>
           <span class="dialog-footer">
             <el-button @click="shippingDialogVisible = false">取消</el-button>
             <el-button type="primary" @click="submitShippingInfo" :loading="shippingSubmitting">确认提交</el-button>
           </span>
         </template>
      </el-dialog>
  
    </div>
    <footer-page></footer-page>
  </template>
  
  <script>
  import { ElMessage, ElMessageBox, ElAlert, ElDialog, ElForm, ElFormItem, ElInput } from 'element-plus'
  
  export default {
    name: "RefundDetail",
     components: {
      ElAlert,
      ElDialog,
      ElForm,
      ElFormItem,
      ElInput
    },
    data() {
      return {
        activation: 'shopper',
        orderId: null, // Or maybe refundId if your route uses that
        orderInfo: {}, // Basic info about the related order
        refundInfo: {}, // Detailed refund info
        loading: true,
        shippingDialogVisible: false,
        shippingSubmitting: false,
        shippingForm: {
            shipping_id: '',
            shipping_number: ''
        },
        shippingRules: {
            shipping_id: [ { required: true, message: '请输入快递公司名称', trigger: 'blur'} ],
            shipping_number: [ { required: true, message: '请输入快递单号', trigger: 'blur'} ]
        }
      }
    },
    created() {
      // Assuming the route param is still orderId, used to fetch refund
      this.orderId = this.$route.params.orderId;
      if (this.orderId) {
        this.fetchRefundDetail();
        // Optionally fetch basic order details too if needed and not included in refund API
        this.fetchOrderDetailLite();
      } else {
        ElMessage.error("无法加载退款详情，ID无效");
        this.$router.push('/shopper/'); // Navigate back to a safe page
      }
    },
    methods: {
      async fetchRefundDetail() {
        this.loading = true;
        try {
          // Adjust API endpoint if needed. Assumes fetching refund by orderId
          const response = await this.axios.get(`/api/v1/shopper/refunds/${this.orderId}/`);
          if (response.data.state === 'success' && response.data.data) {
            this.refundInfo = response.data.data;
            // If order info is nested in refund data, use it directly
            if (response.data.data.order) {
               this.orderInfo = response.data.data.order;
            }
          } else {
            ElMessage.error(response.data.msg || '获取退款详情失败');
            // Maybe navigate back if refund not found?
            // this.goBackToOrder();
          }
        } catch (error) {
           if (error.response?.status === 404) {
              ElMessage.error('未找到对应的退款记录');
           } else {
              ElMessage.error('获取退款详情失败，请检查网络');
           }
          // Consider navigating back if fetch fails critically
          // this.goBackToOrder();
        } finally {
          this.loading = false;
        }
      },
  
      // Optional: Fetch minimal order details if not included in refund API
      async fetchOrderDetailLite() {
          // Only fetch if orderInfo wasn't populated by fetchRefundDetail
          if (this.orderInfo && this.orderInfo.id) return;
          if (!this.orderId) return;
  
         try {
           const response = await this.axios.get(`/api/v1/shopper/orders/${this.orderId}/`);
           if (response.data.state === 'success' && response.data.data.order) {
             // Only take necessary fields to avoid overwriting refund context
             const orderData = response.data.data.order;
             this.orderInfo = {
                  id: orderData.id,
                  created: orderData.created,
                  price: orderData.price,
                  // Add other minimal fields if needed
             };
           } // Don't show error here if it fails, refund detail is primary
         } catch (error) {
           console.error("Could not fetch minimal order details:", error);
         }
  
      },
  
      formatDateTime(dateTimeString) {
        if (!dateTimeString) return 'N/A';
        try {
          const date = new Date(dateTimeString);
          if (isNaN(date.getTime())) return dateTimeString;
          return date.toLocaleString();
        } catch {
          return dateTimeString;
        }
      },
  
       getRefundStatusClass(status) {
        const statusMap = {
          '退款申请中': 'refund-status-pending',
          '申请成功': 'refund-status-approved',
          '退款失败': 'refund-status-failed',
          '退货中': 'refund-status-returning',
          '退款成功': 'refund-status-success'
          // '已关闭': 'refund-status-closed' // Example
        };
        return statusMap[status] || 'refund-status-unknown';
      },
  
      getRefundStatusText(status) {
        // You might want more user-friendly text here
        return status || '未知状态';
      },
  
      openShippingDialog() {
          this.shippingForm.shipping_id = '';
          this.shippingForm.shipping_number = '';
          this.shippingDialogVisible = true;
          // Reset validation if the dialog was opened before
          this.$nextTick(() => {
               if (this.$refs.shippingFormRef) {
                  this.$refs.shippingFormRef.clearValidate();
               }
          });
      },
  
      async submitShippingInfo() {
          try {
              // Validate the form first
              await this.$refs.shippingFormRef.validate();
          } catch (error) {
              // Validation failed, do nothing
              return;
          }
  
          this.shippingSubmitting = true;
          try {
              // *** API CALL SIMULATION ***
              // Replace this with your actual API call
              console.log("Simulating API call to submit shipping info:", this.shippingForm);
               const response = await this.axios.post(`/api/v1/shopper/refunds/${this.orderId}/shipping/`, {
                   shipping_id: this.shippingForm.shipping_id,
                   shipping_number: this.shippingForm.shipping_number
               });
  
               if (response.data.state === 'success') {
                  ElMessage.success('退货物流信息提交成功！');
                  this.shippingDialogVisible = false;
                  // IMPORTANT: Refresh refund details to show the new status ('退货中')
                  await this.fetchRefundDetail();
               } else {
                   ElMessage.error(response.data.msg || '提交物流信息失败');
               }
  
              // --- End of API Call Simulation ---
  
          } catch (error) {
              console.error("Error submitting shipping info:", error);
              ElMessage.error('提交物流信息时发生错误，请稍后重试');
          } finally {
              this.shippingSubmitting = false;
          }
      },
  
      goBackToOrder() {
        if (this.orderInfo && this.orderInfo.id) {
          this.$router.push(`/shopper/order/${this.orderInfo.id}`);
        } else {
          // Fallback if orderId is missing for some reason
          this.$router.push('/shopper/');
        }
      }
    }
  }
  </script>
  
  <style scoped>
  .refund-detail-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 0 20px 50px; /* Add bottom padding */
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
  
  /* Refund Status Tag in Header */
  .refund-status-tag span {
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 14px;
    font-weight: 500;
    display: inline-block; /* Needed for padding */
  }
  
  /* Status Hint Section */
  .status-hint-section {
      margin-bottom: 20px;
  }
  .status-hint-section .el-alert {
      border-radius: 8px; /* Match card radius */
  }
  /* Custom Icons for Alert */
  .status-hint-section .el-alert__icon {
      font-size: 18px; /* Adjust icon size */
      width: auto; /* Let icon determine width */
  }
  .status-hint-section .el-icon-loading {
      color: #E6A23C; /* Warning color */
  }
  .status-hint-section .el-icon-circle-check {
      color: #67C23A; /* Success color */
  }
  .status-hint-section .el-icon-truck {
      color: #409EFF; /* Info color */
  }
  .status-hint-section .el-icon-circle-close {
       color: #F56C6C; /* Error color */
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
  
  /* Specific Section Styles */
  .refund-info-section, .order-info-section {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 20px;
  }
  
  /* Content Grid Layout */
  .refund-info-content, .order-info-content {
    display: grid;
    /* Adjust columns for potentially more fields in refund details */
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 15px;
  }
  
  .info-item {
    display: flex;
    align-items: baseline; /* Align text nicely */
     padding: 5px 0; /* Add some vertical spacing */
  }
  
  /* Style for items that should take full width like 'reason' */
  .info-item-full {
      grid-column: 1 / -1; /* Span across all grid columns */
  }
  
  .info-item .label {
    width: 100px; /* Fixed width for labels */
    color: #909399;
    font-weight: 500;
    flex-shrink: 0; /* Prevent label from shrinking */
    padding-right: 10px;
  }
  
  .info-item .value {
    flex: 1;
    color: #606266;
    word-break: break-word; /* Prevent long values from overflowing */
  }
  
  .info-item .value.price {
    color: #f56c6c;
    font-weight: bold;
  }
  
  .info-item .value .link {
    color: #409EFF;
    text-decoration: none;
    cursor: pointer;
  }
  .info-item .value .link:hover {
    text-decoration: underline;
  }
  
  /* Refund Status Text Styles (within info items and header tag) */
  .refund-status-pending { background-color: #fdf6ec; color: #e6a23c; }
  .refund-status-approved { background-color: #f0f9eb; color: #67c23a; }
  .refund-status-failed { background-color: #fef0f0; color: #f56c6c; }
  .refund-status-returning { background-color: #ecf5ff; color: #409eff; }
  .refund-status-success { background-color: #f0f9eb; color: #67c23a; }
  .refund-status-unknown { background-color: #f4f4f5; color: #909399; }
  /* Apply padding only when used as a tag, not inline text */
  .refund-status-tag .refund-status-pending,
  .refund-status-tag .refund-status-approved,
  .refund-status-tag .refund-status-failed,
  .refund-status-tag .refund-status-returning,
  .refund-status-tag .refund-status-success,
  .refund-status-tag .refund-status-unknown {
     padding: 6px 12px;
     border-radius: 4px;
  }
  
  .info-item .value.refund-status-pending { color: #e6a23c; }
  .info-item .value.refund-status-approved { color: #67c23a; }
  .info-item .value.refund-status-failed { color: #f56c6c; }
  .info-item .value.refund-status-returning { color: #409eff; }
  .info-item .value.refund-status-success { color: #67c23a; }
  .info-item .value.refund-status-unknown { color: #909399; }
  
  
  /* Actions Section */
  .actions-section {
      margin-top: 30px;
      text-align: center; /* Center buttons */
      display: flex;
      justify-content: center;
      gap: 15px; /* Space between buttons */
  }
  
  .actions-section .el-button {
    padding: 10px 20px;
  }
  
  .actions-section .el-button i {
    margin-right: 5px;
  }
  
  /* Dialog Style */
  .dialog-footer {
      text-align: right;
  }
  
  
  /* Responsive Design */
  @media (max-width: 768px) {
     .refund-info-content, .order-info-content {
      grid-template-columns: 1fr; /* Stack items on smaller screens */
    }
    .info-item-full {
        grid-column: auto; /* Reset spanning on small screens */
    }
     .refund-header {
         flex-direction: column;
         align-items: flex-start;
         gap: 10px;
     }
     .actions-section {
          flex-direction: column;
          align-items: center;
     }
     .actions-section .el-button {
         width: 80%; /* Make buttons wider on mobile */
         max-width: 300px;
     }
  }
  </style>
  