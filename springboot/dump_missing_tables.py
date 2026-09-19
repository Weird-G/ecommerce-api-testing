"""
从本地 MySQL 把 init.sql 缺失的表数据 dump 出来，追加到 init.sql 的 data 段。
避免 mysqldump 在 PowerShell 下的 stderr 混入问题。
"""
import pymysql
import sys
from pathlib import Path

# 本地 MySQL 连接（跟 config.yaml 对齐）
conn = pymysql.connect(
    host="localhost",
    port=3306,
    user="root",
    password="root",
    database="xm_shopping_manager",
    charset="utf8mb4",
)

# init.sql 现有 data 段已包含的表
EXISTING = {"admin", "business", "user", "type"}

# 需要补充的表（下单链路 + 业务相关）
# 顺序：先无外键依赖的表，最后 orders
MISSING_TABLES = [
    "address",      # 下单链路必备（addressId）
    "goods",        # 下单链路必备（goodsId）
    "cart",         # 下单链路必备（cartId）
    "collect",      # 收藏
    "comment",      # 评论
    "latest",       # 最近浏览
    "notice",       # 公告
    "orders",       # 订单（最后）
]

output_path = Path(__file__).parent / "init_missing_data.sql"

def escape_value(v):
    """把 Python 值转成 SQL 字面量"""
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return str(v)
    if isinstance(v, bytes):
        return "0x" + v.hex()
    # 字符串：转义单引号、反斜杠、换行
    s = str(v)
    s = s.replace("\\", "\\\\")
    s = s.replace("'", "\\'")
    s = s.replace("\n", "\\n")
    s = s.replace("\r", "\\r")
    return f"'{s}'"

def dump_table(cursor, table):
    """生成单张表的 INSERT 语句"""
    out = []
    out.append("")
    out.append("--")
    out.append(f"-- Dumping data for table `{table}`")
    out.append("--")
    out.append("")
    out.append(f"LOCK TABLES `{table}` WRITE;")
    out.append(f"/*!40000 ALTER TABLE `{table}` DISABLE KEYS */;")

    cursor.execute(f"SELECT * FROM `{table}`")
    rows = cursor.fetchall()
    if not rows:
        out.append(f"-- {table}: no rows")
    else:
        col_names = [d[0] for d in cursor.description]
        col_list = ", ".join(f"`{c}`" for c in col_names)
        # 一次插多行，每 100 行一批
        BATCH = 100
        for i in range(0, len(rows), BATCH):
            batch = rows[i:i+BATCH]
            values_list = []
            for row in batch:
                vals = ", ".join(escape_value(v) for v in row)
                values_list.append(f"({vals})")
            out.append(f"INSERT INTO `{table}` ({col_list}) VALUES {','.join(values_list)};")

    out.append(f"/*!40000 ALTER TABLE `{table}` ENABLE KEYS */;")
    out.append("UNLOCK TABLES;")
    return "\n".join(out)

def main():
    cursor = conn.cursor()
    chunks = []
    chunks.append("")
    chunks.append("-- ============================================================")
    chunks.append("-- 补充 dump：缺失表的数据（由 dump_missing_tables.py 生成）")
    chunks.append("-- ============================================================")

    for table in MISSING_TABLES:
        try:
            chunk = dump_table(cursor, table)
            chunks.append(chunk)
            print(f"[OK] {table}: dumped")
        except pymysql.Error as e:
            print(f"[FAIL] {table}: {e}", file=sys.stderr)
            chunks.append(f"-- {table}: dump failed ({e})")

    chunks.append("")
    chunks.append("/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;")
    chunks.append("/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;")
    chunks.append("/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;")
    chunks.append("/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;")
    chunks.append("/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;")
    chunks.append("/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;")
    chunks.append("/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;")
    chunks.append("/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;")
    chunks.append("")
    chunks.append("-- Dump completed (supplement)")

    content = "\n".join(chunks)
    # Python 3.9 Path.write_text 不支持 newline 参数，用 open 替代
    with open(output_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(content)
    print(f"\n[WRITE] {output_path} ({len(content)} bytes)")

    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
