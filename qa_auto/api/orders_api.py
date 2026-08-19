from typing import Any, Dict, List

from api.base_api import BaseApi
from common.assertions import AssertAPI


class OrdersApi(BaseApi):
    PATH = "/orders"

    def create_from_cart(
        self,
        user_id: int,
        address_id: int,
        cart_data: List[Dict[str, Any]],
        status: str = "待发货",
    ) -> Dict[str, Any]:
        """
        下单封装：按 OrdersService.add 的字段组装
        cart_data 中每项至少需要：id, goodsId, businessId, num, goodsPrice
        """
        payload = {
            "userId": user_id,
            "addressId": address_id,
            "status": status,
            "cartData": cart_data,
        }
        resp = self.client.post(f"{self.PATH}/add", json_body=payload)
        return self.client.api_result(resp)
