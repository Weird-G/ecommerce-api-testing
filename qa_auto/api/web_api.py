from typing import Any, Dict

from api.base_api import BaseApi
from common.http_client import HttpClient
from config import ACCOUNTS


class WebApi(BaseApi):
    """
    全局接口（登录/注册/修改密码/首页）
    对应 WebController
    """

    PATH = ""

    def __init__(self, client=None, session=None):
        super().__init__(client, session)

    def hello(self) -> Dict[str, Any]:
        resp = self.client.get("/")
        return self.client.api_result(resp)

    def login(self, username: str, password: str, role: str) -> Dict[str, Any]:
        resp = self.client.post(
            "/login",
            json_body={"username": username, "password": password, "role": role},
        )
        return self.client.api_result(resp)

    def register(self, username: str, password: str, role: str, **extra) -> Dict[str, Any]:
        payload = {"username": username, "password": password, "role": role, **extra}
        resp = self.client.post("/register", json_body=payload)
        return self.client.api_result(resp)

    def update_password(
        self, username: str, password: str, new_password: str, role: str
    ) -> Dict[str, Any]:
        resp = self.client.put(
            "/updatePassword",
            json_body={
                "username": username,
                "password": password,
                "newPassword": new_password,
                "role": role,
            },
        )
        return self.client.api_result(resp)

    # ------------------------------------------------------------------
    # 便捷：使用配置账号登录并注入 token 到 client
    # ------------------------------------------------------------------
    def login_as(self, role_key: str) -> Dict[str, Any]:
        """
        role_key: admin / business / user
        返回登录成功后的 account 数据（内含 token）
        """
        acc = ACCOUNTS[role_key]
        result = self.login(acc["username"], acc["password"], acc["role"])
        if result.get("code") == "200" and result.get("data"):
            token = result["data"].get("token")
            if token:
                self.client.set_token(token)
        return result
