<template>
    <base-page :activation="activation"></base-page>
    <div class="shopper-container">
        <div class="profile-section">
            <div class="user-card">
                <div class="avatar-container">
                    <img src="img/portrait.png" alt="用户头像" class="user-avatar">
                </div>
                <div class="user-info">
                    <h3 class="username">{{ username }}</h3>
                    <p class="last-login">
                        <i class="el-icon-time"></i> 上次登录: {{ last_login ? formatDate(last_login) : '暂无记录' }}
                    </p>
                    
                    <div class="action-buttons">
                        <router-link to="/shopper/shopcart" class="action-button cart-button">
                            <i class="el-icon-shopping-cart-2"></i> 我的购物车
                        </router-link>
                        <router-link to="/shopper/address/add" class="action-button address-button">
                            <i class="el-icon-location-information"></i> 地址管理
                        </router-link>
                        <button @click="logout" class="action-button logout-button">
                            <i class="el-icon-switch-button"></i> 退出登录
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="orders-section">
            <h3 class="section-title">我的订单</h3>
            
            <div class="orders-table">
                <div class="table-header">
                    <div class="header-cell order-id">订单编号</div>
                    <div class="header-cell order-price">订单价格</div>
                    <div class="header-cell order-date">购买时间</div>
                    <div class="header-cell order-status">订单状态</div>
                    <div class="header-cell order-actions">操作</div>
                </div>
                
                <div class="table-body">
                    <div v-if="orders.length === 0" class="empty-orders">
                        <i class="el-icon-document-remove"></i>
                        <p>暂无订单记录</p>
                    </div>
                    
                    <div v-else>
                        <div class="table-row" v-for="(order, index) in orders" :key="index">
                            <div class="table-cell order-id">
                                <router-link :to="`/shopper/order/${order.id}`" class="order-id-link">
                                    {{ order.id }}
                                </router-link>
                            </div>
                            <div class="table-cell order-price">¥{{ order.price.toFixed(2) }}</div>
                            <div class="table-cell order-date">{{ formatDateTime(order.created) }}</div>
                            <div class="table-cell order-status">
                                <span :class="getStatusClass(order.state)">{{ getStatusText(order.state) }}</span>
                            </div>
                            <div class="table-cell order-actions">
                                <button 
                                    v-if="canRefund(order.state)" 
                                    @click="handleRefund(order.id)" 
                                    class="refund-button"
                                >
                                    申请退款
                                </button>
                                <span v-else class="no-action">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="pagination-container" v-if="totalPages > 1">
                <el-pagination
                    @current-change="handlePageChange"
                    :current-page="currentPage"
                    :page-size="pageSize"
                    layout="prev, pager, next"
                    :total="totalItems"
                    background
                >
                </el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
import { ElMessage } from 'element-plus'

export default {
    name: "Shopper",
    data() {
        return {
            activation: 'shopper',
            orders: [],
            username: this.$store.state.username,
            last_login: this.$store.state.last_login,
            currentPage: 1,
            pageSize: 10,
            totalItems: 0,
            totalPages: 1
        }
    },
    computed: {
        paginationParams() {
            return {
                page: this.currentPage,
                page_size: this.pageSize
            }
        }
    },
    mounted() {
        if (!this.$store.state.username) {
            this.$router.push({ path: '/shopper/login' })
            return
        }
        this.fetchOrders()
    },
    methods: {
        async fetchOrders() {
            try {
                const params = { ...this.paginationParams }
                const response = await this.axios.get('/api/v1/shopper/home/', { params })
                
                this.orders = response.data.data.orders || []
                this.totalItems = response.data.data.total || 0
                this.totalPages = Math.ceil(this.totalItems / this.pageSize)
                
                if (this.orders.length === 0 && this.currentPage > 1) {
                    this.currentPage = 1
                    this.fetchOrders()
                }
            } catch (error) {
                console.error('获取订单失败:', error)
                ElMessage.error('获取订单信息失败，请稍后重试')
            }
        },
        
        formatDate(dateString) {
            if (!dateString) return ''
            return new Date(dateString).toLocaleDateString()
        },
        
        formatDateTime(dateString) {
            if (!dateString) return ''
            const date = new Date(dateString)
            return `${date.toLocaleDateString()}`
        },
        
        getStatusClass(status) {
            const statusMap = {
                'pending': 'status-pending',
                'paid': 'status-paid',
                'shipped': 'status-shipped',
                'completed': 'status-completed',
                'refunded': 'status-refunded',
                'cancelled': 'status-cancelled'
            }
            return statusMap[status] || 'status-unknown'
        },
        
        getStatusText(status) {
            const statusTextMap = {
                'pending': '待支付',
                'paid': '已支付',
                'shipped': '已发货',
                'completed': '已完成',
                'refunded': '已退款',
                'cancelled': '已取消'
            }
            return statusTextMap[status] || status
        },
        
        canRefund(status) {
            return ['paid', 'shipped'].includes(status)
        },
        
        async handleRefund(orderId) {
            try {
                const confirm = await this.$confirm('确定要申请退款吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                })
                
                if (confirm === 'confirm') {
                    const response = await this.axios.post('/api/v1/shopper/refunds/', {
                        order_id: orderId
                    })
                    
                    if (response.data.state === 'success') {
                        ElMessage.success('退款申请已提交')
                        this.fetchOrders()
                    } else {
                        ElMessage.error(response.data.msg || '退款申请失败')
                    }
                }
            } catch (error) {
                if (error !== 'cancel') {
                    console.error('退款失败:', error)
                    ElMessage.error('退款申请失败，请稍后重试')
                }
            }
        },
        
        handlePageChange(page) {
            this.currentPage = page
            this.fetchOrders()
            window.scrollTo({ top: 0, behavior: 'smooth' })
        },
        
        async logout() {
            try {
                await this.axios.post('/api/v1/shopper/logout/')
                this.$store.commit('setUserName', '')
                this.$store.commit('setLastLogin', '')
                this.$router.push({ path: '/' })
                ElMessage.success('已成功退出登录')
            } catch (error) {
                console.error('退出登录失败:', error)
                ElMessage.error('退出登录失败，请稍后重试')
            }
        }
    }
}
</script>

<style scoped>
.shopper-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 0 20px;
}

