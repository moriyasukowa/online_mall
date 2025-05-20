<template>
    <base-page :activation="activation"></base-page>
    <div class="login-page-wrapper">
        <div class="login-container">
            <div class="login-header">
                <h2>用户登录</h2>
            </div>
            <div class="login-form">
                <!-- Using Layui form structure for consistency if you use it elsewhere,
                     but styled for a more modern look.
                     You can also opt for completely custom form elements. -->
                <div class="layui-form"> <!-- Keep for potential Layui JS form validation if used -->
                    <div class="form-group">
                        <div class="input-wrapper">
                            <i class="layui-icon layui-icon-cellphone input-icon"></i>
                            <input type="text" name="username" v-model="username"
                                   placeholder="请输入手机号" autocomplete="username"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <i class="layui-icon layui-icon-password input-icon"></i>
                            <input type="password" name="password" v-model="password"
                                   placeholder="请输入密码" autocomplete="current-password"
                                   class="layui-input" @keyup.enter="handleLogin">
                        </div>
                    </div>

                    <div v-if="msg" class="error-message">
                        <p>{{ msg }}</p>
                    </div>

                    <div class="form-group">
                        <button class="layui-btn login-submit-btn" @click="handleLogin">
                            登 录
                        </button>
                    </div>

                    <div class="extra-links">
                        <router-link to="/register" class="link">还没有账户？立即注册</router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer-page></footer-page>
</template>

<script>
export default {
    name: "Login",
    data() {
        return {
            activation: "login",
            msg: "",
            username: "",
            password: ""
        }
    },
    methods: {
        handleLogin: function () {
            if (!this.username || !this.password) {
                this.msg = "手机号和密码不能为空";
                return;
            }
            this.msg = ""; // Clear previous messages

            // Basic phone number validation (you might want a more robust one)
            const phoneRegex = /^1[3-9]\d{9}$/;
            if (!phoneRegex.test(this.username)) {
                this.msg = "请输入有效的手机号码";
                return;
            }


            this.axios.post('/api/v1/shopper/login/', { username: this.username, password: this.password })
                .then(response => {
                    if (response.data.state === 'success') {
                        this.msg = response.data.msg || "登录成功！"; // Provide a default success message
                        this.$store.commit('setUserName', this.username);
                        this.$store.commit('setLastLogin', response.data.last_login);
                        // Redirect after a short delay to allow user to see success message
                        setTimeout(() => {
                            this.$router.push({ path: '/shopper' });
                        }, 1000);
                    } else {
                        this.msg = response.data.msg || "登录失败，请检查您的凭据。";
                    }
                })
                .catch(error => {
                    console.error("Login error:", error);
                    if (error.response && error.response.data && error.response.data.msg) {
                        this.msg = error.response.data.msg;
                    } else if (error.response && error.response.status === 401){
                        this.msg = "用户名或密码错误。";
                    }
                     else {
                        this.msg = "登录时发生错误，请稍后再试。";
                    }
                });
        }
    }
}
</script>

<style scoped>
.login-page-wrapper {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: calc(100vh - 120px); /* Adjust 120px based on your header/footer height */
    background-color: #f0f2f5; /* A light, neutral background */
    padding: 20px;
    box-sizing: border-box;
}

.login-container {
    width: 100%;
    max-width: 400px;
    background-color: #ffffff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.login-header {
    text-align: center;
    margin-bottom: 25px;
}

.login-header h2 {
    font-size: 24px;
    color: #333;
    font-weight: 600;
}

.form-group {
    margin-bottom: 20px;
}

.input-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.input-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #888;
    font-size: 18px;
}

.layui-input {
    width: 100%;
    height: 45px;
    padding: 10px 15px 10px 45px; /* Make space for the icon */
    border: 1px solid #dce3e8;
    border-radius: 6px;
    font-size: 15px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.layui-input:focus {
    border-color: #1E9FFF;
    box-shadow: 0 0 0 2px rgba(30, 159, 255, 0.2);
    outline: none;
}

.error-message {
    color: #ff5722; /* Layui error red */
    font-size: 14px;
    text-align: center;
    margin-bottom: 15px;
    min-height: 20px; /* Prevent layout shift */
}
.error-message p {
    margin: 0;
}

.login-submit-btn {
    width: 100%;
    height: 45px;
    font-size: 16px;
    background-color: #1E9FFF; /* Layui primary blue */
    border: none;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
}

.login-submit-btn:hover {
    background-color: #007cdb; /* Darker blue on hover */
}

.extra-links {
    margin-top: 25px;
    display: flex;
    justify-content: space-between; /* Adjust as needed: space-around or center */
    font-size: 14px;
}

.extra-links .link {
    color: #1E9FFF;
    text-decoration: none;
    transition: color 0.3s;
}

.extra-links .link:hover {
    color: #007cdb;
    text-decoration: underline;
}
</style>
