# UNet Model Inference System

This is an image segmentation inference system based on Efficient UNet. Users can perform inference through the provided interface.

## Features

- Pre-trained Efficient UNet model
- Customizable path configuration

## Requirements

```
Python >= 3.8
torch >= 1.10.0
lightning >= 2.0.0
opencv-python
albumentations
segmentation-models-pytorch
pandas
numpy
```

## Installation

1. Clone this repository
```bash
git clone <your-repo-url>
cd githubfinal
```

2. Install dependencies
```bash
pip install -r requirements.txt
```

## Usage

### 1. Configure Paths

Edit the `config.py` file and modify the following path settings:

```python
# Model checkpoint file path
MODEL_CHECKPOINT = "./light_unet-v2.ckpt"

# Test data paths
IMAGE_DIR = "./test/img"           # Test images directory
MASK_DIR = "./test/mask"           # Test masks directory
OUTPUT_DIR = "./test/output"       # Output results directory
```

### 2. Run Inference

```bash
python test.py
```

### 3. View Results

Inference results will be saved in the directory specified by `OUTPUT_DIR`.

## Project Structure

```
githubfinal/
│
├── config.py              # Configuration file (modifiable)
├── test.py                # Inference interface (modifiable)
├── light_unet-v2.ckpt     # Model weights
├── requirements.txt       # Dependencies list
│
├── unet_new/              # Compiled model modules
│   ├── __init__.py
│   ├── lightunet_model.pyd   # Compiled model architecture (Windows)
│   └── unet_parts.pyd        # Compiled model components (Windows)
│
└── test/                  # Test data directory
    ├── img/               # Input images
    ├── mask/              # Ground truth masks
    └── output/            # Output results
```

## Parameters

Adjustable parameters in `config.py`:

- `MODEL_CHECKPOINT`: Model checkpoint file path
- `IMAGE_DIR`: Input images directory
- `MASK_DIR`: Ground truth masks directory (for evaluation)
- `OUTPUT_DIR`: Output results directory
- `BATCH_SIZE`: Batch size (default: 1)
- `NUM_WORKERS`: Number of data loading workers (default: 4)
- `N_CHANNELS`: Number of input image channels (default: 3)
- `N_CLASSES`: Number of output classes (default: 1)

## Notes

1. Model architecture is compiled as `.pyd` files (Windows), source code is not visible
2. Can only configure and use through `config.py` and `test.py`
3. Ensure input images are in correct format (supports common image formats)
4. Mask files should be named as `{original_image_name}_binary.tif`

## System Requirements

- GPU: NVIDIA GPU with CUDA support (recommended)
- Python: >= 3.8

## License

This project is for academic and research purposes only. Commercial use is prohibited without permission.

## Contact

For questions or suggestions, please contact the project maintainer.

---

## FAQ

### Q: How to change model weights?
A: Modify the `MODEL_CHECKPOINT` path in `config.py`.

### Q: What image formats are supported?
A: Supports common formats like PNG, JPG, JPEG, TIF, TIFF, etc.

### Q: How to run on CPU?
A: Modify `ACCELERATOR = "cpu"` in `config.py`.

### Q: What if I run out of memory?
A: Adjust `BATCH_SIZE` to a smaller value (e.g., 1) in `config.py`.
