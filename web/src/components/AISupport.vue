<template>
  <base-page :activation="activation"></base-page> <!-- Ensure activation is defined -->

  <div class="ai-service-container">
    <div class="chat-header">
      <h2>智能AI客服助手</h2>
      <span class="status" :class="{ 'online': isOnline }">
        {{ isOnline ? '在线' : (geminiApiKey && geminiApiKey !== 'YOUR_GEMINI_API_KEY' ? '在线' : '配置错误') }}
      </span>
    </div>

    <div class="chat-messages" ref="messagesContainer">
      <div class="welcome-message" v-if="messages.length === 0">
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

      <!-- Display loading indicator (typing) instead of streaming -->
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
// Consider using a Markdown library like 'marked' for more robust formatting
// import { marked } from 'marked';

const GEMINI_API_KEY = 'AIzaSyDEPK1Fvp2GpQwLyW49foZnsPLZh9fcpi4'; // Replace with your actual key
const MODEL_NAME = 'gemini-1.5-flash'; // Or your chosen model

export default {
  name: 'AiCustomerServiceDirectNonStream',
  data() {
    return {
      userInput: '',
      messages: [], // Stores { role: 'user' | 'model', parts: [{ text: '...' }] }
      isTyping: false, // Indicates waiting for response
      isOnline: false, // Determined by API key presence
      controller: null,
      geminiApiKey: GEMINI_API_KEY,
      modelName: MODEL_NAME,
      apiEndpoint: '', // Will be constructed for non-streaming
      // --- Add activation property to satisfy template ---
      activation: "aisupport" // Or an appropriate default value (e.g., 0, '')
    }
  },
  created() {
    // --- Use the NON-STREAMING endpoint ---
    if (!this.geminiApiKey || this.geminiApiKey === 'YOUR_GEMINI_API_KEY') {
        console.error("请在 Vue 组件脚本顶部设置您的 Gemini API Key!");
        this.isOnline = false;
    } else {
        this.apiEndpoint = `https://generativelanguage.googleapis.com/v1beta/models/${this.modelName}:generateContent?key=${this.geminiApiKey}`;
        this.isOnline = true;
    }

  },
  mounted() {
    this.scrollToBottom();
  },
  updated() {
    this.scrollToBottom();
  },
  methods: {
    async sendMessage() {
      if (!this.userInput.trim() || this.isTyping || !this.isOnline) {
        return;
      }
      const userMessageText = this.userInput.trim();
      // Add user message
      this.messages.push({
        role: 'user',
        parts: [{ text: userMessageText }]
      });
      this.userInput = ''; // Clear input
      this.isTyping = true; // Show typing indicator
      this.scrollToBottom(); // Scroll to show indicator

      // Prepare message history for API
      // Gemini non-streaming often just needs history excluding the last AI response placeholder
       const contents = this.messages.map(msg => ({
         role: msg.role,
         parts: msg.parts
       }));

      this.controller = new AbortController();
      const signal = this.controller.signal;

      let aiResponseText = '抱歉，未能获取回复。'; // Default error/fallback

      try {
        const response = await fetch(this.apiEndpoint, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          config: {
            systemInstruction: "请扮演一个客服助手，回答用户的问题。",
          },

          body: JSON.stringify({
            contents: contents,
            // Optional generationConfig
            // generationConfig: {
            //   temperature: 0.7,
            //   maxOutputTokens: 1000,
            // }
          }),
          signal: signal,
        });

        // --- Handle Full Response (Not Streaming) ---
        const responseData = await response.json(); // Parse the entire JSON response

        if (!response.ok) {
            // Log the detailed error from Gemini
            console.error("Gemini API Error:", responseData);
            // Extract message if possible, otherwise stringify the error
            const errorMsg = responseData?.error?.message || JSON.stringify(responseData);
            throw new Error(`API 请求失败 (${response.status}): ${errorMsg}`);
        }

         // Log successful response structure for debugging (optional)
         console.log("Gemini API Success Response:", responseData);

        // Extract the text content from the successful response
        // Make sure the path is correct based on Gemini's response structure
        // Using optional chaining for safety
        aiResponseText = responseData?.candidates?.[0]?.content?.parts?.[0]?.text || '未能解析回复内容。';

        // Check for safety blocks even in successful responses
        if (responseData?.candidates?.[0]?.finishReason === 'SAFETY') {
             console.warn("Response flagged for safety:", responseData.promptFeedback || responseData.candidates[0]);
             aiResponseText += `\n\n[注意：部分内容可能因安全原因被省略。 原因: ${responseData?.promptFeedback?.blockReason || '未知'}]`;
         } else if (!aiResponseText && responseData?.candidates?.[0]?.finishReason) {
             // Handle cases where the model finishes but provides no text (e.g., finishReason: "STOP")
             aiResponseText = `[模型结束了回复，但未提供文本内容 (原因: ${responseData.candidates[0].finishReason})]`;
         }


      } catch (error) {
        if (error.name === 'AbortError') {
          console.log('Fetch request aborted.');
          aiResponseText = '[请求已取消]';
        } else {
          console.error('Error during Gemini API call:', error);
          // Display the error message directly in the chat
          aiResponseText = `抱歉，连接AI服务时出错: ${error.message || '未知错误'}`;
        }
      } finally {
        // --- Add the complete AI response (or error) as a message ---
        this.messages.push({
            role: 'model',
            parts: [{ text: aiResponseText.trim() }]
        });

        this.isTyping = false; // Hide typing indicator
        this.controller = null;
        this.scrollToBottom(); // Scroll to the new AI message
      }
    }, // End sendMessage

    formatMessage(text) {
      // Keep the same robust Markdown formatting function
      if (!text) return '';
      let html = text;
       html = html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
       html = html.replace(/```(\w*)\n([\s\S]*?)\n```/g, (match, lang, code) => {
           const languageClass = lang ? `language-${lang}` : '';
           const escapedCode = code.replace(/</g, "&lt;").replace(/>/g, "&gt;");
           return `<pre><code class="${languageClass}">${escapedCode}</code></pre>`;
       });
       html = html.replace(/```\n([\s\S]*?)\n```/g, (match, code) => {
           const escapedCode = code.replace(/</g, "&lt;").replace(/>/g, "&gt;");
           return `<pre><code>${escapedCode}</code></pre>`;
       });
      html = html.replace(/`([^`]+)`/g, '<code>$1</code>');
      html = html.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
      html = html.replace(/(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)/g, '<em>$1</em>');
      html = html.replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>');
      html = html.replace(/\n/g, '<br>');
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
      if (this.$refs.inputField) {
        this.$refs.inputField.focus();
      }
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
/* Styles remain largely the same */
/* ... (paste previous styles here) ... */
.ai-service-container {
  display: flex;
  flex-direction: column;
  height: 70vh; /* Example height */
  width: 100%;
  max-width: 900px;
  margin: 30px auto;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  background-color: #f9f9f9;
  overflow: hidden;
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 20px;
  background-color: #1E9FFF;
  color: white;
  border-bottom: 1px solid #e0e0e0;
  flex-shrink: 0; /* Prevent header from shrinking */
}

.chat-header h2 {
  margin: 0;
  font-size: 17px;
  font-weight: 600;
}

.status {
  font-size: 12px;
  padding: 4px 10px;
  border-radius: 12px;
}

.status.online {
  background-color: #4CAF50;
  color: white;
}
/* Style for error status */
.status:not(.online) {
  background-color: #f44336; /* Red */
  color: white;
}


.chat-messages {
  flex-grow: 1; /* Allow messages to take available space */
  padding: 25px 20px;
  overflow-y: auto;
  background-color: #ffffff;
 /* min-height: 450px; /* Maybe remove if fixed height is used */
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

/* --- Message Content Styling --- */
.message-content {
  max-width: calc(100% - 110px); /* Adjust based on avatar/margins */
  padding: 12px 18px;
  border-radius: 15px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.06);
  line-height: 1.6;
  word-wrap: break-word; /* Ensure long words wrap */
   overflow-wrap: break-word; /* Better standard */
   white-space: pre-wrap; /* Preserve whitespace and wrap */
}

.user-message .message-content {
  background-color: #e1f5fe;
  color: #333;
  border-bottom-right-radius: 5px;
}

.ai-message .message-content {
  background-color: #f1f1f1;
  border-bottom-left-radius: 5px;
}
.welcome-message .message-content {
   background-color: #f1f1f1;
   border-bottom-left-radius: 5px;
}
.welcome-message .message-content p {
    margin: 0;
}

/* --- Code Block Styling (within message-content) --- */
.message-content :deep(pre) { /* Use :deep() for v-html content */
  background-color: #2d2d2d; /* Dark background */
  color: #f0f0f0;         /* Light text */
  padding: 12px 15px;
  border-radius: 6px;
  overflow-x: auto;        /* Allow horizontal scroll for long lines */
  margin: 10px 0;
  box-shadow: inset 0 1px 3px rgba(0,0,0,0.3);
  white-space: pre;       /* Preserve whitespace strictly in pre */
}

.message-content :deep(code) { /* General code styling */
  font-family: 'Consolas', 'Monaco', 'Courier New', Courier, monospace;
   font-size: 0.9em;
}

/* Inline code (not inside pre) */
.message-content :deep(code:not(pre code)) {
  background-color: #e8e8e8;
  padding: 2px 5px;
  border-radius: 4px;
  color: #333;
}

/* Code inside pre should inherit background/color */
.message-content :deep(pre code) {
  background-color: transparent;
  padding: 0;
  border-radius: 0;
  color: inherit; /* Use the color set by 'pre' */
   white-space: inherit; /* Allow pre to handle wrapping */
}

.message-content :deep(a) {
  color: #007bff;
  text-decoration: none;
}

.message-content :deep(a:hover) {
  text-decoration: underline;
}

/* --- Typing Indicator (Now as a placeholder message) --- */
/* Re-use the styling for the message item */
.ai-message .typing-indicator {
  display: inline-flex; /* Align dots horizontally */
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

/* --- Input Area --- */
.chat-input {
  display: flex;
  align-items: flex-end; /* Align items to the bottom */
  padding: 12px 15px;
  background-color: #f9f9f9;
  border-top: 1px solid #e8e8e8;
  flex-shrink: 0; /* Prevent input area from shrinking */
}

.chat-input textarea {
  flex: 1;
  min-height: 42px;
  max-height: 100px; /* Limit growth */
  padding: 10px 18px;
  border: 1px solid #ddd;
  border-radius: 21px;
  resize: none; /* Disable manual resizing */
  outline: none;
  font-family: inherit;
  font-size: 14px;
  margin-right: 10px;
  background-color: #ffffff;
  line-height: 1.5;
  transition: border-color 0.3s;
  overflow-y: auto; /* Allow scrolling if content exceeds max-height */
}

.chat-input textarea:focus {
  border-color: #1E9FFF;
}
/* Disable textarea when offline */
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
