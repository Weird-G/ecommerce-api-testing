#!/usr/bin/env bash
# ====================================================================
#  macOS/Linux 一键执行接口自动化测试脚本
#  使用方式:
#    1) cd qa_auto
#    2) chmod +x run_unix.sh && ./run_unix.sh [smoke|all|order|permission]
# ====================================================================
set -e

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$ROOT"

MODE="${1:-all}"

# -------- 1. 创建虚拟环境 --------
if [ ! -f "venv/bin/python" ]; then
    echo "[1/4] 创建 Python 虚拟环境..."
    python3 -m venv venv
fi
source venv/bin/activate

# -------- 2. 安装依赖 --------
echo "[2/4] 检查并安装依赖..."
if ! pip show pytest >/dev/null 2>&1; then
    pip install -r requirements.txt
fi

# -------- 3. 清理旧报告 --------
echo "[3/4] 清理旧的 allure 结果..."
rm -rf reports/allure-results
mkdir -p reports logs

# -------- 4. 执行用例 --------
echo "[4/4] 执行测试 - 模式: $MODE"
case "$MODE" in
    smoke)      TGT="tests/test_00_smoke.py -m smoke" ;;
    order)      TGT="tests/test_03_order_flow.py -m order_flow" ;;
    permission) TGT="tests/test_01_auth_permission.py -m permission" ;;
    *)          TGT="tests/" ;;
esac

pytest $TGT -v --reruns 1 --alluredir=reports/allure-results || true

echo
echo "==========================================================="
echo "  Allure 结果:   $ROOT/reports/allure-results/"
echo "  查看报告:      allure serve reports/allure-results"
echo "==========================================================="
