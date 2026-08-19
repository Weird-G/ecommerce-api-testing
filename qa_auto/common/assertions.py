from typing import Any, Dict

import allure

from common.http_client import RequestError


class AssertAPI:
    """
    对后端 Result{code, msg, data} 统一结构进行断言
    """

    SUCCESS_CODE = "200"

    @staticmethod
    @allure.step("断言响应成功")
    def assert_success(result: Dict[str, Any], msg: str = "") -> None:
        assert result.get("code") == AssertAPI.SUCCESS_CODE, (
            f"{msg} 期望成功(200), 实际 code={result.get('code')} "
            f"msg={result.get('msg')}"
        )

    @staticmethod
    @allure.step("断言响应失败")
    def assert_code(result: Dict[str, Any], expected_code: str, msg: str = "") -> None:
        assert result.get("code") == expected_code, (
            f"{msg} 期望 code={expected_code}, 实际 code={result.get('code')} "
            f"msg={result.get('msg')}"
        )

    @staticmethod
    @allure.step("断言 data 非空")
    def assert_data_not_empty(result: Dict[str, Any], msg: str = "") -> None:
        AssertAPI.assert_success(result, msg)
        data = result.get("data")
        assert data not in (None, [], {}), f"{msg} data 为空: {data}"

    @staticmethod
    @allure.step("断言 401 未授权")
    def assert_unauthorized(result: Dict[str, Any]) -> None:
        """后端 401 对应 TOKEN_INVALID_ERROR / TOKEN_CHECK_ERROR"""
        assert result.get("code") == "401", (
            f"期望 401, 实际 code={result.get('code')} msg={result.get('msg')}"
        )

    @staticmethod
    def http_status_ok(resp, expected=200):
        assert resp.status_code == expected, (
            f"HTTP 状态码异常: 期望 {expected}, 实际 {resp.status_code}"
        )
