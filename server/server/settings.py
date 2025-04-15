from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'tq%piy+c3pntex*%)7m&1xoo1&1hb6cp2v42eyqaj)%f%jxc&5'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']
# 关闭SimpleUI默认的广告和分析统计
SIMPLEUI_HOME_INFO = False  # 关闭首页的快捷操作和向导
# 隐藏默认的“最近动作”和“快捷操作”


INSTALLED_APPS = [
    'simpleui',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'commodity',
    'shopper',
    'corsheaders',
    'logistics',
    'django_select2',
    'select2',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    # 添加中间件LocaleMiddleware
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'server.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'server.wsgi.application'



DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'py_online_mall',
        'USER': 'root',
        'PASSWORD': '204709',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}



AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]



LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True
import os

STATIC_URL = '/static/'
# 开发环境静态文件目录
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),  # 指向你的实际路径：C:\...\server\static
]
# 生产环境收集目录（保持原样）
STATIC_ROOT = os.path.join(BASE_DIR, '\static_root')


MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '\media')

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

REST_FRAMEWORK = {
    # 配置分页器
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    # 每页的数据量
    'PAGE_SIZE': 6,
    # 用户认证方式
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.BasicAuthentication',
    ),
}
# 设置跨域访问
# 指定所有域名(IP)都可以访问，默认为False
CORS_ORIGIN_ALLOW_ALL = True
# 设置允许携带Cookie
CORS_ALLOW_CREDENTIALS = True
# 设置允许访问的域名(IP)
# 如果CORS_ORIGIN_ALLOW_ALL=True则无需设置
CORS_ORIGIN_WHITELIST = []
# 允许执行的请求方式
CORS_ALLOW_METHODS = (
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
    'VIEW',
)
# 允许执行的请求头
CORS_ALLOW_HEADERS = (
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
)
USE_TZ = False
TIME_ZONE = 'Asia/Shanghai'
LANGUAGE_CODE = 'zh-hans'

# settings.py
ALIPAY_CONFIG = {
    "app_id": "9021000143699271",
    "alipay_public_key_string": 
    """-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApbsqyqBxd3C+2iakzUUsN9/mRcZGF3VxSYYXlY5m5mop/1zYgrgHSTdOT342PQEptAGK97X0kHGc72j7KmANsKlDwivKETg2f7I6R1EXgioQs5oULCm8m4qZrak0WygqeTmyM3WMyev0UDv9Em/n3rn20+KYXW2C1tqlsDmJACMPjkW2rd4UPbfj+cjit4Wbth7hF7H4UAEiq4gQfx4rIQR3LkXUQYzoC6S5oDqA9V6O9rg6ETTdMoPcUE3xN7HAkoT7PUpkj1lC/8th4686oQqjb72iF8q3FFY+U+LxA6G1eI77EY1qd0DUf8qphVrPYdS9eiSzEVuiuGoPqhv7eQIDAQAB
-----END PUBLIC KEY-----""",  # 应用私钥
    "app_private_key_string": 
"""-----BEGIN RSA PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCaqPEYlKdIWFB9Gb0JsnTs472sHKlDqJy7dZ8anRNGXeRMmdC6r+pEFCaHZMFbWxcFNZppwMu99v9jb8QiAMH2DMshS0wt5b1vXDvnMLMrfxQ2Kq2yY5t68Q1N/QuAMngbLD2PxlE36m9xvIlvulAkXPJ6sBaw2e6OzoLpquSYI4trb/OrDvFGuRWGYV1l/jMOf2av4DHb7YSA2L4hQ9HhPM2EUNnzKrOKZoKaLoW7tL7aoj0Cgp5bckT5GeclZbMy26wOyNTAKqH9e9a9wsrR+oHyMQr8/WDzD/3+AtFWZ8c6qp4ijyJ9gkTZ/OZY6oljtaJ3B+vT826HYGlFLOXvAgMBAAECggEAeKRkPVpoCyTo1E0pitDsKIWWRRWua5qxeAFOdQImMPO4zJAHpDjpMuXNEDxmIA80K9oec3Py+mIb4cMjaarRok9kfLox2HOni6CVEciJWtqsN3yfNdJBTGuQh09mkz/LNNcTxn1aiZWUDVKWmtLpBRSECXQmnxnA3yD0ObYWzx1iEGhsbWkwwpCnD7TQFAV8PLO1xgfHGYxj+7F9z+VxKYkxlkEinXtlzD+4DTF/PvH1eiftsl01utoRwmQ3OIjWPV6ykIF/14kXUkrbZK+e2yfP2kWNxT4OqIDf6rJvn/0GqofYWbbHzzYN828Z8QqkX42ot5Dc8t3WnVy3Ywu+YQKBgQDhxjc9UKE1+H8mgxVW4OP3QhaQ9GVcO4R4MZtetwiCiqry5psIHRRILkHk9NmPj+sfXd+TwGXKXFsGpOQP0wEGeAGVo6RPuD9SNpUu6qFp8JvPZKEOSRWzItjB8sPcqaKTJ5EcpEUVXJA0H28fw08+lCT+GoTrlY6ltJrfVvR7iQKBgQCvXXrUMIRGcFI49rfrwUa9dw9LzbMnlbdzKnJBePAUe83//uoqQgWeDIYu1RtfJhU3Tt0Kxn1f7efWlB4oLmh8leQSt4TI2V0UpmP88lpWZoeI3nqLU3gMpR9Ylu1MvKa5RQ2dAed0FejQwPp0VBBX7ggApVWzCZbdBKGFKhsftwKBgQCRS77A9uLImOM7JaDWCGSs+xsKrj2M3cCimUoj6ibP2+2n5EBhOFWVHi/J6MkaWsQ1q3P24hqf4E+0NumORXyjbReX9XgI1cnqXrYjO1wlkXK0RU5goygT4JkeN91UZNb7XLtGc3ECDk+/O3uINWkKHMyxut9PvS/P9Cq3EH7GAQKBgAqVNptljiX+E0gyw2ir0kwOylKFyGEELPz7O8ftt3dU/VqMlK8WKuad1N8wpyU31CHxVW+YCOroHYyahbNhEZcrKIdkodPJIk/jtrcGHSOHrng5DOYplF4W/OxIt2thGyKlIywteD1OMS2f571rcU0NJVh8oc5bLsqJxAGYR+jDAoGBANMhrOVGvQ9aTfCTBE+DKauMGAPQ/fChtMAufAR/Lk3yjELQkI8cqmuOsa8mb9ARAuWHqpuljlYCH4aC7FhBVKw1qu6Ab7RwSpT/hU6dR3Mi7+QRmdcofxZdCjitDGdVL0rjnFjbgLrWCU7ew4fm8VaBW53k2OhbYmyuvkDtF8dm
-----END RSA PRIVATE KEY-----""",  # 支付宝公钥
    "sign_type": "RSA2",  # 加密方式
    "debug": True,  # 生产环境设为 False
}