"""
pytest 全局 fixtures
核心能力：
1. 多角色（ADMIN/BUSINESS/USER）JWT 会话管理 —— session 级别，仅登录一次
2. 各 API 实例注入（共享同一 HttpClient 会话）
3. 数据库客户端
"""
import os
import sys
from typing import Dict

import allure
import pytest
from loguru import logger

# ------------------------------------------------------------------
# 确保 qa_auto 根目录在 sys.path 中（pytest 调用时）
# ------------------------------------------------------------------
_HERE = os.path.dirname(os.path.abspath(__file__))
_ROOT = os.path.dirname(_HERE)
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from common.http_client import HttpClient
from common.mysql_client import db
from common.assertions import AssertAPI

from api.web_api import WebApi
from api.goods_api import GoodsApi
from api.cart_api import CartApi
from api.orders_api import OrdersApi
from api.user_api import (
    AdminApi,
    BusinessApi,
    UserApi,
    AddressApi,
    CollectApi,
    CommentApi,
    NoticeApi,
    TypeApi,
)


# ======================================================================
# 1. 底层：HttpClient
# ======================================================================
@pytest.fixture(scope="session")
def raw_client():
    """未登录的干净客户端（匿名访问用）"""
    return HttpClient()


@pytest.fixture(scope="session")
def _logged_client_map():
    """
    内部 fixture：统一在 session 级别维护三角色的登录态
    避免 admin_client / business_client / user_client 各自登录一次
    返回 dict: { role_key: (client, login_result) }
    """
    result: Dict[str, Dict] = {}
    for role_key in ("admin", "business", "user"):
        client = HttpClient()
        web = WebApi(client=client)
        logger.info(f"[Fixture] 开始登录 {role_key} ...")
        login_resp = web.login_as(role_key)
        if login_resp.get("code") != "200":
            logger.warning(
                f"[Fixture] {role_key} 登录失败: code={login_resp.get('code')} "
                f"msg={login_resp.get('msg')}。请确认 config.yaml 中账号密码/服务可用。"
            )
        else:
            logger.info(f"[Fixture] {role_key} 登录成功, token 已注入")
        result[role_key] = {"client": client, "login": login_resp}
    yield result
    # teardown（如有需要可登出）
    for role_key, info in result.items():
        info["client"].clear_token()


# ======================================================================
# 2. 已登录的 HttpClient（分别对应三个角色）
# ======================================================================
@pytest.fixture(scope="session")
def admin_client(_logged_client_map):
    return _logged_client_map["admin"]["client"]


@pytest.fixture(scope="session")
def business_client(_logged_client_map):
    return _logged_client_map["business"]["client"]


@pytest.fixture(scope="session")
def user_client(_logged_client_map):
    return _logged_client_map["user"]["client"]


@pytest.fixture(scope="session")
def admin_login_info(_logged_client_map):
    return _logged_client_map["admin"]["login"]


@pytest.fixture(scope="session")
def business_login_info(_logged_client_map):
    return _logged_client_map["business"]["login"]


@pytest.fixture(scope="session")
def user_login_info(_logged_client_map):
    return _logged_client_map["user"]["login"]


# ======================================================================
# 3. 通用 API 对象（按需要选择 client：匿名/角色）
# ======================================================================
@pytest.fixture(scope="session")
def web_api(raw_client):
    return WebApi(client=raw_client)


# ---- 匿名客户端（不注入 token） ----
@pytest.fixture(scope="session")
def goods_api_anon(raw_client):
    return GoodsApi(client=raw_client)


# ---- 管理员客户端 ----
@pytest.fixture(scope="session")
def admin_api(admin_client):
    return AdminApi(client=admin_client)


@pytest.fixture(scope="session")
def goods_api_admin(admin_client):
    return GoodsApi(client=admin_client)


# ---- 商家客户端 ----
@pytest.fixture(scope="session")
def business_api_self(business_client):
    """商家自己操作商家信息"""
    return BusinessApi(client=business_client)


@pytest.fixture(scope="session")
def goods_api_business(business_client):
    return GoodsApi(client=business_client)


# ---- 用户客户端 ----
@pytest.fixture(scope="session")
def user_api_self(user_client):
    return UserApi(client=user_client)


@pytest.fixture(scope="session")
def cart_api_user(user_client):
    return CartApi(client=user_client)


@pytest.fixture(scope="session")
def orders_api_user(user_client):
    return OrdersApi(client=user_client)


@pytest.fixture(scope="session")
def address_api_user(user_client):
    return AddressApi(client=user_client)


@pytest.fixture(scope="session")
def collect_api_user(user_client):
    return CollectApi(client=user_client)


@pytest.fixture(scope="session")
def comment_api_user(user_client):
    return CommentApi(client=user_client)


# ---- 公共（无需鉴权即可访问）----
@pytest.fixture(scope="session")
def type_api_anon(raw_client):
    return TypeApi(client=raw_client)


@pytest.fixture(scope="session")
def notice_api_anon(raw_client):
    return NoticeApi(client=raw_client)


# ======================================================================
# 4. 数据库 & 断言工具
# ======================================================================
@pytest.fixture(scope="session")
def mysql():
    return db


@pytest.fixture(scope="session")
def assert_api():
    return AssertAPI


# ======================================================================
# 5. 钩子：失败用例自动附加环境信息
# ======================================================================
@pytest.hookimpl(tryfirst=True, hookwrapper=True)
def pytest_runtest_makereport(item, call):
    outcome = yield
    rep = outcome.get_result()
    if rep.when == "call" and rep.failed:
        try:
            allure.attach(
                f"function={item.name}\nmodule={item.module}",
                name="失败用例上下文",
                attachment_type=allure.attachment_type.TEXT,
            )
        except Exception:
            pass


def pytest_collection_modifyitems(items):
    """解决 Windows 下中文用例名乱码"""
    for item in items:
        item.name = item.name.encode("utf-8").decode("unicode_escape", errors="ignore")
        if item._nodeid:
            item._nodeid = item._nodeid.encode("utf-8").decode(
                "unicode_escape", errors="ignore"
            )
