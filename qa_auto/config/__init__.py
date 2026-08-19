import os
import yaml
from loguru import logger

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

_config_path = os.path.join(BASE_DIR, "config", "config.yaml")
with open(_config_path, "r", encoding="utf-8") as f:
    CONFIG = yaml.safe_load(f)

BASE_URL = CONFIG["env"]["base_url"]
TIMEOUT = CONFIG["env"]["timeout"]
RETRY_TIMES = CONFIG["env"]["retry_times"]
RETRY_INTERVAL = CONFIG["env"]["retry_interval"]

MYSQL_CONFIG = CONFIG["mysql"]
ACCOUNTS = CONFIG["accounts"]
TEST_DATA = CONFIG["test_data"]

_log_config = CONFIG["log"]
logger.remove()
logger.add(
    os.path.join(BASE_DIR, _log_config["file"].replace("{time}", "run")),
    level=_log_config["level"],
    rotation=_log_config["rotation"],
    retention=_log_config["retention"],
    encoding="utf-8",
    enqueue=True,
)
logger.add(
    lambda msg: print(msg, end=""),
    level=_log_config["level"],
    colorize=True,
    format="<green>{time:YYYY-MM-DD HH:mm:ss}</green> | <level>{level:<8}</level> | <cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - <level>{message}</level>",
)
