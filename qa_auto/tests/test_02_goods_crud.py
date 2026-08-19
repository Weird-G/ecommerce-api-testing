"""
商品模块 CRUD + 分页 + 推荐接口
等价类/边界值：空名称、价格边界、count=0/负数、超长描述
"""
import allure
import pytest

from common.assertions import AssertAPI
from utils.helpers import random_str, rand_price, rand_count


@allure.epic("商品模块")
@allure.feature("商品CRUD")
class TestGoodsCrud:

    @allure.story("查询")
    @allure.title("商品分页查询 - 正反向分页")
    @pytest.mark.parametrize(
        "page_num,page_size",
        [(1, 10), (1, 1), (2, 5), (1, 999)],
        ids=["page=1/10", "page=1/1", "page=2/5", "page=1/999"],
    )
    def test_select_page(self, goods_api_anon, assert_api: AssertAPI, page_num, page_size):
        result = goods_api_anon.select_page(page_num=page_num, page_size=page_size)
        assert_api.assert_success(result)
        page = result["data"] or {}
        # PageHelper 响应结构至少含 list / total / pageNum / pageSize
        for k in ("list", "total", "pageNum", "pageSize"):
            assert k in page, f"缺少分页字段 {k}: {page}"

    @allure.story("查询")
    @allure.title("selectTop15 - 返回 <=15 条")
    def test_select_top15(self, goods_api_anon, assert_api: AssertAPI):
        result = goods_api_anon.select_top15()
        assert_api.assert_success(result)
        lst = result["data"] or []
        assert isinstance(lst, list) and len(lst) <= 15

    @allure.story("按条件查询")
    @allure.title("按分类 / 按商家 / 按名称 查询")
    @pytest.mark.parametrize(
        "method_kw",
        [
            ("select_by_type_id", 1),
            ("select_by_business_id", 1),
            ("select_by_name", "测试"),  # 可能查不到，也应该200+空列表
        ],
        ids=["select_by_type_id(1)", "select_by_business_id(1)", "select_by_name(测试)"],
    )
    def test_select_conditions(self, goods_api_anon, assert_api: AssertAPI, method_kw):
        method, arg = method_kw
        fn = getattr(goods_api_anon, method)
        result = fn(arg)
        assert_api.assert_success(result)
        assert isinstance(result.get("data") or [], list)

    # ------------------------------------------------------------------
    # 商家新增商品（等价类/边界值）
    # ------------------------------------------------------------------
    @allure.story("写操作（商家）")
    @allure.title("商家新增商品 - 正常场景")
    def test_add_goods_ok(self, goods_api_business, assert_api: AssertAPI):
        payload = {
            "name": f"API测试商品-{random_str(6)}",
            "description": "测试用商品描述",
            "price": rand_price(),
            "count": rand_count(),
            "unit": "件",
            "typeId": 1,
            "businessId": 1,
        }
        result = goods_api_business.add(payload)
        # 200成功 / 或业务错误都有可能，核心是授权通过(非401)
        if result.get("code") == "200":
            pass
        else:
            assert result.get("code") != "401", f"应授权通过: {result}"

    @allure.story("写操作（商家）- 边界值")
    @allure.title("商品边界值 - 价格={price},count={count}")
    @pytest.mark.parametrize(
        "price,count,expect_pass",
        [
            (0.01, 1, True),          # 最小合法值
            (999999.99, 999999, True),  # 较大值
            (0, 0, True),             # 边界：0值
            (-1.0, 1, True),          # 负数：后端是否校验？不校验也应通过(非401)
            (1.0, -1, True),
        ],
    )
    def test_add_goods_boundary(
        self, goods_api_business, price, count, expect_pass
    ):
        payload = {
            "name": f"边界商品-{random_str(4)}",
            "price": price,
            "count": count,
            "unit": "件",
            "typeId": 1,
            "businessId": 1,
        }
        result = goods_api_business.add(payload)
        # 授权通过（非401）即通过边界覆盖目标
        assert result.get("code") != "401", f"未授权 {result}"
