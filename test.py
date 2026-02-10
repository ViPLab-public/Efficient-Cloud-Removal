"""
測試接口腳本 - 使用者可以運行此腳本進行模型推論
Test interface script - Users can run this script for model inference

使用方法 / Usage:
1. 修改 config.py 中的路徑設定
2. 運行: python test.py
"""

# 導入配置文件（使用者可修改）
import config

# 導入編譯後的推論工具（已編譯為 .pyd/.so 檔案，保護原始碼）
from inference_utils import run_inference


if __name__ == '__main__':
    # 執行推論，所有複雜邏輯都在編譯後的模組中
    run_inference(config)
