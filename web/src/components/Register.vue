<template>
  <base-page :activation="activation"></base-page>

  <div class="register-container">
    <div class="register-box">
      <div class="register-header">
        <h2>新用户注册</h2>
      </div>
      <div class="register-form">
        <form class="layui-form">
          <!-- Phone Number -->
          <div class="layui-form-item">
            <div class="layui-input-block">
              <i class="layui-icon layui-icon-cellphone input-icon"></i>
              <input
                name="username"
                id="reg-username"
                v-model="formData.username"
                lay-verify="required|phone"
                placeholder="请输入手机号"
                class="layui-input"
                autocomplete="tel"
              />
            </div>
          </div>

          <!-- Password -->
          <div class="layui-form-item">
            <div class="layui-input-block">
              <i class="layui-icon layui-icon-password input-icon"></i>
              <input
                id="reg-password"
                type="password"
                v-model="formData.password"
                name="password"
                lay-verify="required|password|passwordStrength"
                placeholder="请输入密码 (8位以上，含字母和数字)"
                class="layui-input"
                autocomplete="new-password"
              />
            </div>
          </div>

          <!-- Confirm Password -->
          <div class="layui-form-item">
            <div class="layui-input-block">
              <i class="layui-icon layui-icon-password input-icon"></i>
              <input
                id="reg-password2"
                type="password"
                v-model="formData.password2"
                name="password2"
                lay-verify="required|confirmPassword"
                placeholder="请再次输入密码"
                class="layui-input"
                autocomplete="new-password"
              />
            </div>
          </div>

          <!-- Captcha (Simple Client-Side Example) -->
          <div class="layui-form-item captcha-item">
            <div class="layui-input-block">
              <input
                type="text"
                name="captchaCode"
                v-model="formData.captchaCode"
                lay-verify="required|captchaCheck"
                placeholder="请输入验证码"
                class="layui-input captcha-input"
              />
              <span class="captcha-text" @click="generateCaptcha">
                {{ captchaText }}
              </span>
            </div>
          </div>

          <p class="error-msg">{{ msg }}</p>

          <div class="layui-form-item register-actions">
            <div class="layui-input-block">
              <button class="layui-btn layui-btn-fluid" lay-submit="" lay-filter="registerSubmit">立即注册</button>
            </div>
          </div>

          <div class="register-footer">
            <span>已有账号？</span>
            <router-link to="/shopper/login" class="login-link">立即登录</router-link>
          </div>
        </form>
      </div>
    </div>
  </div>

  <footer-page></footer-page>
</template>

<script>
export default {
  name: "Register",
  data() {
    return {
      activation: "register",
      msg: "",
      formData: {
        username: "",
        password: "",
        password2: "",
        captchaCode: "", // User input captcha
      },
      captchaText: "", // Displayed captcha text
    };
  },
  mounted() {
    // Initialize Layui form validation here
    window.layui.form.render(); // Render Layui form elements if any (like radios, checkboxes etc. not used here)
    this.setupLayuiValidation(); // Set up custom validation rules
    this.generateCaptcha(); // Generate initial captcha
  },
  methods: {
    setupLayuiValidation() {
      const _this = this; // Keep a reference to the Vue instance

      window.layui.form.verify({
        phone: [/^1[3-9]\d{9}$/, '手机号格式不正确'], // Standard phone regex
        passwordStrength: function(value){
            if (value.length < 8) {
                return '密码长度不能少于8位';
            }
            if (!/[a-zA-Z]/.test(value)) {
                return '密码必须包含字母';
            }
            if (!/\d/.test(value)) {
                return '密码必须包含数字';
            }
        },
        confirmPassword: function(value){
            if (value !== _this.formData.password) { // Use _this to access Vue data reactivity
                return '两次输入的密码不一致';
            }
        },
        captchaCheck: function(value){
            // Simple case-insensitive check
            if (value.toLowerCase() !== _this.captchaText.toLowerCase()) {
                return '验证码不正确';
            }
        }
      });

      // Listen for form submission event from Layui
      window.layui.form.on('submit(registerSubmit)', function(data){
        // data.field contains form data if using lay-filter="registerSubmit"
        // We'll use our Vue data instead as it's already reactive
        _this.register(); // Call Vue method onSubmit
        return false; // Prevent default Layui submit and page refresh
      });
    },

    generateCaptcha() {
        // Simple random string captcha (NOT SECURE for production)
        const chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz0123456789";
        let text = "";
        const length = 4; // Captcha length
        for (let i = 0; i < length; i++) {
          text += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        this.captchaText = text;
        console.log("Generated Captcha:", this.captchaText); // For testing
    },

    async register() {
      // At this point, Layui's validation *should* have passed unless btn is clicked programmatically
      // But we can add a final check here if needed
      // console.log("Registering with:", this.formData);

      this.msg = ""; // Clear previous messages

      try {
        const response = await this.axios.post("/api/v1/shopper/register/", {
          username: this.formData.username,
          password: this.formData.password,
          password2: this.formData.password2,
          captcha_code: this.formData.captchaCode, // Send user entered code
          captcha_text: this.captchaText, 
        });

        if (response.data.state === "success") {
          this.msg = response.data.msg || "注册成功！请立即登录。";
          // Optionally clear the form or redirect to login
          // this.formData = { username: '', password: '', password2: '', captchaCode: '' };
          // this.generateCaptcha(); // New captcha after success
          setTimeout(() => {
             this.$router.push({ path: "/shopper/login" }); // Redirect to login after successful registration
          }, 1000); // Redirect after 2 seconds
        } else {
          // Handle registration failure (e.g., user exists, validation failed)
          this.msg = response.data.msg || "注册失败，请重试。";
          this.generateCaptcha(); // Refresh captcha on failure
        }
      } catch (error) {
        console.error("Register API error:", error);
        if (error.response && error.response.data && error.response.data.msg) {
            this.msg = error.response.data.msg;
        } else {
            this.msg = "注册过程中发生错误，请稍后再试。";
        }
        this.generateCaptcha(); // Refresh captcha on error
      }
    },
  },
  beforeUnmount() {
      // Clean up Layui form listener if necessary
      // window.layui.form.on('submit(registerSubmit)', null); // Doesn't always work reliably if Layui not properly namespaced
  }
};
</script>

<style scoped>
/* Reuse many styles from Login.vue for consistency */
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: calc(100vh - 100px); /* Same as login */
  background-color: #f8f8f8;
  padding: 20px;
}

