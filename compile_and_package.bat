@echo off
REM ===============================================
REM 編譯和打包腳本 (Windows)
REM Compile and Package Script (Windows)
REM ===============================================

echo ================================================
echo 開始編譯模型架構...
echo Starting to compile model architecture...
echo ================================================

REM 檢查是否已安裝 Cython
python -c "import Cython" 2>nul
if %errorlevel% neq 0 (
    echo.
    echo [錯誤] 未安裝 Cython，正在安裝...
    echo [Error] Cython not installed, installing...
    pip install Cython
)

REM 安裝 numpy（編譯需要）
pip install numpy

echo.
echo ================================================
echo 步驟 1: 編譯 unet_new 模組...
echo Step 1: Compiling unet_new module...
echo ================================================

REM 執行 Cython 編譯
python setup.py build_ext --inplace

if %errorlevel% neq 0 (
    echo.
    echo [錯誤] 編譯失敗！
    echo [Error] Compilation failed!
    pause
    exit /b 1
)

echo.
echo ================================================
echo 步驟 2: 清理編譯中間檔案...
echo Step 2: Cleaning up compilation artifacts...
echo ================================================

REM 刪除 .c 和 .cpp 中間檔案
if exist unet_new\*.c del /q unet_new\*.c
if exist unet_new\*.cpp del /q unet_new\*.cpp

REM 刪除 build 目錄（可選）
if exist build (
    rmdir /s /q build
    echo 已刪除 build 目錄
)

echo.
echo ================================================
echo 步驟 3: 備份原始 .py 檔案...
echo Step 3: Backing up original .py files...
echo ================================================

REM 創建備份目錄
if not exist backup_source mkdir backup_source

REM 備份原始 .py 檔案
copy unet_new\lightunet_model.py backup_source\ >nul 2>&1
copy unet_new\unet_parts.py backup_source\ >nul 2>&1
copy inference_utils.py backup_source\ >nul 2>&1

echo 原始檔案已備份到 backup_source 目錄
echo Original files backed up to backup_source directory

echo.
echo ================================================
echo 步驟 4: 刪除原始 .py 檔案 (保留 __init__.py)...
echo Step 4: Removing original .py files (keeping __init__.py)...
echo ================================================

REM 刪除原始 .py 檔案（保護原始碼）
if exist unet_new\lightunet_model.py del /q unet_new\lightunet_model.py
if exist unet_new\unet_parts.py del /q unet_new\unet_parts.py
if exist inference_utils.py del /q inference_utils.py

echo 原始 .py 檔案已刪除
echo Original .py files removed

echo.
echo ================================================
echo 編譯完成！
echo Compilation completed!
echo ================================================

echo.
echo 檢查編譯結果:
echo Checking compilation results:
echo.
echo UNet 模型:
dir unet_new\*.pyd
echo.
echo 推論工具:
dir inference_utils.pyd
echo.

echo ================================================
echo 接下來的步驟:
echo Next steps:
echo ================================================
echo 1. 測試編譯後的模型: python test.py
echo 2. 初始化 Git 倉庫: git init
echo 3. 添加檔案: git add .
echo 4. 提交: git commit -m "Initial commit with compiled model"
echo 5. 推送到 GitHub: git remote add origin <your-repo-url>
echo 6. git push -u origin main
echo.
echo 注意: 原始 .py 檔案已備份到 backup_source 目錄
echo Note: Original .py files are backed up in backup_source directory
echo ================================================

pause
