<template>
    <base-page :activation="activation"></base-page>
    <div class="order-detail-container w1200">
        <div class="order-header">
            <h2>订单详情</h2>
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
                    <span class="label">支付方式：</span>
                    <span class="value">在线支付</span>
                </div>
                <div class="info-item" v-if="orderInfo.pay_id">
                    <span class="label">支付单号：</span>
                    <span class="value">{{ orderInfo.pay_id }}</span>
                </div>
                <div class="info-item" v-if="orderInfo.refund_id">
                    <span class="label">退款单号：</span>
                    <span class="value">{{ orderInfo.refund_id }}</span>
                </div>
            </div>
        </div>
        
        <!-- 收货地址信息 -->
        <div class="address-section">
            <div class="section-title">
                <h3>收货信息</h3>
            </div>
            <div class="address-content" v-if="addressInfo">
                <div class="recipient-info">
                    <span class="recipient-name">{{ addressInfo.recipient_name }}</span>
                    <span class="recipient-phone">{{ formatPhone(addressInfo.phone_number) }}</span>
                </div>
                <div class="address-detail">
                    {{ addressInfo.province ? addressInfo.province.name : '' }} 
                    {{ addressInfo.city ? addressInfo.city.name : '' }} 
                    {{ addressInfo.district ? addressInfo.district.name : '' }} 
                    {{ addressInfo.detail }}
                </div>
            </div>
            <div class="empty-address" v-else>
                <p>暂无收货地址信息</p>
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
                    <div v-if="orderItems.length === 0" class="empty-items">
                        <p>暂无商品信息</p>
                    </div>
                    <div v-else>
                        <div v-for="(item, index) in orderItems" :key="index" class="order-item">
                            <div class="col-product">
                                <div class="product-info">
                                    <img :src="getImagePath(item.commodityInfos_id)" alt="商品图片">
                                    <div class="product-details">
                                        <div class="product-name">{{ item.commodityInfos_id.name }}</div>
                                        <div class="product-specs">{{ item.commodityInfos_id.sezes }}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-price">¥{{ item.unit_price.toFixed(2) }}</div>
                            <div class="col-quantity">{{ item.quantity }}</div>
                            <div class="col-subtotal">¥{{ (item.unit_price * item.quantity).toFixed(2) }}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 订单汇总 -->
        <div class="order-summary">
            <div class="summary-item">
                <span>商品件数：</span>
                <span>{{ totalQuantity }}件</span>
            </div>
            <div class="summary-item total">
                <span>订单总价：</span>
                <span class="total-price">¥{{ orderInfo.price ? orderInfo.price.toFixed(2) : '0.00' }}</span>
            </div>
        </div>
        
        <!-- 订单操作 -->
        <div class="order-actions">
            <button class="action-button back-button" @click="goBack">
                <i class="el-icon-back"></i> 返回订单列表
            </button>
            
            <div class="right-actions">
                <!-- NEW: 查看退款详情按钮 -->
                <button 
                    v-if="orderInfo.state === '退款成功' || orderInfo.state === '退款失败' || orderInfo.state === '退款中' || orderInfo.state === '退货中'"
                    class="action-button view-refund-button"
                    @click="goToRefundDetail"
                >
                    <i class="el-icon-document"></i> 查看退款详情
                </button>
                <button 
                    v-if="!isRefundRelatedStatus(orderInfo.state)"  
                    class="action-button refund-button"
                    @click="goToRefund"
                >
                    <i class="el-icon-money"></i> 申请退款
                </button>
                
                <button 
                    v-if="orderInfo.state === '已发货'" 
                    class="action-button confirm-button"
                    @click="confirmReceipt"
                >
                    <i class="el-icon-check"></i> 确认收货
                </button>
            </div>
        </div>
    </div>
    
    <footer-page></footer-page>
