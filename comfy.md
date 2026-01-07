### Comfy on mac
on mac os 13.5.2, pytorch 2.6.0 is the last version that supports MPS
comfy currently has pytorch  version unspecified in the requirements.txt, and this installs 2.9.1

### show problems with pip install:

use "pip check" to see if you have version problems: unsupported versions, missing dependencies, etc.

### how to install the binary only version of a package:

 pip install av --only-binary=:all:


### safely downgrade torch:

 pip uninstall torch torchvision torchaudio -y
 pip install torch==2.6.0 torchvision torchaudio

### how to sanity test MPS (metal programmable shaders?) on mac os: torch:

import torch
import platform

print(f"--- Environment Check ---")
print(f"OS: macOS {platform.mac_ver()[0]}")
print(f"Architecture: {platform.machine()}")
print(f"PyTorch Version: {torch.__version__}")

print(f"\n--- MPS Support Check ---")
print(f"MPS Built-in: {torch.backends.mps.is_built()}")
print(f"MPS Available: {torch.backends.mps.is_available()}")

print(f"\n--- Hardware Allocation Test ---")
try:
    # Attempting to move a calculation to the M2 GPU
    device = torch.device("mps")
    x = torch.ones(1, device=device)
    y = x + x
    print(f"SUCCESS: Result {y.item()} calculated on device: {y.device}")
except Exception as e:
    print(f"FAILED: The M2 GPU could not be reached. Error: {e}")


### ssl certificate errors
Solution / Workaround:

The fix is to point the embedded Python to the existing certifi CA bundle:

Open Command Prompt
Run:
export SSL_CERT_FILE="<PATH_TO_COMFYUI>\python_embeded\Lib\site-packages\certifi\cacert.pem"
Restart ComfyUI



