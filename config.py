"""
配置文件 - 使用者可以修改的設定
Configuration file - User modifiable settings
"""

# 模型相關設定 / Model settings
MODEL_CHECKPOINT = "./light_unet-v2.ckpt"  # 模型權重檔案路徑

# 測試資料路徑 / Test data paths
IMAGE_DIR = "./test/img"           # 測試圖片目錄
MASK_DIR = "./test/mask"           # 測試遮罩目錄
OUTPUT_DIR = "./test/output"       # 輸出結果目錄

# 模型參數 / Model parameters
N_CHANNELS = 3      # 輸入圖片通道數
N_CLASSES = 1       # 輸出類別數
BILINEAR = True     # 是否使用雙線性插值

# 訓練參數 / Training parameters
BATCH_SIZE = 1      # 批次大小
NUM_WORKERS = 4     # 資料載入的工作進程數
MAX_EPOCHS = 100    # 最大訓練週期
LEARNING_RATE = 1e-3  # 學習率

# GPU 設定 / GPU settings
PRECISION = "16-mixed"  # 精度設定
ACCELERATOR = "gpu"     # 加速器類型
DEVICES = -1            # 使用的設備數量 (-1 表示全部)