.profile-section {
    margin-bottom: 30px;
}

.user-card {
    display: flex;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    padding: 25px;
    align-items: center;
}

.avatar-container {
    margin-right: 25px;
}

.user-avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #f5f5f5;
}

.user-info {
    flex: 1;
}

.username {
    font-size: 22px;
    margin: 0 0 10px;
    color: #333;
}

.last-login {
    color: #666;
    margin: 0 0 20px;
    font-size: 14px;
}

.last-login i {
    margin-right: 5px;
}

.action-buttons {
    display: flex;
    gap: 15px;
}

.action-button {
    display: flex;
    align-items: center;
    padding: 10px 15px;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.3s;
    border: none;
    text-decoration: none;
}

.action-button i {
    margin-right: 5px;
}

.cart-button {
    background-color: #f0f9eb;
    color: #67c23a;
}

.cart-button:hover {
    background-color: #e1f3d8;
}

.address-button {
    background-color: #ecf5ff;
    color: #409eff;
}

.address-button:hover {
    background-color: #d9ecff;
}

.logout-button {
    background-color: #fef0f0;
    color: #f56c6c;
}

.logout-button:hover {
    background-color: #fde2e2;
}

.orders-section {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    padding: 25px;
}

.section-title {
    font-size: 18px;
    margin: 0 0 20px;
    color: #333;
    padding-bottom: 10px;
    border-bottom: 1px solid #eee;
}

.orders-table {
    margin-bottom: 20px;
}

.table-header {
    display: flex;
    background: #f5f7fa;
    border-radius: 4px;
    padding: 12px 15px;
    font-weight: 500;
    color: #606266;
}

.header-cell {
    flex: 1;
    text-align: center;
}

.header-cell.order-id {
    flex: 1.5;
}

.table-body {
    border: 1px solid #ebeef5;
    border-top: none;
    border-radius: 0 0 4px 4px;
}

.table-row {
    display: flex;
    padding: 12px 15px;
    border-bottom: 1px solid #ebeef5;
    align-items: center;
}

.table-row:last-child {
    border-bottom: none;
}

.table-cell {
    flex: 1;
    text-align: center;
    color: #606266;
    font-size: 14px;
}

.table-cell.order-id {
    flex: 1.5;
    color: #409eff;
    font-weight: 500;
}

.table-cell.order-price {
    color: #f56c6c;
    font-weight: 500;
}

.status-pending {
    color: #e6a23c;
    background: #fdf6ec;
    padding: 3px 8px;
    border-radius: 3px;
}

.status-paid {
    color: #67c23a;
    background: #f0f9eb;
    padding: 3px 8px;
    border-radius: 3px;
}

.status-shipped {
    color: #409eff;
    background: #ecf5ff;
    padding: 3px 8px;
    border-radius: 3px;
}

.status-completed {
    color: #909399;
    background: #f4f4f5;
    padding: 3px 8px;
    border-radius: 3px;
}

.status-refunded {
    color: #f56c6c;
    background: #fef0f0;
    padding: 3px 8px;
    border-radius: 3px;
}

.status-cancelled {
    color: #909399;
    background: #f4f4f5;
    padding: 3px 8px;
    border-radius: 3px;
    text-decoration: line-through;
}

.refund-button {
    background: none;
    border: 1px solid #f56c6c;
    color: #f56c6c;
    padding: 5px 10px;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 12px;
}

.refund-button:hover {
    background: #f56c6c;
    color: #fff;
}

.no-action {
    color: #c0c4cc;
}

.empty-orders {
    text-align: center;
    padding: 50px 0;
    color: #909399;
}

.empty-orders i {
    font-size: 50px;
    margin-bottom: 15px;
    display: block;
}

.empty-orders p {
    margin: 0;
    font-size: 14px;
}

.pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 30px;
}

@media (max-width: 768px) {
    .user-card {
        flex-direction: column;
        text-align: center;
    }
    
    .avatar-container {
        margin-right: 0;
        margin-bottom: 15px;
    }
    
    .action-buttons {
        flex-direction: column;
    }
    
    .table-header, .table-row {
        flex-wrap: wrap;
    }
    
    .header-cell, .table-cell {
        flex: 0 0 50%;
        margin-bottom: 10px;
        text-align: left;
    }
    
    .header-cell.order-id, .table-cell.order-id {
        flex: 0 0 100%;
    }
}

.order-id-link {
    color: #409eff;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s;
}

.order-id-link:hover {
    color: #66b1ff;
    text-decoration: underline;
}

</style>

