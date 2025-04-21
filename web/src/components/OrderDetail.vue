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
                <button 
                    v-if="canRefund(orderInfo.state)" 
                    class="action-button refund-button"
                    @click="goToRefund"
                >
                    <i class="el-icon-money"></i> 申请退款
                </button>
                
                <button 
                    v-if="orderInfo.state === 'shipped'" 
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
    // components: { BasePage, FooterPage }, // 如果需要，取消注释
    data() {
        return {
            activation: 'shopper',
            orderId: null,
            orderInfo: {}, // 将从 API 的 data.order 获取
            orderItems: [], // 将从 API 的 data.items 获取
            addressInfo: null, // 将从 API 的 data.address 获取
            loading: true
        }
    },
    computed: {
        totalQuantity() {
            // 计算总件数，reduce 的第二个参数是初始值
            return this.orderItems.reduce((sum, item) => sum + (item.quantity || 0), 0);
        }
    },
    created() {
        // 从路由参数获取订单ID
        this.orderId = this.$route.params.orderId;
        if (this.orderId) {
          this.fetchOrderDetail();
        } else {
          console.error("订单ID缺失");
          ElMessage.error("无法加载订单详情，订单ID无效");
          this.goBack(); // 如果没有ID，则返回
        }
    },
    methods: {
        async fetchOrderDetail() {
            this.loading = true;
            try {
                // 使用获取到的 orderId 发起请求
                const response = await this.axios.get(`/api/v1/shopper/orders/${this.orderId}/`);

                if (response.data.state === 'success') {
                    const data = response.data.data;
                    // 直接赋值，API 结构与 data 属性匹配
                    this.orderInfo = data.order || {};
                    this.orderItems = data.items || [];
                    this.addressInfo = data.address || null;
                    // console.log("订单信息:", this.orderInfo);
                    // console.log("商品列表:", this.orderItems);
                    // console.log("地址信息:", this.addressInfo);
                } else {
                    ElMessage.error(response.data.msg || '获取订单详情失败');
                    // 考虑是否在获取失败时也返回列表页
                    // this.goBack();
                }
            } catch (error) {
                console.error('获取订单详情失败:', error);
                // 检查是否是 404 错误
                if (error.response && error.response.status === 404) {
                     ElMessage.error('订单不存在或无法访问');
                } else {
                     ElMessage.error('获取订单详情失败，请检查网络或联系管理员');
                }
                // 获取失败时也返回，避免停留在空白或错误页面
                this.goBack();
            } finally {
                this.loading = false;
            }
        },

        formatDateTime(dateTimeString) {
            if (!dateTimeString) return '';
            try {
                const date = new Date(dateTimeString);
                // 检查日期是否有效
                if (isNaN(date.getTime())) {
                    return dateTimeString; // 如果无效，返回原始字符串
                }
                // 根据需要调整格式，这里使用浏览器默认 locale
                const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' };
                return date.toLocaleDateString(undefined, options);
                // 或者只显示日期和时间
                // return `${date.toLocaleDateString()} ${date.toLocaleTimeString()}`;
            } catch (e) {
                console.error("日期格式化错误:", e);
                return dateTimeString; // 出错时返回原始字符串
            }
        },

        formatPhone(phone) {
            // null 或 undefined 检查
            if (phone == null) return '';
            const phoneStr = String(phone); // 确保是字符串
            // 使用更健壮的正则，处理不同长度，确保是数字
            if (/^\d{11}$/.test(phoneStr)) {
                return phoneStr.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2');
            }
            return phoneStr; // 如果格式不符，返回原始号码
        },

        // --- 修改点 ---
        getImagePath(commodity) {
            // commodity 是 item.commodityInfos_id 对象
            if (!commodity || !commodity.img) {
                // 可以返回一个默认占位图的路径
                // return '/path/to/default/image.png';
                return '';
            }
            // API 返回的 img 已经是 /media/... 的形式，直接使用即可
            // 浏览器会自动将其解析为相对于当前域名的路径
            // 确保 Django 服务正确配置了 MEDIA_URL 和 MEDIA_ROOT
            // 并且开发服务器或生产服务器（如 Nginx）能正确提供 /media/ 下的文件
            return commodity.img;
        },
        // --- 修改结束 ---

        getStatusClass(status) {
            // 这个映射看起来没问题
            const statusMap = {
                'pending': 'status-pending',
                'paid': 'status-paid',
                'shipped': 'status-shipped',
                'completed': 'status-completed',
                'refunded': 'status-refunded',
                'cancelled': 'status-cancelled',
                '待支付': 'status-pending', // 兼容中文状态
                '已支付': 'status-paid',
                '已发货': 'status-shipped',
                '已完成': 'status-completed',
                '已退款': 'status-refunded',
                '已取消': 'status-cancelled'
            };
            return statusMap[status] || 'status-unknown';
        },

        getStatusText(status) {
            // 这个映射也看起来没问题
            const statusTextMap = {
                'pending': '待支付',
                'paid': '已支付',
                'shipped': '已发货',
                'completed': '已完成',
                'refunded': '已退款',
                'cancelled': '已取消',
                // 如果后端只返回中文，前面的英文映射可以去掉
                '待支付': '待支付',
                '已支付': '已支付',
                '已发货': '已发货',
                '已完成': '已完成',
                '已退款': '已退款',
                '已取消': '已取消'
            };
            return statusTextMap[status] || status || '未知状态'; // 提供一个默认值
        },

        canRefund(status) {
            // 确保包含了 API 返回的所有可退款状态 ('已支付', '已发货')
            const refundableStatus = ['paid', 'shipped', '已支付', '已发货'];
            return refundableStatus.includes(status);
        },

        goBack() {
            // 确保路由路径正确，/shopper/ 可能是列表页或个人中心
            this.$router.push('/shopper/'); // 确认这是正确的返回路径
        },

        goToRefund() {
            // 跳转到退款申请页，传递订单ID
            this.$router.push(`/shopper/refund/${this.orderId}`);
        },

        async confirmReceipt() {
            try {
                await ElMessageBox.confirm(
                    '您确定已经收到商品了吗？确认后订单状态将变为“已完成”。', // 提示信息更清晰
                    '确认收货',
                    {
                        confirmButtonText: '确认收到',
                        cancelButtonText: '还没收到',
                        type: 'warning'
                    }
                ); // confirm 返回 Promise，可以直接 await

                // 用户点击了确认按钮
                const response = await this.axios.post(`/api/v1/shopper/orders/${this.orderId}/confirm/`); // 确保后端有对应接口处理 POST 请求

                if (response.data.state === 'success') {
                    ElMessage.success('确认收货成功！订单已完成。');
                    // 重新获取订单详情以更新状态
                    this.fetchOrderDetail();
                } else {
                    ElMessage.error(response.data.msg || '确认收货失败');
                }
            } catch (error) {
                // catch 分支会捕获 ElMessageBox 的取消操作（rejects with 'cancel'）
                // 和 网络请求错误
                if (error === 'cancel') {
                    // ElMessage.info('操作已取消'); // 可以选择性提示
                } else {
                    // 网络或后端处理错误
                    console.error('确认收货失败:', error);
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
