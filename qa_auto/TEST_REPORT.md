# 电商后台管理系统 · 接口自动化测试报告

> 测试对象：基于 SpringBoot 2.5.9 + Vue2 + MySQL 的电商系统（三角色权限 / 商品订单 / UserCF 推荐）
> 技术栈：Python · Pytest · Requests · Allure · JUnit5 · JaCoCo · GitHub Actions


---

## 一、执行结果总览

| 测试层 | 框架 | 用例数 | 通过 | 失败 | 跳过 | 耗时 | 结果 |
| :-- | :-- | :--: | :--: | :--: | :--: | :--: | :--: |
| 接口自动化（黑盒） | Pytest + Requests + Allure | 123 | 123 | 0 | 0 | 9.73s | ✅ 全通过 |
| 推荐算法（白盒） | JUnit5 + JaCoCo | 17 | 17 | 0 | 0 | ~0.16s | ✅ 全通过 |
| **合计** | — | **140** | **140** | **0** | **0** | — | **✅ 100%** |

> 接口用例 123 条，覆盖简历所述「80+」并显著超出；下单链路 8 个业务场景（OS_001~OS_008）全部通过，含三表事务一致性校验。

---

## 二、简历四点实证对照

### 1）三层自动化测试架构（Pytest + Requests）

- **接口封装层** [`api/`](api)：`base_api.py` 统一封装请求；`goods_api / cart_api / orders_api / user_api / web_api` 按模块封装。
- **用例层** [`tests/`](tests)：`test_00_smoke` ~ `test_05_register_login`，6 个测试文件。
- **数据驱动层** [`data/`](data)：`order_scenarios.yaml`（8 订单场景）、`permission_matrix.yaml`（权限矩阵）。
- **统一请求工具** [`common/http_client.py`](common/http_client.py)：支持超时重试（`retry_times: 3`）、异常分类捕获。
- **Allure 步骤日志**：[`tests/conftest.py`](tests/conftest.py) 中 `pytest_runtest_makereport` 钩子自动附加失败上下文。
- **多角色 JWT 会话**：`conftest.py` 的 `_logged_client_map` session 级 fixture 统一登录 ADMIN/BUSINESS/USER 三角色，**消除重复登录**，配合参数化实现权限矩阵测试。

### 2）核心业务流场景化测试（8 场景 + 落库校验）

[`data/order_scenarios.yaml`](data/order_scenarios.yaml) 定义 8 个下单场景，[`tests/test_03_order_flow.py`](tests/test_03_order_flow.py) 执行并通过：

| 场景 | 名称 | 关键校验 |
| :-- | :-- | :-- |
| OS_001 | 单商品下单 | 拆单后 1 条订单 |
| OS_002 | 多商品合并下单（同商家） | 共享 orderId，销量累加 |
| OS_003 | 跨商家拆单 | businessId=[9,16] 分别拆单 |
| OS_004 | 数量>1 销量累加 | num=5 → count+5 |
| OS_005 | 下单后购物车条目删除 | cart 表对应 id 被删 |
| OS_006 | 订单金额计算 | price = num×goodsPrice 落库 |
| OS_007 | 重复加购去重下单 | 按实际 cart 逐条插入 |
| OS_008 | **三表事务一致性** | 订单表+商品销量+购物车删除一致 |

> 通过 [`common/mysql_client.py`](common/mysql_client.py) 直接查询 `xm_shopping_manager` 库，验证订单表、商品表、购物车表三表事务一致性。运用等价类划分与边界值分析覆盖参数边界与状态流转。

### 3）CI/CD 流水线集成（GitHub Actions）

[`.github/workflows/api-test.yml`](../.github/workflows/api-test.yml) 双 Job 流水线：

- **Job1 `api-test`**：MySQL 8.0 service 容器 → 导入 init.sql → 构建/启动 Spring Boot → 健康等待 → Pytest + Allure → 归档到 `gh-pages`（`peaceiris/actions-gh-pages`）。
- **Job2 `java-unit`**：`mvn test jacoco:report` → 上传 JaCoCo 报告为 artifact。
- 触发：`push`（master/main/dev）+ `pull_request` + `workflow_dispatch`，**提交即验证**。

### 4）推荐算法白盒测试（JUnit5 + JaCoCo）

针对 UserCF 协同过滤核心 [`springboot/src/main/java/com/example/utils/`](../springboot/src/main/java/com/example/utils/)：

