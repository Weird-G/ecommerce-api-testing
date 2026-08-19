from typing import Any, Dict

from api.base_api import BaseApi


class GoodsApi(BaseApi):
    PATH = "/goods"

    # selectById 接口用的是 query 参数（不是路径参数），覆盖父类
    def select_by_id(self, goods_id: int) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectById", params={"id": goods_id})
        return self.client.api_result(resp)

    def select_top15(self) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectTop15")
        return self.client.api_result(resp)

    def select_by_type_id(self, type_id: int) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectByTypeId", params={"id": type_id})
        return self.client.api_result(resp)

    def select_by_name(self, name: str) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectByName", params={"name": name})
        return self.client.api_result(resp)

    def select_by_business_id(self, business_id: int) -> Dict[str, Any]:
        resp = self.client.get(f"{self.PATH}/selectByBusinessId", params={"id": business_id})
        return self.client.api_result(resp)

    def recommend(self) -> Dict[str, Any]:
        """UserCF 协同过滤推荐接口"""
        resp = self.client.get(f"{self.PATH}/recommend")
        return self.client.api_result(resp)
