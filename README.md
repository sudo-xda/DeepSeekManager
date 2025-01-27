# **DeepSeekManager**: A Comprehensive DeepSeek Model Management & Execution System on edge devices

[![Downloads](https://img.shields.io/github/downloads/sudo-xda/DeepSeekManager/total)](https://github.com/sudo-xda/DeepSeekManager/releases)

**DeepSeekManager** is a user-friendly script designed to manage and run DeepSeek models on Termux (Android) and Raspberry Pi (Raspbian). This script automates the installation of necessary dependencies, model pulling, and model execution, making it easier for users to leverage powerful AI models even on low-resource devices.

### Key Features

- **Auto Installation**:
  - Installs essential dependencies for Termux and Raspberry Pi.
  - Clones and sets up the [Ollama](https://github.com/sudo-xda/ollama) repository.
  - Pulls selected DeepSeek models (1.5b, 7b, 8b, 14b, and 32b) during installation.

- **Model Selection**:
  - Select from various DeepSeek model versions to install and run.
  - Receive warnings when choosing high-resource models (14b and 32b).

- **Automatic Process Management**:
  - Kill any running **Ollama** processes to avoid conflicts.
  - Start a new DeepSeek model with a single command.
  - Monitor active processes with ease.

- **Cross-Platform Support**:
  - Supports **Termux** (Android) and **Raspberry Pi** (Raspbian).
  
- **Customizable**:
  - Easily change the model without modifying the script, thanks to its interactive menu.

---

### **Installation**

#### **For Termux (Android)**

1. **Clone the repository**:
   ```bash
   git clone https://github.com/<your-username>/DeepSeekManager.git
   cd DeepSeekManager

