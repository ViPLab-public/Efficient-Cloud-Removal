# Efficient-Cloud-Removal (Inference-Only) — Cloud Segmentation

This repository provides an **inference-only** implementation for our paper titled **“Efficient-Cloud-Removal”**.  
Although the paper title contains *cloud removal*, the **actual task studied in the paper and implemented here is cloud segmentation** (i.e., predicting a cloud mask).  
The naming is kept consistent with the paper title for indexing and citation purposes.

>  Task in this repo: **Cloud Segmentation (Binary Mask Prediction)**  
>  Not included: cloud-free image reconstruction / inpainting / restoration

---

## 1. Overview

We provide a lightweight inference pipeline based on a UNet-style model to produce a **cloud mask** from an input image.

**Input:** RGB image (satellite/remote sensing image)  
**Output:** predicted mask (binary map)

Typical use cases:
- Cloud coverage estimation
- Mask-based preprocessing for downstream remote sensing analytics
- Filtering or selecting cloud-free regions

## 2. Project Structure

```

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

> **Why `.pyd`?**  
> Per project policy requirements, core implementation details are distributed as compiled Python extensions (`.pyd`) rather than plain source code in this stage.
> The source code will be uploaded gradually in the future. (coming soon ...)

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

1. Install dependencies
```bash
pip install -r requirements.txt
```

## 3. Usage

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

The model produces a cloud mask of the following formats : Binary mask after thresholding (.png)

## 4. Reproducibility / Modifiability
This repository is inference-only.

The compiled .pyd modules are platform- and Python-version-specific.

Training code, internal implementation details, and model internals are not publicly released.

## 5. Paper & Citation
If you use this repository or the provided checkpoint in your research, please cite our paper:

Efficient Cloud Removal for Remote Sensing Data Transmission via Model Compression and Sparse Accelerator Design

@article{efficient_cloud_removal,
  title     = {Efficient Cloud Removal for Remote Sensing Data Transmission via Model Compression and Sparse Accelerator Design},
  author    = {Chun-Fu Chen, Chun-Han Chen, and Pei-Jun Lee},
  year      = {2026},
  journal   = {IEEE JSTARS}
}

## Notes

1. Model architecture is compiled as `.pyd` files (Windows), source code is not visible
2. Can only configure and use through `config.py` and `test.py`
3. Ensure input images are in correct format (supports common image formats)
4. Mask files should be named as `{original_image_name}_binary.tif`
5. The code will be organized and uploaded to the open source gradually. (coming soon ...)

## License

Academic and research use only.

Commercial use is prohibited without explicit permission.

Redistribution of the compiled binaries and checkpoint should follow the project policy.

If you are unsure whether your use case is allowed, please contact the authors.

## Contact

For questions or suggestions, please contact the project maintainer.

---

## FAQ

### Q1: Why is the repo name “Cloud-Removal” but the task is segmentation?
The repository name matches the paper title for citation consistency. The actual implemented task is cloud segmentation, as described in the paper.

### Q2: Can I train / fine-tune the model?
Not with this repository. This repo is inference-only by design.
