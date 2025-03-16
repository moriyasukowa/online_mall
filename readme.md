```markdown
# 项目运行指南

该项目由 Django 和 Vue 开发，`serve` 文件夹为后端，`web` 文件夹为前端。

## 运行后端（Django）

1. 进入 `serve` 文件夹：
    ```bash
    cd server
    python manage.py runserver 8888

    ```

## 运行前端（Vue）

1. 进入 `web` 文件夹：
    ```bash
    cd web
    npm install
    npm config set registry https://registry.npmmirror.com
    $env:NODE_OPTIONS="--openssl-legacy-provider"
    npm run dev
    
    ```

支付邮箱和密码：
evhiak0409@sandbox.com
111111