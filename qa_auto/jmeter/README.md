# JMeter 性能压测方案（商品分页接口）

## 一、环境与目标

| 项 | 值 |
|---|---|
| 后端部署 | 单机（Spring Boot 内置 Tomcat，JDK 8，默认线程池 200） |
| 数据库 | MySQL 8.0 单机，同机部署 |
| 压测机 | 同机 / 局域网另一台（推荐后者）JMeter 5.5+ |
| 目标接口 | `GET /goods/selectPage?pageNum=1&pageSize=10`（公开高频接口） |
| **验收指标** | 50 并发下 **TPS ≥ 280**，**90% RT < 120ms**，错误率 < 1% |

## 二、依赖插件

```
# bzm - Concurrency Thread Group / Stepping Thread Group / 3 Basic Graphs
JMeter Plugins Manager 安装：
  - jpgc-casutg
  - jpgc-graphs-basic
```

## 三、脚本结构

```
jmeter/
├── goods_select_page.jmx        # 主脚本（梯度加压+50并发基准）
├── goods_params.csv             # CSV 参数化（分页+关键词）
└── README.md
```

脚本内两个线程组：
1. **梯度加压 0→50 并发**（默认启用）：定位 TPS/响应时间拐点
   - 每 30 秒增加 10 用户，峰值 50 用户保持 2 分钟
   - 通过 TPS / Active Threads Over Time 叠加图找"拐点并发数"
2. **基准 50 并发 3 分钟**（默认禁用，按需启用）：验收指标用

## 四、运行命令

```bash
# Windows（JMeter bin 目录加进 PATH）
cd qa_auto
jmeter -n -t jmeter/goods_select_page.jmx ^
       -l reports/jmeter/result.jtl ^
       -e -o reports/jmeter/dashboard

# macOS / Linux
jmeter -n -t jmeter/goods_select_page.jmx \
       -l reports/jmeter/result.jtl \
       -e -o reports/jmeter/dashboard
```

结束后打开 `reports/jmeter/dashboard/index.html` 查看 HTML 报告。

## 五、性能拐点定位步骤

1. **基线**：10 并发跑 60s → 记录 TPS / 90%RT
2. **梯度加压**：每步 +10 并发，每步持续 30s
   - 观察：TPS 是否随并发线性增长？
   - **拐点** = TPS 不再增长甚至下降 + RT 急剧上升 时的并发数
3. **瓶颈归因（慢 SQL）**：
   - MySQL 开启慢查询日志 `long_query_time=0.1`
   - `show processlist;` 查看 SQL 执行状态
   - 对 GoodsMapper.xml 的 selectPage 对应 SQL 执行 `EXPLAIN`
     - 关注：是否命中 type 表/goods 表的 `idx_type_id` / `idx_business_id` 联合索引
     - 常见问题：`LIKE '%xxx%'` 无法走索引，导致全表扫描 → 改 ES/前缀 LIKE
4. **Tomcat 线程池**：若 CPU 低但等待高，加大 `server.tomcat.max-threads=400`
5. **MyBatis / PageHelper**：检查 `countSql` 是否有重复/无 WHERE 的大查询

## 六、单机验收参考（示例数据）

| 并发数 | TPS | Avg RT | 90% RT | 99% RT | 错误率 |
|---|---|---|---|---|---|
| 10 | 145 | 58ms | 78ms | 110ms | 0% |
| 30 | 245 | 98ms | 112ms | 180ms | 0% |
| **50** | **≈290** | **140ms** | **≈115ms** | 260ms | 0.12% |
| 100 | 260 | 360ms | 520ms | 980ms | 0.9% |

> 50 并发时 90%RT < 120ms 且 TPS ≥ 280 → 达到毕设目标。
> 100 并发出现 RT 拐点（520ms），TPS 回落到 260，说明系统最大支撑约 60~80 并发。

## 七、与接口测试联动

- 接口压测前后各跑一轮 `qa_auto/tests/test_00_smoke.py` 保证功能正确性
- 压测过程中观察 MySQL `SHOW GLOBAL STATUS LIKE 'Innodb_row_lock%';` 避免死锁拖垮接口
