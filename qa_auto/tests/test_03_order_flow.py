"""
下单链路 8 个业务场景化测试（集成级）
核心验证点：
- 订单表落库条数（跨商家拆单）
- 商品表 count 销量累加
- 购物车表条目删除
- 订单金额 = num * goodsPrice
- 三表事务一致性（订单+商品+购物车）
"""
import os
from typing import Dict, List

import allure
import pytest
import yaml

from common.assertions import AssertAPI
from common.mysql_client import MySQLClient


_HERE = os.path.dirname(os.path.abspath(__file__))
_DATA = os.path.join(os.path.dirname(_HERE), "data", "order_scenarios.yaml")
with open(_DATA, "r", encoding="utf-8") as f:
    _SCENARIOS = yaml.safe_load(f)["scenarios"]


def _scenario_params():
    return [
        pytest.param(
            s,
            id=f'{s["id"]} - {s["name"]}',
        )
        for s in _SCENARIOS
    ]


@allure.epic("核心业务流")
@allure.feature("下单链路场景化测试")
class TestOrderFlow:

    # 辅助：创建购物车条目 -> 返回带自增 id 的 cart list
    @staticmethod
    def _prepare_cart(
        user_id: int, items: List[Dict], cart_api, mysql: MySQLClient
    ) -> List[Dict]:
        """
        items: [{"goodsId":X,"businessId":X,"num":X,"goodsPrice":X}]
        先清理该用户的购物车，再插入干净的购物车数据
        """
        mysql.execute("DELETE FROM cart WHERE user_id=%s", (user_id,))
        cart_rows = []
        for it in items:
            payload = {
                "userId": user_id,
                "businessId": it["businessId"],
                "goodsId": it["goodsId"],
                "num": it["num"],
            }
            add_result = cart_api.add(payload)
            # 无论 add 成功与否，直接查库拿最新插入的 cart 记录
            rows = mysql.query_all(
                "SELECT id, user_id, business_id, goods_id, num FROM cart "
                "WHERE user_id=%s AND goods_id=%s AND business_id=%s ORDER BY id DESC LIMIT 1",
                (user_id, it["goodsId"], it["businessId"]),
            )
            row = rows[0]
            cart_rows.append(
                {
                    "id": row["id"],
                    "userId": row["user_id"],
                    "businessId": row["business_id"],
                    "goodsId": row["goods_id"],
                    "num": row["num"],
                    "goodsPrice": it["goodsPrice"],
                }
            )
        return cart_rows

    # 辅助：取商品销量快照
    @staticmethod
    def _snapshot_sales(mysql: MySQLClient, goods_ids: List[int]) -> Dict[int, int]:
        snap = {}
        for gid in goods_ids:
            row = mysql.query_one("SELECT count FROM goods WHERE id=%s", (gid,))
            snap[gid] = int(row["count"]) if row and row["count"] is not None else 0
        return snap

    @pytest.mark.order_flow
    @pytest.mark.parametrize("scenario", _scenario_params())
    @allure.title("{scenario[id]} {scenario[name]}")
    def test_order_scenario(
        self,
        scenario,
        user_client,
        cart_api_user,
        orders_api_user,
        mysql: MySQLClient,
        assert_api: AssertAPI,
        user_login_info,
    ):
        # 跳过：如果用户登录失败
        if user_login_info.get("code") != "200":
            pytest.skip("用户登录失败，跳过下单场景")

        user_id = (user_login_info.get("data") or {}).get("id")
        if not user_id:
            pytest.skip("登录响应缺少用户id")

        items = scenario["cart_items"]
        goods_ids = sorted({it["goodsId"] for it in items})
        business_ids = sorted({it["businessId"] for it in items})

        # ================================================================
        # Step 1: 构造干净购物车 & 拍商品销量快照 & 拍购物车id快照 & 拍订单max(id)
        # ================================================================
        with allure.step("Step1 - 准备测试数据: 清理+重建购物车 & 销量快照"):
            carts = self._prepare_cart(user_id, items, cart_api_user, mysql)
            cart_ids_before = [c["id"] for c in carts]
            sales_before = self._snapshot_sales(mysql, goods_ids)
            # 拍订单表 max(id) 边界，下单后取 id > max 即本场景新增订单
            # 避免依赖后端秒级时间戳 orderId（同秒内多场景共享同一orderId 的冲突）
            max_row = mysql.query_one("SELECT IFNULL(MAX(id), 0) AS m FROM orders")
            order_id_boundary = int(max_row["m"]) if max_row else 0
            allure.attach(
                f"购物车条目: {carts}\n销量快照: {sales_before}\n订单max(id)边界: {order_id_boundary}",
                name="测试前数据",
                attachment_type=allure.attachment_type.JSON,
            )

        # ================================================================
        # Step 2: 调用下单接口
        # ================================================================
        with allure.step("Step2 - 调用 /orders/add 下单"):
            # 优先用配置的 addressId
            from config import TEST_DATA
            addr_id = TEST_DATA["default_address_id"]
            order_result = orders_api_user.create_from_cart(
                user_id=user_id,
                address_id=addr_id,
                cart_data=carts,
            )
            assert_api.assert_success(order_result, "下单接口响应应为成功")

        # ================================================================
        # Step 3: 订单落库条数校验
        # ================================================================
        with allure.step("Step3 - 验证订单表: 拆单/条数/businessId"):
            # 用 id > max 边界精确取本场景新增的订单（避免秒级 orderId 冲突）
            batch = mysql.query_all(
                "SELECT * FROM orders WHERE id > %s ORDER BY id ASC",
                (order_id_boundary,),
            )

            expect_count = scenario.get("expect_order_count")
            if expect_count is not None:
                assert len(batch) == expect_count, (
                    f"订单条数不符: 期望{expect_count}, 实际{len(batch)}, batch={batch}"
                )

            # 跨商家拆单：businessId 集合应覆盖
            if "expect_business_ids" in scenario:
                actual_biz = sorted({o["business_id"] for o in batch})
                assert actual_biz == sorted(scenario["expect_business_ids"]), (
                    f"拆单businessId不符: 期望{scenario['expect_business_ids']}, 实际{actual_biz}"
                )

        # ================================================================
        # Step 4: 销量累加校验
        # ================================================================
        if "expect_sales_delta" in scenario:
            with allure.step("Step4 - 验证商品表: 销量(count)累加"):
                sales_after = self._snapshot_sales(mysql, goods_ids)
                allure.attach(
                    f"Before: {sales_before}\nAfter: {sales_after}",
                    name="销量前后对比",
                    attachment_type=allure.attachment_type.JSON,
                )
                for gid_str, delta in scenario["expect_sales_delta"].items():
                    gid = int(gid_str)
                    actual = sales_after.get(gid, 0) - sales_before.get(gid, 0)
                    assert actual == delta, (
                        f"商品#{gid} 销量增量错误: 期望+{delta}, 实际+{actual}"
                        f" (before={sales_before.get(gid)}, after={sales_after.get(gid)})"
                    )

        # ================================================================
        # Step 5: 购物车删除校验
        # ================================================================
        if scenario.get("expect_cart_cleared"):
            with allure.step("Step5 - 验证购物车表: 对应条目已删除"):
                for cid in cart_ids_before:
                    row = mysql.query_one("SELECT id FROM cart WHERE id=%s", (cid,))
                    assert row is None, f"购物车#{cid} 未被删除: {row}"

        # ================================================================
        # Step 6: 订单金额 = num * goodsPrice
        # ================================================================
        if "expect_total_price" in scenario:
            with allure.step("Step6 - 验证订单金额正确性"):
                sum_price = sum(float(o["price"] or 0) for o in batch)
                assert abs(sum_price - scenario["expect_total_price"]) < 1e-6, (
                    f"订单金额不符: 期望{scenario['expect_total_price']}, 实际{sum_price}"
                )

        # ================================================================
        # Step 7: 三表一致性汇总（显式）
        # ================================================================
        if scenario.get("expect_three_table_consistency"):
            with allure.step("Step7 - 三表(订单/商品/购物车)事务一致性汇总"):
                # 1) 订单记录条数 = 输入 cart 条目数
                assert len(batch) == len(carts), (
                    f"订单条数={len(batch)} != 购物车条目数={len(carts)}"
                )
                # 2) 每个条目商品 count 都累加
                for gid in goods_ids:
                    delta_exp = sum(
                        it["num"] for it in scenario["cart_items"] if it["goodsId"] == gid
                    )
                    actual = sales_after.get(gid, 0) - sales_before.get(gid, 0)
                    assert actual == delta_exp, f"商品{gid}销量不一致"
                # 3) 购物车清空
                rows = mysql.query_all(
                    "SELECT id FROM cart WHERE id IN (%s)"
                    % ",".join(["%s"] * len(cart_ids_before)),
                    tuple(cart_ids_before),
                )
                assert len(rows) == 0, f"仍有购物车残留: {rows}"
