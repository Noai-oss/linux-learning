# 配置 AI 开发环境

## 一、环境准备

### 1. Python 环境
推荐使用 `conda` 或 `venv` 管理虚拟环境，避免依赖冲突。

```bash
# 使用 conda 创建环境
conda create -n ai_env python=3.10
conda activate ai_env

# 或使用 venv
python -m venv ai_env
source ai_env/bin/activate  # Linux/Mac
ai_env\Scripts\activate     # Windows
```

### 2. 核心依赖库

```bash
pip install numpy pandas matplotlib scikit-learn
pip install torch torchvision torchaudio
pip install tensorflow jupyter notebook
pip install transformers datasets
```

## 二、GPU 配置（可选）

如需使用 GPU 加速深度学习训练：

1. 确认显卡支持 CUDA（NVIDIA GPU）
2. 安装对应版本的 CUDA Toolkit 和 cuDNN
3. 安装 GPU 版本的 PyTorch：

```bash
pip install torch --index-url https://download.pytorch.org/whl/cu121
```

4. 验证 GPU 是否可用：

```python
import torch
print(torch.cuda.is_available())  # 应输出 True
print(torch.cuda.get_device_name(0))
```

## 三、开发工具推荐

| 工具 | 用途 |
|------|------|
| VS Code | 轻量级代码编辑器，插件丰富 |
| Jupyter Notebook | 交互式开发，适合实验和演示 |
| PyCharm | 全功能 Python IDE |
| Cursor | AI 辅助编程编辑器 |

## 四、常用配置示例

### Jupyter 远程访问配置

```bash
jupyter notebook --generate-config
jupyter notebook password
# 修改配置文件，设置允许远程访问
```

### 镜像源加速（国内）

```bash
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
