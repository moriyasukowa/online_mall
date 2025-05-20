<template>
  <base-page :activation="activation"></base-page>

  <div class="ai-service-container">
    <div class="chat-header">
      <h2>智能AI客服助手</h2>
      <!-- Add Clear Chat Button here -->
      <button @click="confirmClearChat" class="clear-chat-button" title="清空聊天记录" v-if="messages.length > 0">
        <i class="layui-icon layui-icon-delete"></i>
      </button>
      <span class="status" :class="{ 'online': isOnline }">
        {{ isOnline ? '在线' : (geminiApiKey && geminiApiKey !== 'YOUR_GEMINI_API_KEY' ? '在线' : '配置错误') }}
      </span>
    </div>

    <div class="chat-messages" ref="messagesContainer">
      <div class="welcome-message" v-if="messages.length === 0 && !isLoadingHistory">
        <div class="avatar">
          <img src="img/ai-avatar.png" alt="AI助手">
        </div>
        <div class="message-content">
          <p>您好！我是您的智能客服助手，有什么可以帮您解决的问题吗？</p>
        </div>
      </div>

      <div v-for="(message, index) in messages" :key="index"
           :class="['message-item', message.role === 'user' ? 'user-message' : 'ai-message']">
        <div class="avatar" v-if="message.role !== 'user'">
          <img src="img/ai-avatar.png" alt="AI助手">
        </div>
        <div class="message-content">
          <div v-if="message.role === 'user'">{{ message.parts[0].text }}</div>
          <div v-else v-html="formatMessage(message.parts[0].text)"></div>
        </div>
        <div class="avatar" v-if="message.role === 'user'">
          <img src="/static/images/user-avatar.png" alt="用户">
        </div>
      </div>

      <div class="ai-message" v-if="isTyping">
         <div class="avatar">
           <img src="img/ai-avatar.png" alt="AI助手">
         </div>
         <div class="typing-indicator">
            <span></span>
            <span></span>
            <span></span>
         </div>
      </div>
    </div>

    <div class="chat-input">
      <textarea
        v-model="userInput"
        placeholder="请输入您的问题..."
        @keydown.enter.prevent="sendMessage"
        :disabled="isTyping || !isOnline"
        ref="inputField"
      ></textarea>
      <button @click="sendMessage" :disabled="!userInput.trim() || isTyping || !isOnline">
        <i class="layui-icon layui-icon-release"></i>
      </button>
    </div>
  </div>
  <footer-page></footer-page>
</template>

<script>
const GEMINI_API_KEY = 'AIzaSyDEPK1Fvp2GpQwLyW49foZnsPLZh9fcpi4'; // Replace with your actual key
const MODEL_NAME = 'gemini-1.5-flash'; // Or your chosen model
const CHAT_HISTORY_KEY = 'aiCustomerServiceChatHistory'; // Key for sessionStorage

