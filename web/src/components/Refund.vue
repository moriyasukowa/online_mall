<!-- filepath: c:\Users\zhang\Desktop\project\web\src\components\Refund.vue -->

<template>
    <div class="refund-page">
      <h2>退款申请</h2>
      <form @submit.prevent="submitRefund">
        <div>
          <label for="order-id">订单编号:</label>
          <input type="text" id="order-id" v-model="orderId" required />
        </div>
        <div>
          <label for="reason">退款原因:</label>
          <textarea id="reason" v-model="reason" required></textarea>
        </div>
        <button type="submit">提交申请</button>
      </form>
    </div>
  </template>
  
  <script>
export default {
    name: "Refund",
    data() {
      return {
        orderId: "",
        reason: ""
      };
    },
    methods: {
    async submitRefund() {
      try {
        const response = await this.axios.get('/api/v1/shopper/gets/', {
          params: { order_id: this.orderId }
        });
        if (response.data.state === 'fail') {
          alert('订单号不存在');
          return;
        }

        const order = response.data.data;
        alert(order.state);
        if (order.state === '已支付') {
          await this.processRefund(order.id, order.price);
        } else if (order.state === '已发货') {
          await this.updateOrderStatus(order.order_id, '正在退款');
          alert('订单状态已变更为正在退款, 请等待商家同意');
        }
      } catch (error) {
        console.error(error);
        alert('退款申请提交失败');
      }
    },
    async processRefund(order_id, price) {
      var d = {'order_id': (order_id), 'price': price, 'reason': this.reason}
      console.log('Sending refund request with data:', d); // 添加调试信息
      this.axios.post('/api/v1/shopper/refund/', d).then(response => {
          if (response.data.data !== ''){
              console.log(response.data.data) 
              window.location.href = response.data.data
          }
      })
      .catch(function (error) {
          console.log(error)
          alert('退款申请提交失败');
      })
    },
    async updateOrderStatus(orderId, state) {
      try {
        await this.axios.post('/api/v1/shopper/updateOrderStatus/', {
          order_id: orderId,
          state: state
        });
      } catch (error) {
        console.error(error);
        alert('订单状态更新失败');
      }
    }
  }
};
</script>
  <style scoped>
  .refund-page {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }
  
  .refund-page h2 {
    text-align: center;
  }
  
  .refund-page form div {
    margin-bottom: 15px;
  }
  
  .refund-page label {
    display: block;
    margin-bottom: 5px;
  }
  
  .refund-page input,
  .refund-page textarea {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
  }
  
  .refund-page button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
  
  .refund-page button:hover {
    background-color: #0056b3;
  }
  </style>

