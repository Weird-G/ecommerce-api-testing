"""
冒烟测试：启动即跑，用来验证环境可用性
- 服务联通性
- 三角色登录（账号正确/错误）
- 白名单接口匿名可访问
"""
import allure
import pytest

from common.assertions import AssertAPI
from config import ACCOUNTS


@allure.epic("冒烟测试")
@allure.feature("环境连通性")
class TestSmoke:

    # ------------------------------------------------------------------
    # 1. 基础联通
    # ------------------------------------------------------------------
    @allure.story("首页联通")
    @allure.title("GET / 应该返回成功")
    @allure.severity(allure.severity_level.BLOCKER)
    @pytest.mark.smoke
    def test_hello(self, web_api, assert_api: AssertAPI):
        result = web_api.hello()
        assert_api.assert_success(result)

    # ------------------------------------------------------------------
    # 2. 三角色登录：正确账号
    # ------------------------------------------------------------------
    @allure.story("登录")
    @allure.title("管理员账号登录成功 - 账号:{username}")
    @allure.severity(allure.severity_level.BLOCKER)
    @pytest.mark.smoke
    @pytest.mark.parametrize(
        "role_key",
        ["admin", "business", "user"],
        ids=lambda r: f"角色={r.upper()}",
    )
    def test_login_ok(self, role_key, web_api, assert_api: AssertAPI):
        acc = ACCOUNTS[role_key]
        with allure.step(f"使用账号 {acc['username']} / role={acc['role']} 登录"):
            result = web_api.login(acc["username"], acc["password"], acc["role"])
        assert_api.assert_success(result)
        data = result.get("data") or {}
        assert data.get("token"), f"登录响应缺少 token: {data}"
        assert data.get("role") == acc["role"]

    # ------------------------------------------------------------------
    # 3. 登录错误分支（等价类）
    # ------------------------------------------------------------------
    @allure.story("登录异常分支")
    @allure.title("错误密码登录失败")
    @allure.severity(allure.severity_level.CRITICAL)
    @pytest.mark.smoke
    def test_login_wrong_password(self, web_api, assert_api: AssertAPI):
        result = web_api.login("admin", "wrongpwd", "ADMIN")
        # 账号或密码错误 5003
        assert_api.assert_code(result, "5003")

    @allure.story("登录异常分支")
    @allure.title("缺少参数登录失败 - {case}")
    @allure.severity(allure.severity_level.CRITICAL)
    @pytest.mark.smoke
    @pytest.mark.parametrize(
        "case,payload",
        [
            ("无username", {"password": "123456", "role": "USER"}),
            ("无password", {"username": "u1", "role": "USER"}),
            ("无role", {"username": "u1", "password": "123456"}),
        ],
    )
    def test_login_param_lost(self, case, payload, web_api, raw_client):
        resp = raw_client.post("/login", json_body=payload)
        body = raw_client.api_result(resp)
        # 参数缺失 4001
        assert body.get("code") == "4001", f"{case}: {body}"

    # ------------------------------------------------------------------
    # 4. 白名单接口匿名访问
    # ------------------------------------------------------------------
    @allure.story("白名单接口")
    @allure.title("匿名访问白名单接口应全部成功")
    @allure.severity(allure.severity_level.NORMAL)
    @pytest.mark.smoke
    @pytest.mark.parametrize(
        "method,path,params",
        [
            ("GET", "/goods/selectPage", {"pageNum": 1, "pageSize": 5}),
            ("GET", "/goods/selectById", {"id": 1}),
            ("GET", "/type/selectAll", None),
            ("GET", "/notice/selectAll", None),
            ("GET", "/comment/selectByGoodsId", {"id": 1}),
        ],
        ids=lambda x: str(x) if isinstance(x, str) else "",
    )
    def test_whitelist_anon(self, method, path, params, raw_client, assert_api: AssertAPI):
        if method == "GET":
            resp = raw_client.get(path, params=params)
        else:
            resp = raw_client.post(path, params=params)
        body = raw_client.api_result(resp)
        assert_api.assert_success(body)
