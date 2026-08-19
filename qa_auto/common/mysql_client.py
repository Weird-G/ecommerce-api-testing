from typing import Any, Dict, List, Optional, Tuple

import pymysql
from dbutils.pooled_db import PooledDB
from loguru import logger

from config import MYSQL_CONFIG


class MySQLClient:
    """
    轻量 MySQL 客户端（基于 DBUtils 连接池）
    用于测试断言落库数据正确性。
    """

    _pool: Optional[PooledDB] = None

    @classmethod
    def _get_pool(cls) -> PooledDB:
        if cls._pool is None:
            cls._pool = PooledDB(
                creator=pymysql,
                maxconnections=8,
                mincached=2,
                blocking=True,
                host=MYSQL_CONFIG["host"],
                port=MYSQL_CONFIG["port"],
                user=MYSQL_CONFIG["user"],
                password=MYSQL_CONFIG["password"],
                database=MYSQL_CONFIG["database"],
                charset=MYSQL_CONFIG["charset"],
                cursorclass=pymysql.cursors.DictCursor,
            )
        return cls._pool

    def execute(self, sql: str, params: Optional[Tuple[Any, ...]] = None) -> int:
        """执行 DML（INSERT/UPDATE/DELETE），返回受影响行数"""
        pool = self._get_pool()
        conn = pool.connection()
        try:
            with conn.cursor() as cur:
                logger.debug(f"[SQL] {sql} | params={params}")
                rows = cur.execute(sql, params or ())
                conn.commit()
                return rows
        except Exception as e:
            conn.rollback()
            logger.error(f"[SQL ERROR] {e} | {sql}")
            raise
        finally:
            conn.close()

    def query_one(self, sql: str, params: Optional[Tuple[Any, ...]] = None) -> Optional[Dict[str, Any]]:
        pool = self._get_pool()
        conn = pool.connection()
        try:
            with conn.cursor() as cur:
                logger.debug(f"[SQL] {sql} | params={params}")
                cur.execute(sql, params or ())
                return cur.fetchone()
        finally:
            conn.close()

    def query_all(self, sql: str, params: Optional[Tuple[Any, ...]] = None) -> List[Dict[str, Any]]:
        pool = self._get_pool()
        conn = pool.connection()
        try:
            with conn.cursor() as cur:
                logger.debug(f"[SQL] {sql} | params={params}")
                cur.execute(sql, params or ())
                return cur.fetchall()
        finally:
            conn.close()

    # ------------------------------------------------------------------
    # 业务快捷方法
    # ------------------------------------------------------------------
    def count(self, table: str, where: str = "1=1", params: Optional[Tuple[Any, ...]] = None) -> int:
        row = self.query_one(f"SELECT COUNT(*) AS c FROM {table} WHERE {where}", params)
        return int(row["c"]) if row else 0

    def select_goods_count(self, goods_id: int) -> Optional[int]:
        """查询商品销量 count 字段"""
        row = self.query_one("SELECT count FROM goods WHERE id=%s", (goods_id,))
        return row["count"] if row else None

    def select_orders_by_order_id(self, order_id: str) -> List[Dict[str, Any]]:
        return self.query_all("SELECT * FROM orders WHERE order_id=%s", (order_id,))

    def select_cart_by_user(self, user_id: int) -> List[Dict[str, Any]]:
        return self.query_all("SELECT * FROM cart WHERE user_id=%s", (user_id,))


db = MySQLClient()
