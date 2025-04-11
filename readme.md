# 项目编译与数据库迁移指南

## 迁移数据库

在 Django 项目的根目录下运行以下命令来迁移数据库。

```bash
python server/manage.py makemigrations
python server/manage.py migrate
```

## 编译 Vue 项目

在 `web` 目录下运行以下命令来编译 Vue 项目。

```bash
cd web
$env:NODE_OPTIONS="--openssl-legacy-provider"
npm run dev
```

```bash
python server/manage.py runserver 8888
```

## 上传到 GitHub

在项目根目录下运行以下命令将代码上传到 GitHub：

```bash
git add .
git commit -m "4.11上课前更新代码库"
git push -u origin main
```

