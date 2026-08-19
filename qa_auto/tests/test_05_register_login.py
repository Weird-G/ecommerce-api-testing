"""
登录注册完整流程
- 注册新用户 -> 登录 -> 修改密码
- 边界值：用户名空/重复注册
"""
import allure
import pytest

from common.assertions import AssertAPI
from utils.helpers import random_str


@allure.epic("账户模块")
@allure.feature("注册-登录-改密流程")
class TestRegisterFlow:

    @allure.story("注册")
    @allure.title("注册用户 -> 登录 -> 修改密码")
    def test_register_login_change_password(self, web_api, assert_api: AssertAPI):
        username = f"autotest_{random_str(8)}"
        password = "123456"
        new_password = "abcdef123"

        with allure.step(f"注册用户 {username}"):
            r = web_api.register(username, password, "USER", name="自动测试用户")
            # 允许 200 或 5001(重名)
            if r.get("code") == "5001":
                pytest.skip(f"用户名已存在: {username}")
            assert_api.assert_success(r, "注册")

        with allure.step("用原密码登录"):
            login1 = web_api.login(username, password, "USER")
            assert_api.assert_success(login1, "首次登录")
            # 登录成功后把 token 注入 client，后续受保护接口才能调用
            token = (login1.get("data") or {}).get("token")
            assert token, f"登录响应缺少 token: {login1}"
            web_api.client.set_token(token)

        with allure.step("修改密码"):
            change_r = web_api.update_password(
                username=username,
                password=password,
                new_password=new_password,
                role="USER",
            )
            assert_api.assert_success(change_r, "修改密码")
            # 改密后旧 token 可能失效，清掉
            web_api.client.clear_token()

        with allure.step("用新密码登录成功，旧密码失败"):
            login_new = web_api.login(username, new_password, "USER")
            assert_api.assert_success(login_new, "新密码登录")
            login_old = web_api.login(username, password, "USER")
            assert_api.assert_code(login_old, "5003", "原密码登录应报账号密码错误")

    @allure.story("注册边界值")
    @allure.title("缺少注册参数应返回4001")
    @pytest.mark.parametrize(
        "case,payload",
        [
            ("空username", {"username": "", "password": "123456", "role": "USER"}),
            ("空password", {"username": "a", "password": "", "role": "USER"}),
            ("无role",     {"username": "a", "password": "123456"}),
        ],
    )
    def test_register_param_lost(self, case, payload, web_api):
        r = web_api.register(**payload) if "role" in payload else web_api.register(
            payload.get("username"), payload.get("password"), payload.get("role") or ""
        )
        assert r.get("code") == "4001", f"{case}: {r}"