- [`UserCFTest.java`](../springboot/src/test/java/com/example/utils/UserCFTest.java)：5 个用例，覆盖冷启动、无邻居、典型推荐、无新商品可推、多邻居同最大相似度。
- [`CoreMathTest.java`](../springboot/src/test/java/com/example/utils/CoreMathTest.java)：12 个用例，**皮尔森相关系数边界场景全覆盖**：

| 边界场景 | 用例 | 期望 |
| :-- | :-- | :-- |
| 空数组 | `emptyLists_returnsZero` | r=0 |
| 单元素 | `singleElement_returnsZero` | r=0 |
| 完全正相关 | `perfectPositiveCorrelation` | r=+1.0 |
| 完全负相关 | `perfectNegativeCorrelation` | r=-1.0 |
| 零方差分母（X 全相同） | `zeroVarianceX_returnsZero` | 不抛异常，r=0 |
| 零方差分母（Y 全相同） | `zeroVarianceY_returnsZero` | 不抛异常，r=0 |
| 零方差分母（X&Y 全相同） | `zeroVarianceBoth_returnsZero` | r=0 |
| 无关向量 | `noCorrelation_nearZero` | r≈0 |

---

## 三、代码覆盖率（JaCoCo）

> 覆盖率对象：推荐算法模块 `com.example.utils`（UserCF + CoreMath），由 `jacoco-maven-plugin 0.8.11` 生成。

| 类 | 行覆盖 | 指令覆盖 | 分支覆盖 |
| :-- | :--: | :--: | :--: |
| CoreMath | 32/36 = **88.9%** | 199/218 = **91.3%** | 11/14 = 78.6% |
| UserCF | 12/14 = **85.7%** | 82/88 = **93.2%** | 4/6 = 66.7% |
| **推荐模块合计** | **44/50 = 88.0%** | **281/306 = 91.8%** | 15/20 = 75.0% |

> 推荐算法模块行覆盖率 **88.0%**、指令覆盖率 **91.8%**，均达到并超过简历所述「85%」。完整 HTML 报告：`springboot/target/site/jacoco/index.html`。

---

## 四、测试用例分布（123 接口用例）

| 测试文件 | 用例数 | 覆盖范围 |
| :-- | :--: | :-- |
| test_00_smoke.py | 13 | 冒烟：hello、三角色登录、登录异常、白名单匿名访问 |
| test_01_auth_permission.py | 80 | 三角色权限矩阵（接口 × 角色 × 期望，含 401 拒绝校验） |
| test_02_goods_crud.py | 14 | 商品分页/条件查询/新增 + 价格与数量边界值 |
| test_03_order_flow.py | 8 | 下单链路 8 场景（落库校验） |
| test_04_cart_crud.py | 4 | 购物车加购 + 用户隔离校验 + 数量边界 |
| test_05_register_login.py | 4 | 注册→登录→改密 + 参数缺失 |

> 用例数由 `pytest --collect-only` 统计，合计 **123** 条。

---

## 五、报告产物与本地复现

### 产物路径
- Allure HTML 报告：[`qa_auto/reports/allure-report/index.html`](reports/allure-report/index.html)
- Allure 原始结果：[`qa_auto/reports/allure-results/`](reports/allure-results/)
- JaCoCo 覆盖率报告：[`springboot/target/site/jacoco/index.html`](../springboot/target/site/jacoco/index.html)
- Surefire 测试报告：`springboot/target/surefire-reports/`
- 运行日志：[`qa_auto/logs/`](logs/)

### 本地复现步骤
```bash
# 前置：MySQL(3306, root/root, 库 xm_shopping_manager) + 后端已起在 localhost:9090

# 1) Python 接口测试 + Allure
cd qa_auto
venv\Scripts\python -m pytest --tb=short --no-header           # 跑全量
allure generate ./reports/allure-results -o ./reports/allure-report --clean

# 2) Java 单元测试 + JaCoCo
cd ..\springboot
mvn -B test jacoco:report
```

### CI 复现
推送代码到 master/main/dev 分支即自动触发 GitHub Actions，Allure 报告归档至 `gh-pages` 分支，JaCoCo 报告作为 artifact 上传。

---

## 六、本次执行修正记录

- `CoreMathTest.noCorrelation_nearZero` 原测试数据 `(1,2,3,4)` vs `(4,3,1,2)` 经计算实为强负相关（r=-0.8），与「无关向量应接近 0」语义矛盾。已修正为理论相关系数 r=0 的向量 `(1,2,3,4)` vs `(2,4,1,3)`，修正后 17/17 全通过。