export default {
  name: 'AiCustomerServiceDirectNonStream',
  data() {
    return {
      userInput: '',
      messages: [],
      isTyping: false,
      isOnline: false,
      controller: null,
      geminiApiKey: GEMINI_API_KEY,
      modelName: MODEL_NAME,
      apiEndpoint: '',
      activation: "aisupport",
      isLoadingHistory: true, // To prevent welcome message flash on load
      // System instruction for the AI
      systemInstruction: {
        parts: [{
          text: "你现在是一名专业的电商平台智能客服AI助手。你的任务是帮助用户解决关于商品、订单、物流、售后等常见问题。请用友好、专业且乐于助人的语气回答用户的问题。尽量提供清晰、简洁且有用的信息。如果遇到无法直接回答的问题，可以引导用户联系人工客服或提供相关帮助文档的建议。"
        }]
      }
    }
  },
  created() {
    if (!this.geminiApiKey || this.geminiApiKey === 'YOUR_GEMINI_API_KEY') {
        console.error("请在 Vue 组件脚本顶部设置您的 Gemini API Key!");
        this.isOnline = false;
    } else {
        this.apiEndpoint = `https://generativelanguage.googleapis.com/v1beta/models/${this.modelName}:generateContent?key=${this.geminiApiKey}`;
        this.isOnline = true;
    }
    this.loadMessagesFromStorage();
  },
  mounted() {
    this.scrollToBottom();
    this.focusInput(); // Focus input on mount
  },
  updated() {
    this.scrollToBottom();
  },
  methods: {
    loadMessagesFromStorage() {
      this.isLoadingHistory = true;
      try {
        const storedMessages = sessionStorage.getItem(CHAT_HISTORY_KEY);
        if (storedMessages) {
          this.messages = JSON.parse(storedMessages);
        }
      } catch (error) {
        console.error("Error loading messages from session storage:", error);
        this.messages = []; // Reset if parsing fails
      } finally {
        this.isLoadingHistory = false;
      }
    },

    saveMessagesToStorage() {
      try {
        sessionStorage.setItem(CHAT_HISTORY_KEY, JSON.stringify(this.messages));
      } catch (error) {
        console.error("Error saving messages to session storage:", error);
      }
    },

    confirmClearChat() {
      // You might want to use a more integrated confirmation dialog (e.g., from Layui or another UI library)
      if (window.confirm("您确定要清空所有聊天记录吗？此操作不可恢复。")) {
        this.clearChat();
      }
    },

    clearChat() {
      this.messages = [];
      this.saveMessagesToStorage(); // This will save an empty array
      this.userInput = ''; // Clear input field as well
      if (this.controller) { // Cancel any ongoing request
        this.controller.abort();
        this.isTyping = false;
      }
      this.focusInput();
      // Optionally, re-add the initial welcome message if you want it after clearing
      // Or just let the `v-if="messages.length === 0"` handle showing the standard welcome
    },

    async sendMessage() {
      if (!this.userInput.trim() || this.isTyping || !this.isOnline) {
        return;
      }
      const userMessageText = this.userInput.trim();
      this.messages.push({
        role: 'user',
        parts: [{ text: userMessageText }]
      });
      this.saveMessagesToStorage(); // Save after adding user message
      this.userInput = '';
      this.isTyping = true;
      this.scrollToBottom();

      // Prepare message history for API, excluding any previous system messages if they were part of `this.messages`
      // For generateContent, usually you send the whole history.
      const contentsForApi = this.messages.map(msg => ({
         role: msg.role, // Gemini uses 'user' and 'model'
         parts: msg.parts
      }));

      this.controller = new AbortController();
      const signal = this.controller.signal;

      let aiResponseText = '抱歉，未能获取回复。';

      try {
        const requestBody = {
          contents: contentsForApi,
          system_instruction: this.systemInstruction, // Add system instruction here
          // Optional generationConfig
          // generationConfig: {
          //   temperature: 0.7,
          //   maxOutputTokens: 1000,
          // }
        };
        // console.log("Sending to Gemini:", JSON.stringify(requestBody, null, 2)); // For debugging

        const response = await fetch(this.apiEndpoint, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(requestBody),
          signal: signal,
        });

        const responseData = await response.json();

        if (!response.ok) {
            console.error("Gemini API Error:", responseData);
            const errorMsg = responseData?.error?.message || JSON.stringify(responseData);
            throw new Error(`API 请求失败 (${response.status}): ${errorMsg}`);
        }

        // console.log("Gemini API Success Response:", responseData);

        aiResponseText = responseData?.candidates?.[0]?.content?.parts?.[0]?.text || '未能解析回复内容。';

        if (responseData?.candidates?.[0]?.finishReason === 'SAFETY') {
             console.warn("Response flagged for safety:", responseData.promptFeedback || responseData.candidates[0]);
             aiResponseText += `\n\n[注意：部分内容可能因安全原因被省略。 原因: ${responseData?.promptFeedback?.blockReason || '未知'}]`;
        } else if (!aiResponseText && responseData?.candidates?.[0]?.finishReason && responseData.candidates[0].finishReason !== 'STOP') {
             aiResponseText = `[模型结束了回复，但未提供文本内容 (原因: ${responseData.candidates[0].finishReason})]`;
        } else if (!aiResponseText && !responseData?.candidates?.[0]?.content?.parts?.[0]?.text) {
             aiResponseText = '[AI助手暂时没有回复，请稍后再试或尝试其他问题。]'; // More user-friendly for empty part
        }


      } catch (error) {
        if (error.name === 'AbortError') {
          console.log('Fetch request aborted.');
          aiResponseText = '[请求已取消]';
        } else {
          console.error('Error during Gemini API call:', error);
          aiResponseText = `抱歉，连接AI服务时出错: ${error.message || '未知错误'}`;
        }
      } finally {
        this.messages.push({
            role: 'model', // Gemini uses 'model' for AI responses
            parts: [{ text: aiResponseText.trim() }]
        });
        this.saveMessagesToStorage(); // Save after adding AI message

        this.isTyping = false;
        this.controller = null;
        this.scrollToBottom();
        this.focusInput(); // Re-focus input after response
      }
    },

    formatMessage(text) {
      if (!text) return '';
      let html = text;
       html = html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
       html = html.replace(/```(\w*)\n([\s\S]*?)\n```/g, (match, lang, code) => {
           const languageClass = lang ? `language-${lang}` : '';
           // Double escape for pre > code scenario
           const escapedCode = code.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
           return `<pre><code class="${languageClass}">${escapedCode}</code></pre>`;
       });
       html = html.replace(/```\n([\s\S]*?)\n```/g, (match, code) => { // For code blocks without language
           const escapedCode = code.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
           return `<pre><code>${escapedCode}</code></pre>`;
       });
      html = html.replace(/`([^`]+)`/g, '<code>$1</code>'); // Inline code
      html = html.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>'); // Bold
      html = html.replace(/(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)/g, '<em>$1</em>'); // Italics (more robust)
      html = html.replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>'); // Links
      html = html.replace(/\n/g, '<br>'); // Newlines
      return html;
    },

    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$refs.messagesContainer;
         if (container) {
           container.scrollTop = container.scrollHeight;
         }
      });
    },

    focusInput() {
      this.$nextTick(() => { // Ensure DOM is updated
        if (this.$refs.inputField) {
          this.$refs.inputField.focus();
        }
      });
    }
  },
  beforeUnmount() {
    if (this.controller) {
      this.controller.abort();
      console.log('AI request aborted on component unmount.');
    }
  }
}
</script>

<style scoped>
/* ... (your existing styles) ... */
.ai-service-container {
  display: flex;
  flex-direction: column;
  height: calc(100vh - 100px); /* Adjusted for base-page and footer-page (example) */
  min-height: 500px; /* Minimum sensible height */
  width: 100%;
  max-width: 900px;
  margin: 20px auto; /* Reduced top/bottom margin */
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  background-color: #f9f9f9;
  overflow: hidden;
}

.chat-header {
  display: flex;
  justify-content: space-between; /* Adjusted for new button */
  align-items: center;
  padding: 12px 15px; /* Slightly reduced padding */
  background-color: #1E9FFF;
  color: white;
  border-bottom: 1px solid #e0e0e0;
  flex-shrink: 0;
  position: relative; /* For absolute positioning of button if needed, but flex is better */
}

.chat-header h2 {
  margin: 0;
  font-size: 17px;
  font-weight: 600;
  flex-grow: 1; /* Allow title to take space */
  text-align: center; /* Center title if clear button is on one side and status on other */
  margin-left: 50px; /* Make space for clear button if it's on the left */
}

.chat-header .clear-chat-button {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
  font-size: 18px; /* Adjust icon size */
  padding: 5px;
  margin-right: 10px; /* Space before status or edge */
  /* position: absolute; left: 15px; (alternative positioning) */
}
.chat-header .clear-chat-button .layui-icon {
  vertical-align: middle;
}

.chat-header .clear-chat-button:hover {
  opacity: 0.8;
}


.status {
  font-size: 12px;
  padding: 4px 10px;
  border-radius: 12px;
  /* margin-left: auto; Pushes status to the right if not using space-between */
}

.status.online {
  background-color: #4CAF50;
  color: white;
}
.status:not(.online) {
  background-color: #f44336;
  color: white;
}


.chat-messages {
  flex-grow: 1;
  padding: 25px 20px;
  overflow-y: auto;
  background-color: #ffffff;
}

.welcome-message,
.message-item {
  display: flex;
  margin-bottom: 18px;
  align-items: flex-start;
}

.user-message {
  flex-direction: row-reverse;
}

.avatar {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  overflow: hidden;
  margin: 0 12px;
  flex-shrink: 0;
  box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.message-content {
  max-width: calc(100% - 110px);
  padding: 12px 18px;
  border-radius: 15px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.06);
  line-height: 1.6;
  word-wrap: break-word;
  overflow-wrap: break-word;
  white-space: pre-wrap;
}

.user-message .message-content {
  background-color: #e1f5fe;
  color: #333;
  border-bottom-right-radius: 5px;
}

.ai-message .message-content,
.welcome-message .message-content {
  background-color: #f1f1f1;
  border-bottom-left-radius: 5px;
}
.welcome-message .message-content p {
    margin: 0;
}

.message-content :deep(pre) {
  background-color: #2d2d2d;
  color: #f0f0f0;
  padding: 12px 15px;
  border-radius: 6px;
  overflow-x: auto;
  margin: 10px 0;
  box-shadow: inset 0 1px 3px rgba(0,0,0,0.3);
  white-space: pre;
}

.message-content :deep(code) {
  font-family: 'Consolas', 'Monaco', 'Courier New', Courier, monospace;
  font-size: 0.9em;
}

.message-content :deep(code:not(pre code)) {
  background-color: #e8e8e8;
  padding: 2px 5px;
  border-radius: 4px;
  color: #333;
}

.message-content :deep(pre code) {
  background-color: transparent;
  padding: 0;
  border-radius: 0;
  color: inherit;
  white-space: inherit;
}

.message-content :deep(a) {
  color: #007bff;
  text-decoration: none;
}
.message-content :deep(a:hover) {
  text-decoration: underline;
}

.ai-message .typing-indicator {
  display: inline-flex;
  align-items: center;
  padding: 10px 15px;
  background-color: #f1f1f1;
  border-radius: 15px;
  border-bottom-left-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.06);
}
.typing-indicator span {
  height: 7px;
  width: 7px;
  background-color: #999;
  border-radius: 50%;
  display: inline-block;
  margin: 0 3px;
  animation: typing 1.4s infinite both;
}
.typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
.typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

@keyframes typing {
  0%, 100% { opacity: 0.4; transform: translateY(0); }
  50% { opacity: 1; transform: translateY(-4px); }
}

.chat-input {
  display: flex;
  align-items: flex-end;
  padding: 12px 15px;
  background-color: #f9f9f9;
  border-top: 1px solid #e8e8e8;
  flex-shrink: 0;
}

.chat-input textarea {
  flex: 1;
  min-height: 42px;
  max-height: 100px;
  padding: 10px 18px;
  border: 1px solid #ddd;
  border-radius: 21px;
  resize: none;
  outline: none;
  font-family: inherit;
  font-size: 14px;
  margin-right: 10px;
  background-color: #ffffff;
  line-height: 1.5;
  transition: border-color 0.3s;
  overflow-y: auto;
}
.chat-input textarea:focus {
  border-color: #1E9FFF;
}
.chat-input textarea:disabled {
    background-color: #f5f5f5;
    cursor: not-allowed;
}

.chat-input button {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s, color 0.3s;
  flex-shrink: 0;
}
.chat-input button i {
  font-size: 20px;
}
.chat-input button:not(:disabled) {
  background-color: #1E9FFF;
  color: white;
}
.chat-input button:not(:disabled):hover {
  background-color: #0d8aee;
}
.chat-input button:disabled {
  background-color: #f0f0f0;
  color: #bbb;
  cursor: not-allowed;
}
</style>
