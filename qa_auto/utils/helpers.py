"""测试工具函数"""
import random
import string
from datetime import datetime


def random_str(length: int = 8) -> str:
    return "".join(random.choices(string.ascii_letters + string.digits, k=length))


def timestamp() -> str:
    return datetime.now().strftime("%Y%m%d%H%M%S")


def rand_price() -> float:
    return round(random.uniform(9.9, 999.9), 2)


def rand_count() -> int:
    return random.randint(10, 999)
