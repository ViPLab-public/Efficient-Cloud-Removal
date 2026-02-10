"""
Setup script for compiling Python modules with Cython
用於使用 Cython 編譯 Python 模組的安裝腳本

使用方法 / Usage:
    python setup.py build_ext --inplace
    
這將會把 unet_new 目錄下的 .py 檔案編譯成 .pyd (Windows) 或 .so (Linux/Mac) 檔案
"""

from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy as np
import os

# 定義需要編譯的模組
extensions = [
    # UNet 模型架構
    Extension(
        "unet_new.lightunet_model",
        ["unet_new/lightunet_model.py"],
        include_dirs=[np.get_include()],
    ),
    Extension(
        "unet_new.unet_parts",
        ["unet_new/unet_parts.py"],
        include_dirs=[np.get_include()],
    ),
    # 推論工具模組
    Extension(
        "inference_utils",
        ["inference_utils.py"],
        include_dirs=[np.get_include()],
    ),
]

setup(
    name="unet_model",
    version="1.0",
    description="Compiled UNet model for inference",
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            'language_level': "3",
            'embedsignature': True,
            'boundscheck': False,
            'wraparound': False,
        }
    ),
    zip_safe=False,
)
