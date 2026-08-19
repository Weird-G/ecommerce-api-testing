from typing import Any, Dict, Optional

from requests import Session

from common.http_client import HttpClient


class BaseApi:
    """
    所有业务 API 的基类
    关键设计：支持注入 HttpClient，从而让多个 API 实例共享同一个登录会话(Session+Token)
    """

    PATH: str = ""

    def __init__(self, client: Optional[HttpClient] = None, session: Optional[Session] = None):
        # 传入顺序：client > session > 默认新建
        if client is not None:
            self.client = client
        else:
            self.client = HttpClient(session=session)

    # ------------------------------------------------------------------
    # 标准 CRUD 模板（对应后端各 Controller 的统一 CRUD）
    # ------------------------------------------------------------------
    def add(self, json_body: Dict[str, Any]) -> Dict[str, Any]:
        resp = self.client.post(f"{self.PATH}/add", json_body=json_body)
        return self.client.api_result(resp)

    def delete_by_id(self, record_id: int) -> Dict[str, Any]:
        resp = self.client.delete(f"{self.PATH}/delete/{record_id}")
        return self.client.api_result(resp)

    def delete_batch(self, ids: list) -> Dict[str, Any]:
        resp = self.client.delete(f"{self.PATH}/delete/batch", json_body=ids)
        return self.client.api_result(resp)

    def update(self, json_body: Dict[str, Any]) -> Dict[str, Any]:
        resp = self.client.put(f"{self.PATH}/update", json_body=json_body)
        return self.client.api_result(resp)

    def select_by_id(self, record_id: int) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectById/{record_id}")
        return self.client.api_result(resp)

    def select_all(self, params: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectAll", params=params)
        return self.client.api_result(resp)

    def select_page(
        self,
        params: Optional[Dict[str, Any]] = None,
        page_num: int = 1,
        page_size: int = 10,
    ) -> Dict[str, Any]:
        q = {"pageNum": page_num, "pageSize": page_size}
        if params:
            q.update(params)
        resp = self.client.get(f"{self.PATH}/selectPage", params=q)
        return self.client.api_result(resp)