</template>
<script>
import { ElMessage, ElMessageBox } from 'element-plus'
export default {
    name: "OrderDetail",
    data() {
        return {
            activation: 'shopper',
            orderId: null,
            orderInfo: {},
            orderItems: [],
            addressInfo: null,
            loading: true
        }
    },
    computed: {
        totalQuantity() {
            return this.orderItems.reduce((sum, item) => sum + (item.quantity || 0), 0);
        }
    },
    created() {
        this.orderId = this.$route.params.orderId;
        if (this.orderId) {
            this.fetchOrderDetail();
        } else {
            ElMessage.error("无法加载订单详情，订单ID无效");
            this.goBack();
        }
    },
    methods: {
        async fetchOrderDetail() {
            this.loading = true;
            try {
                const response = await this.axios.get(`/api/v1/shopper/orders/${this.orderId}/`);
                console.log(response.data);
                if (response.data.state === 'success') {
                    const data = response.data.data;
                    this.orderInfo = data.order || {};
                    this.orderItems = data.items || [];
                    this.addressInfo = data.address || null;
                } else {
                    ElMessage.error(response.data.msg || '获取订单详情失败');
                }
            } catch (error) {
                if (error.response?.status === 404) {
                    ElMessage.error('订单不存在或无法访问');
                } else {
                    ElMessage.error('获取订单详情失败，请检查网络');
                }
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
        formatPhone(phone) {
            if (phone == null) return '';
            const phoneStr = String(phone);
            return /^\d{11}$/.test(phoneStr) 
                ? phoneStr.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2')
                : phoneStr;
        },
        getImagePath(commodity) {
            console.log(commodity.img);
            return commodity.img || '';
        },
        getStatusClass(status) {
            const statusMap = {
                '待支付': 'status-pending',
                '已支付': 'status-paid',
                '待揽收': 'status-processing',
                '已发货': 'status-shipped',
                '已签收': 'status-completed',
                '退货中': 'status-returning',
                '退款成功': 'status-refunded'
            };
            return statusMap[status] || 'status-unknown';
        },
        getStatusText(status) {
            return status || '未知状态';
        },
        isRefundRelatedStatus(status) {
            return ['退款中', '退货中', '退款成功', '退款失败'].includes(status);
        },
        goBack() {
            this.$router.push('/shopper/'); // Or '/shopper/orders' if that's your list page
        },
        goToRefund() {
            // Add check for status before navigating
            if (this.isRefundRelatedStatus(this.orderInfo.state)) {
                ElMessage.warning(`订单状态为 "${this.orderInfo.state}", 不能重复申请退款`);
                return;
            }
            const allowedStates = ['已支付', '待揽收', '已签收'];
             if (!allowedStates.includes(this.orderInfo.state)) {
                ElMessage.warning(`当前订单状态为"${this.orderInfo.state}"，不支持申请退款`);
                return;
            }
            this.$router.push(`/shopper/refund/${this.orderId}`);
        },
        goToRefundDetail() {
            if (this.orderId) {
                this.$router.push(`/shopper/refund/detail/${this.orderId}`); 
            } else {
                ElMessage.error("无法查看退款详情，订单ID丢失");
            }
        },
        async confirmReceipt() {
            try {
                await ElMessageBox.confirm(
                    '您确定已经收到商品了吗？确认后订单状态将变为"已签收"。',
                    '确认收货',
                    { confirmButtonText: '确认收到', cancelButtonText: '还没收到', type: 'warning' }
                );
                
                const response = await this.axios.post(`/api/v1/shopper/orders/${this.orderId}/confirm/`);
                if (response.data.state === 'success') {
                    ElMessage.success('确认收货成功！');
                    this.fetchOrderDetail();
                } else {
                    ElMessage.error(response.data.msg || '确认收货失败');
                }
            } catch (error) {
                if (error !== 'cancel') {
                    ElMessage.error('确认收货操作失败，请稍后重试');
                }
            }
        }
    }
}
</script>

<style scoped>
.order-detail-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 0 20px;
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.order-header h2 {
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
.status-pending, .status-paid, .status-shipped, 
.status-completed, .status-refunded, .status-cancelled {
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 14px;
    font-weight: 500;
}

.status-pending {
    background-color: #fdf6ec;
    color: #e6a23c;
}

.status-paid {
    background-color: #f0f9eb;
    color: #67c23a;
}

.status-shipped {
    background-color: #ecf5ff;
    color: #409eff;
}

.status-completed {
    background-color: #f4f4f5;
    color: #909399;
}

.status-refunded {
    background-color: #fef0f0;
    color: #f56c6c;
}

.status-cancelled {
    background-color: #f4f4f5;
    color: #909399;
    text-decoration: line-through;
}

/* 订单信息样式 */
.order-info-section, .address-section, .order-items-section {
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

/* 地址信息样式 */
.recipient-info {
    margin-bottom: 10px;
}

.recipient-name {
    font-weight: 500;
    margin-right: 15px;
}

.recipient-phone {
    color: #606266;
}

.address-detail {
    color: #606266;
    line-height: 1.5;
}

.empty-address, .empty-items {
    text-align: center;
    padding: 30px 0;
    color: #909399;
}

/* 订单商品表格样式 */
.order-table {
    border: 1px solid #ebeef5;
    border-radius: 4px;
    overflow: hidden;
}

.order-table-header {
    display: flex;
    background-color: #f5f7fa;
    padding: 12px 0;
    font-weight: 500;
    color: #606266;
}

.col-product {
    flex: 3;
    padding: 0 15px;
}

.col-price, .col-quantity, .col-subtotal {
    flex: 1;
    text-align: center;
}

.order-item {
    display: flex;
    padding: 15px 0;
    border-top: 1px solid #ebeef5;
    align-items: center;
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
    border: 1px solid #eee;
}

.product-details {
    flex: 1;
}

.product-name {
    font-weight: 500;
    margin-bottom: 5px;
    color: #303133;
}

.product-specs {
    color: #909399;
    font-size: 12px;
}

/* 订单汇总样式 */
.order-summary {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 20px;
    text-align: right;
}

.summary-item {
    margin-bottom: 10px;
    color: #606266;
}

.summary-item.total {
    font-size: 16px;
    font-weight: 500;
    color: #303133;
}

.total-price {
    color: #f56c6c;
    font-size: 20px;
}

/* 订单操作按钮 */
.order-actions {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
    margin-bottom: 50px;
}

.right-actions {
    display: flex;
    gap: 15px;
}

.action-button {
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    display: flex;
    align-items: center;
    transition: all 0.3s;
    border: none;
}

.action-button i {
    margin-right: 5px;
}

.back-button {
    background-color: #f4f4f5;
    color: #909399;
}

.back-button:hover {
    background-color: #e9e9eb;
}

.refund-button {
    background-color: #fef0f0;
    color: #f56c6c;
}

.refund-button:hover {
    background-color: #fde2e2;
}

.confirm-button {
    background-color: #f0f9eb;
    color: #67c23a;
}

.confirm-button:hover {
    background-color: #e1f3d8;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .order-info-content {
        grid-template-columns: 1fr;
    }
    
    .order-table-header, .order-item {
        flex-wrap: wrap;
    }
    
    .col-product {
        flex: 0 0 100%;
        margin-bottom: 10px;
    }
    
    .col-price, .col-quantity, .col-subtotal {
        flex: 1;
    }
    
    .order-actions {
        flex-direction: column;
        gap: 15px;
    }
    
    .right-actions {
        justify-content: space-between;
    }
}
</style>
