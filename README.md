# 电商后台管理系统 · 接口自动化测试体系

> 独立设计与落地 | 2024.03 - 2024.06

[![Pytest](https://img.shields.io/badge/Pytest-7.4.3-green)](https://docs.pytest.org/)
[![Requests](https://img.shields.io/badge/Requests-2.31.0-blue)](https://requests.readthedocs.io/)
[![Allure](https://img.shields.io/badge/Allure-2.13.2-orange)](https://allurereport.org/)
[![Java](https://img.shields.io/badge/JUnit5-5.8.2-red)](https://junit.org/junit5/)
[![JaCoCo](https://img.shields.io/badge/JaCoCo-0.8.11-cyan)](https://www.jacoco.org/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI-blue)](https://github.com/features/actions)

## 📖 项目简介

基于 SpringBoot2.5.9 + Vue2 + MySQL 的电商系统，包含三角色权限、商品订单、UserCF 推荐模块。本仓库专注于**测试体系的设计与落地**，展示了从黑盒接口自动化到白盒算法单元测试的完整实践。

## ✨ 核心亮点

### 1. 三层自动化测试架构
基于 Pytest + Requests 搭建「API 接口封装层 / 用例层 / 数据驱动层」三层架构：
- **统一请求工具**：支持超时重试（3次）、异常分类捕获与 Allure 步骤日志自动记录
- **多角色 JWT 管理**：通过 `pytest.fixture` 管理 ADMIN/BUSINESS/USER 三角色会话生命周期
- **参数化权限矩阵**：配合参数化实现三角色权限矩阵测试，**用例编写效率提升约 60%**

### 2. 核心业务流场景化测试
针对下单链路设计 **8 个业务场景**，覆盖：
- 单商品下单 / 多商品合并下单（同商家）/ 跨商家拆单
- 数量>1 销量累加 / 下单后购物车删除 / 订单金额计算
- **三表事务一致性校验**（订单表 + 商品表 + 购物车表）

累计设计 **123 接口测试用例**，运用等价类划分与边界值分析覆盖参数边界与状态流转。

### 3. CI/CD 流水线集成
接入 GitHub Actions 实现：
- 代码提交自动触发测试，支持多分支执行
- Allure 报告自动归档至 `gh-pages` 分支
- 全量用例执行耗时约 **10 秒**，实现提交即验证的快速反馈机制

### 4. 推荐算法白盒测试
针对系统核心的 UserCF 协同过滤 Java 模块，使用 JUnit5 编写单元测试：
- **覆盖皮尔森相关系数计算的边界场景**：空数组、单元素、完全正/负相关、零方差分母
- 配合 JaCoCo 生成覆盖率报告，**代码覆盖率达 88%**

## 🏗️ 项目结构

```
qa_auto/
├── api/                    # [接口封装层] 按模块封装 API
│   ├── base_api.py        #       基础请求封装
│   ├── goods_api.py       #       商品接口
│   ├── cart_api.py        #       购物车接口
│   ├── orders_api.py      #       订单接口
│   ├── user_api.py        #       用户/权限接口
│   └── web_api.py         #       登录/注册接口
├── common/                # [公共工具层]
│   ├── http_client.py     #       HttpClient（重试/日志）
│   ├── mysql_client.py    #       MySQL 落库校验
│   └── assertions.py      #       自定义断言
├── config/                # [配置层]
│   └── config.yaml        #       环境/账号配置
├── data/                  # [数据驱动层]
│   ├── order_scenarios.yaml  #   8个订单场景数据
│   └── permission_matrix.yaml #  三角色权限矩阵
├── tests/                 # [用例层]
│   ├── conftest.py        #       Fixture 定义
│   ├── test_00_smoke.py   #       冒烟测试
│   ├── test_01_auth_permission.py # 权限矩阵测试
│   ├── test_02_goods_crud.py #    商品CRUD测试
│   ├── test_03_order_flow.py  #   订单流程测试(8场景)
│   ├── test_04_cart_crud.py   #   购物车测试
│   └── test_05_register_login.py # 注册登录测试
├── jmeter/                # [性能测试] JMeter 脚本
├── pytest.ini             # Pytest 配置
└── requirements.txt       # Python 依赖
```

## 🚀 快速开始

### 环境要求
- Python 3.9+
- JDK 8+
- Maven 3.8+
- MySQL 8.0+（需导入项目数据库 `xm_shopping_manager`）

### 运行接口测试

```bash
# 1. 进入测试目录
cd qa_auto

# 2. 安装依赖
pip install -r requirements.txt

# 3. 运行全量用例
pytest --tb=short -v

# 4. 查看 Allure 报告
allure generate ./reports/allure-results -o ./reports/allure-report --clean
allure open ./reports/allure-report
```

### 运行 Java 单元测试

```bash
# 进入后端项目根目录
cd springboot

# 运行单元测试 + 生成 JaCoCo 报告
mvn test jacoco:report

# 报告位置: target/site/jacoco/index.html
```

## 📊 测试结果

### 接口自动化测试
- **用例总数**：123
- **通过率**：100%
- **执行耗时**：9.73 秒

### 核心白盒测试覆盖

| 测试模块 | 用例数 | 行覆盖率 | 指令覆盖率 |
| :-- | :--: | :--: | :--: |
| CoreMath (皮尔森系数) | 12 | 88.9% | 91.3% |
| UserCF (协同过滤) | 5 | 85.7% | 93.2% |
| **推荐算法合计** | **17** | **88.0%** | **91.8%** |

### 订单场景测试
| 场景 | 名称 | 状态 |
| :-- | :-- | :--: |
| OS_001 | 单商品下单 | ✅ |
| OS_002 | 多商品合并下单（同商家） | ✅ |
| OS_003 | 跨商家拆单 | ✅ |
| OS_004 | 数量>1 销量累加正确 | ✅ |
| OS_005 | 下单后购物车条目被删除 | ✅ |
| OS_006 | 订单金额计算正确性 | ✅ |
| OS_007 | 重复加购去重后的下单 | ✅ |
| OS_008 | 三表事务一致性 | ✅ |

## 🔑 核心技术点

### Fixture 管理多角色 JWT
```python
@pytest.fixture(scope="session")
def _logged_client_map():
    result = {}
    for role_key in ("admin", "business", "user"):
        client = HttpClient()
        login_resp = WebApi(client).login_as(role_key)
        result[role_key] = {"client": client, "login": login_resp}
    yield result
    # teardown: 清除 token
```

### 数据驱动下单场景
```yaml
# data/order_scenarios.yaml
scenarios:
  - id: "OS_003"
    name: "跨商家拆单"
    cart_items:
      - goodsId: 11
        businessId: 9
        num: 1
      - goodsId: 10
        businessId: 16
        num: 1
    expect_order_count: 2
    expect_three_table_consistency: true
```

## 📁 完整报告

详细测试报告请查看：[TEST_REPORT.md](./qa_auto/TEST_REPORT.md)

## 📝 备注

本仓库仅包含测试代码。完整项目（SpringBoot 后端 + Vue 前端）需本地运行时自行搭建。CI 流水线配置可参考 [`.github/workflows/api-test.yml`](.github/workflows/api-test.yml)。
