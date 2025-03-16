<template>
  <div class="ai-support">
    <base-page :activation="'AISupport'"></base-page>
    <div class="info-list-box">
      <div class="info-list">
        <div class="item-box layui-clear">
          <div class="item">
            <div class="text">
              <h2>AI 客服</h2>
              <div class="chat-window">
                <div v-for="(message, index) in messages" :key="index" :class="['message', message.sender]">
                  <span>{{ message.text }}</span>
                </div>
              </div>
              <div class="input-area">
                <input type="text" v-model="userInput" @keyup.enter="sendMessage" placeholder="请输入您的问题..."/>
                <button @click="sendMessage">发送</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      userInput: '',
      messages: [
        { text: '您好！我是AI客服，有什么可以帮您的吗？', sender: 'ai' }
      ]
    }
  },
  methods: {
    sendMessage() {
      if (this.userInput.trim() !== '') {
        this.messages.push({ text: this.userInput, sender: 'user' });
        this.getAIResponse(this.userInput);
        this.userInput = '';
      }
    },
    getAIResponse(userMessage) {
      // 模拟AI响应，可以替换为实际的AI接口调用
      setTimeout(() => {
        this.messages.push({ text: `您说的是: ${userMessage} 吗？`, sender: 'ai' });
      }, 1000);
    }
  }
}
</script>

<style scoped>
.ai-support {
  width: 100%;
}

.info-list-box {
  padding: 20px;
}

.info-list {
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 10px;
  padding: 20px;
}

.item-box {
  display: flex;
  flex-direction: column;
}

.item {
  flex: 1;
}

.text {
  margin-top: 20px;
}

.chat-window {
  height: 300px;
  border: 1px solid #ddd;
  padding: 10px;
  margin-bottom: 10px;
  background-color: #f9f9f9;
  width: 500%; /* Make chat window full width */
}

.message {
  margin: 5px 0;
  
}

.message.user {
  text-align: right;
}

.message.ai {
  text-align: left;
}

.input-area {
  display: flex;
  width: 500%;
}

input[type="text"] {
  flex: 1;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  
}

button {
  padding: 10px 20px;
  margin-left: 10px;
  border: none;
  background-color: #007bff;
  color: #fff;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>