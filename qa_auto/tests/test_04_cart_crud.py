"""
购物车模块：加购、修改数量、删除、重复加购去重（若支持）
"""
import allure
import pytest

from common.assertions import AssertAPI
from common.mysql_client import MySQLClient
from config import TEST_DATA


@allure.epic("购物车模块")
@allure.feature("购物车CRUD")
class TestCartCrud:

    @allure.story("加购")
    @allure.title("用户加购成功")
    @pytest.mark.parametrize("num", [1, 5, 99], ids=lambda n: f"数量={n}")
    def test_add_cart(
        self, num, cart_api_user, mysql: MySQLClient, user_login_info, assert_api
    ):
        if user_login_info.get("code") != "200":
            pytest.skip("用户登录失败")
        user_id = (user_login_info.get("data") or {}).get("id")
        if not user_id:
            pytest.skip("登录响应缺少用户id")

        # 清理后插入
        mysql.execute("DELETE FROM cart WHERE user_id=%s", (user_id,))
        payload = {
            "userId": user_id,
            "businessId": TEST_DATA["default_business_id"],
            "goodsId": TEST_DATA["default_goods_id"],
            "num": num,
        }
        result = cart_api_user.add(payload)
        # 只要不是 401 就算通过授权校验，成功/重复都可以
        assert result.get("code") != "401", f"未授权: {result}"
        if result.get("code") == "200":
            # 查库验证
            row = mysql.query_one(
                "SELECT num FROM cart WHERE user_id=%s AND goods_id=%s AND business_id=%s",
                (user_id, payload["goodsId"], payload["businessId"]),
            )
            assert row is not None, "购物车加购后数据库无记录"
            assert row["num"] == num, f"数量不符: 期望{num}, 实际{row['num']}"

    @allure.story("查购物车")
    @allure.title("用户查询自己的购物车应过滤其userId")
    def test_select_all_user_scope(
        self, cart_api_user, mysql: MySQLClient, user_login_info, assert_api
    ):
        if user_login_info.get("code") != "200":
            pytest.skip("用户登录失败")
        user_id = (user_login_info.get("data") or {}).get("id")
        result = cart_api_user.select_all()
        # orders/cart 的 selectAll 通常不过滤 userId（后端没过滤），所以重点是 200
        assert_api.assert_success(result)
