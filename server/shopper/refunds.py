# pip install pycryptodome
# pip install python-alipay-sdk

from alipay import AliPay
import time
from django.conf import settings


def refund(out_trade_no, total_amount, return_url):
    print(out_trade_no, total_amount, return_url)
    # 实例化支付应用
    alipay = AliPay(
        appid=settings.ALIPAY_CONFIG["app_id"],
        app_notify_url=None,
        app_private_key_string=settings.ALIPAY_CONFIG["app_private_key_string"],
        alipay_public_key_string=settings.ALIPAY_CONFIG["alipay_public_key_string"],
        sign_type=settings.ALIPAY_CONFIG["sign_type"],
        debug=settings.ALIPAY_CONFIG["debug"],
    )
    # 发起支付请求
    order_string = alipay.api_alipay_trade_refund(
        # 订单号，每次发送请求都不能一样
        out_trade_no=out_trade_no,
        # 支付金额
        refund_amount=str(total_amount),
        # 交易信息
        subject="测试退款",
        return_url=return_url + '?t=' + out_trade_no,
        notify_url=return_url + '?t=' + out_trade_no
    )
    print(order_string)
    return order_string