.register-box {
  background-color: #ffffff;
  padding: 30px 40px;
  border-radius: 8px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 400px; /* Slightly wider for potentially more fields */
  text-align: center;
}

.register-header {
  margin-bottom: 30px;
}

.register-header h2 {
  font-size: 24px;
  color: #333;
  margin-bottom: 0;
}

.register-form .layui-form-item {
  margin-bottom: 20px;
}

.register-form .layui-input-block {
  margin-left: 0 !important;
  position: relative;
}

.register-form .input-icon {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #aaa;
  font-size: 18px;
  z-index: 1; /* Ensure icon is above input */
}

.register-form .layui-input {
  padding-left: 40px;
  border-radius: 4px;
  height: 40px;
  line-height: 40px;
}
.register-form .layui-input:focus + .input-icon {
    color: #1E9FFF;
}

/* Captcha Specific Styles */
.captcha-item .layui-input-block {
    display: flex; /* Arrange input and text side-by-side */
    align-items: center;
}

.captcha-input {
    flex-grow: 1; /* Allow input to take available space */
    margin-right: 10px; /* Space between input and text */
    padding-left: 12px !important; /* Captcha input might not need left icon padding */
}

.captcha-text {
    flex-shrink: 0; /* Prevent captcha text from shrinking */
    width: 100px; /* Fixed width for captcha text area */
    height: 40px;
    line-height: 40px;
    background-color: #eee; /* Light background for visual distinction */
    border-radius: 4px;
    cursor: pointer;
    user-select: none; /* Prevent selecting the text */
    font-family: monospace; /* Monospaced font for consistent character width */
    font-size: 18px;
    font-weight: bold;
    color: #333;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #ddd;
    transition: background-color 0.2s;
}
.captcha-text:hover {
    background-color: #e0e0e0;
}

.error-msg {
  color: #ff5722;
  min-height: 20px;
  margin-top: -15px;
  margin-bottom: 15px;
  font-size: 12px;
  text-align: left;
  padding-left: 10px;
}

.register-actions .layui-btn {
  height: 45px;
  line-height: 45px;
  font-size: 16px;
  border-radius: 4px;
}

.register-footer {
  margin-top: 25px;
  font-size: 14px;
}

.login-link {
  color: #1E9FFF;
  text-decoration: none;
  margin-left: 5px;
}

.login-link:hover {
  text-decoration: underline;
}

/* Layui form overrides */
.register-form .layui-form-label {
    padding: 0 !important;
    width: auto !important;
    float: none !important;
    display: block;
    text-align: left;
    margin-bottom: 5px;
}
.register-form .layui-input-block {
    width: 100% !important;
}

</style>
