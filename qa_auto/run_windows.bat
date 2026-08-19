@echo off
REM ====================================================================
REM  Windows 一键执行接口自动化测试脚本
REM  使用方式:
REM    1) cd qa_auto
REM    2) run_windows.bat [smoke|all|order|permission]
REM ====================================================================

chcp 65001 >nul
setlocal enabledelayedexpansion

set ROOT=%~dp0
cd /d "%ROOT%"

REM -------- 1. 创建虚拟环境 --------
if not exist "venv\Scripts\python.exe" (
    echo [1/4] 创建 Python 虚拟环境...
    python -m venv venv || (
        echo [ERROR] 创建虚拟环境失败，请先安装 Python 3.8+
        exit /b 1
    )
)

REM -------- 2. 安装依赖 --------
echo [2/4] 检查并安装依赖...
call venv\Scripts\activate
pip show pytest >nul 2>nul
if errorlevel 1 (
    pip install -r requirements.txt
)

REM -------- 3. 清理旧报告 --------
echo [3/4] 清理旧的 allure 结果...
if exist "reports\allure-results" rmdir /s /q reports\allure-results
if not exist "reports" mkdir reports

REM -------- 4. 执行用例 --------
set TARGET=%1
if "%TARGET%"=="" set TARGET=all

echo [4/4] 执行测试 - 模式: %TARGET%
set EXTRA=
if "%TARGET%"=="smoke"    set EXTRA=tests\test_00_smoke.py -m smoke
if "%TARGET%"=="order"    set EXTRA=tests\test_03_order_flow.py -m order_flow
if "%TARGET%"=="perm"     set EXTRA=tests\test_01_auth_permission.py -m permission
if "%TARGET%"=="all"      set EXTRA=tests\

pytest %EXTRA% -v --reruns 1 --alluredir=reports\allure-results
set EXIT_CODE=%ERRORLEVEL%

echo.
echo ===========================================================
echo   pytest 退出码: %EXIT_CODE%
echo   日志目录:      %ROOT%logs\
echo   Allure 结果:   %ROOT%reports\allure-results\
echo   查看报告需安装 allure: scoop install allure
echo   生成 HTML:     allure serve reports\allure-results
echo ===========================================================

exit /b %EXIT_CODE%
