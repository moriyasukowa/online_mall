# 项目指南

## 1. 编译 Vue3 项目
```bash

cd web
$env:NODE_OPTIONS="--openssl-legacy-provider"
npm run dev

```

```bash
cd server
python manage.py 
```

## 2. 迁移 Django 数据库
```bash
cd server
python manage.py makemigrations
python manage.py migrate
```

## 3. 上传到 GitHub
```bash
git add .
git commit -m "4.21 小更新，优化数据库结构，涉及到地址，物流单，入库单等"
git push origin main
```
