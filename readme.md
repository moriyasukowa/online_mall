# 项目指南

## 1. 编译 Vue3 项目
```bash

cd web
$env:NODE_OPTIONS="--openssl-legacy-provider"
npm run dev

```
采购计划->采购单->入库单
客户订单->出库单->运输单
客户订单->退款申请->入库单


```bash
cd server
python manage.py runserver 8888
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
git commit -m "5.22 更新演示顺序"
git push origin main
```
