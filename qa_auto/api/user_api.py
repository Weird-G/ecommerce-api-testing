from api.base_api import BaseApi


class UserApi(BaseApi):
    PATH = "/user"


class AdminApi(BaseApi):
    PATH = "/admin"


class BusinessApi(BaseApi):
    PATH = "/business"


class AddressApi(BaseApi):
    PATH = "/address"


class CollectApi(BaseApi):
    PATH = "/collect"


class CommentApi(BaseApi):
    PATH = "/comment"

    def select_by_goods_id(self, goods_id: int) -> dict:
        resp = self.client.get(f"{self.PATH}/selectByGoodsId", params={"id": goods_id})
        return self.client.api_result(resp)


class NoticeApi(BaseApi):
    PATH = "/notice"

    def select_all_public(self) -> dict:
        resp = self.client.get(f"{self.PATH}/selectAll")
        return self.client.api_result(resp)


class TypeApi(BaseApi):
    PATH = "/type"
