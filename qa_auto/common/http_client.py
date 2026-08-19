import json
import time
from typing import Any, Dict, Optional

import allure
import requests
from loguru import logger
from requests import Response, Session
from tenacity import (
    retry,
    retry_if_exception_type,
    stop_after_attempt,
    wait_fixed,
    before_sleep_log,
)

from config import BASE_URL, TIMEOUT, RETRY_TIMES, RETRY_INTERVAL


class RequestError(Exception):
    """自定义请求异常"""
    pass


class HttpClient:
    """
    统一 HTTP 请求客户端
    功能：
    1. 支持 Session 共享（JWT cookie/token 会话保持）
    2. 超时重试（tenacity 装饰）
    3. 异常捕获与日志记录
    4. 自动挂 Allure 请求附件
    """

    def __init__(self, session: Optional[Session] = None, base_url: str = BASE_URL):
        self.session = session or Session()
        self.base_url = base_url.rstrip("/")
        self.token: Optional[str] = None

    def set_token(self, token: str) -> None:
        """设置 JWT token（对应后端 header: token）"""
        self.token = token
        self.session.headers.update({"token": token})

    def clear_token(self) -> None:
        self.token = None
        self.session.headers.pop("token", None)

    # ------------------------------------------------------------------
    # 核心请求封装
    # ------------------------------------------------------------------
    def _log_request(self, method: str, url: str, **kwargs) -> None:
        logger.info(
            f"--> {method.upper()} {url} "
            f"params={kwargs.get('params')} "
            f"json={kwargs.get('json')} "
            f"headers={dict(self.session.headers)}"
        )

    def _log_response(self, resp: Response, elapsed: float) -> None:
        content_length = len(resp.content) if resp.content else 0
        logger.info(
            f"<-- {resp.status_code} {resp.reason} "
            f"({elapsed * 1000:.1f}ms, {content_length} bytes)"
        )
        try:
            logger.debug(f"Response body: {resp.text[:800]}")
        except Exception:
            pass

    def _attach_allure(self, method: str, url: str, resp: Response, **kwargs) -> None:
        try:
            allure.attach(
                f"{method.upper()} {url}\nparams={kwargs.get('params')}\njson={kwargs.get('json')}",
                name="Request",
                attachment_type=allure.attachment_type.TEXT,
            )
            allure.attach(
                resp.text or "",
                name=f"Response ({resp.status_code})",
                attachment_type=allure.attachment_type.JSON
                if "application/json" in resp.headers.get("Content-Type", "")
                else allure.attachment_type.TEXT,
            )
        except Exception:
            pass

    @retry(
        reraise=True,
        stop=stop_after_attempt(RETRY_TIMES),
        wait=wait_fixed(RETRY_INTERVAL),
        retry=retry_if_exception_type((RequestError, requests.ConnectionError, requests.Timeout)),
        before_sleep=before_sleep_log(logger, "WARNING"),  # type: ignore[arg-type]
    )
    def request(
        self,
        method: str,
        path: str,
        *,
        params: Optional[Dict[str, Any]] = None,
        json_body: Optional[Any] = None,
        data: Optional[Any] = None,
        files: Optional[Any] = None,
        headers: Optional[Dict[str, str]] = None,
        timeout: int = TIMEOUT,
        expect_status: Optional[int] = None,
    ) -> Response:
        url = path if path.startswith("http") else f"{self.base_url}{path}"
        merged_headers = {**(headers or {})}

        self._log_request(method, url, params=params, json=json_body, data=data)

        start = time.time()
        try:
            resp = self.session.request(
                method=method.upper(),
                url=url,
                params=params,
                json=json_body,
                data=data,
                files=files,
                headers=merged_headers or None,
                timeout=timeout,
            )
        except requests.Timeout as e:
            logger.error(f"请求超时: {method.upper()} {url} -> {e}")
            raise RequestError(f"Timeout: {method.upper()} {url}") from e
        except requests.ConnectionError as e:
            logger.error(f"连接失败: {method.upper()} {url} -> {e}")
            raise
        except requests.RequestException as e:
            logger.error(f"请求异常: {method.upper()} {url} -> {e}")
            raise RequestError(str(e)) from e

        elapsed = time.time() - start
        self._log_response(resp, elapsed)
        self._attach_allure(method, url, resp, params=params, json=json_body, data=data)

        if expect_status and resp.status_code != expect_status:
            msg = (
                f"状态码异常: 期望 {expect_status} 实际 {resp.status_code} | "
                f"{method.upper()} {url}"
            )
            logger.error(msg + f" | body: {resp.text[:400]}")
            raise RequestError(msg)

        return resp

    # ------------------------------------------------------------------
    # 便捷方法
    # ------------------------------------------------------------------
    def get(self, path, **kw):
        return self.request("GET", path, **kw)

    def post(self, path, json_body=None, **kw):
        return self.request("POST", path, json_body=json_body, **kw)

    def put(self, path, json_body=None, **kw):
        return self.request("PUT", path, json_body=json_body, **kw)

    def delete(self, path, **kw):
        return self.request("DELETE", path, **kw)

    # ------------------------------------------------------------------
    # 业务便捷：提取 Result(code/msg/data) 结构
    # ------------------------------------------------------------------
    def api_result(self, resp: Response) -> Dict[str, Any]:
        """
        解析后端统一返回体 {code, msg, data}
        """
        try:
            body = resp.json()
        except json.JSONDecodeError as e:
            raise RequestError(f"响应体非 JSON: {resp.text[:300]}") from e
        if not isinstance(body, dict) or "code" not in body:
            raise RequestError(f"响应体缺少 code 字段: {body}")
        return body

    @property
    def is_success(self) -> bool:
        """仅用于上次请求结果的简单判定（保留对象状态）"""
        raise NotImplementedError("请使用 api_result()['code'] == '200'")
