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


# **DeepSeek Manager Installation Guide**

## **For Android (Termux) and Raspberry Pi (Terminal)**

Follow these steps to install and run the **DeepSeek Manager Script** on your device:

---

## **1. Clone the Repository**
To begin, clone the DeepSeek Manager repository from GitHub:

```bash
git clone https://github.com/sudo-xda/DeepSeekManager.git
cd DeepSeekManager
```

---

## **2. Make the Script Executable**
Grant executable permissions to the script:

```bash
chmod +x DeepSeek_android/ras_pi.sh
```

---

## **3. Run the Script**
Start the DeepSeek Manager script:

```bash
./DeepSeek_android/ras_pi.sh
```

---

## **4. Install DeepSeek**
Choose option **1** from the menu to install DeepSeek and its dependencies.

- The script will:
  - Update the system and install required packages like `git`, `cmake`, `golang`, and `libjpeg-turbo`.
  - Clone the `ollama` repository to your home directory.
  - Build the application.
  - Allow you to select and install a specific DeepSeek model (e.g., `deepseek-r1:1.5b`, `7b`, `14b`, etc.).

---

## **5. Run DeepSeek**
Once installed, you can run DeepSeek by choosing option **2** from the menu.

- You’ll be prompted to select a model to run.
- The script will handle any existing processes to ensure a clean startup.

---

## **6. Manage Running Processes**
Use option **3** to view all currently running processes related to DeepSeek.

---

## **7. Exit the Script**
To exit the script, select option **4** from the menu.

---

## **Dependencies**
Ensure the following are installed:
- **For Android (Termux)**: Install Termux from [F-Droid](https://f-droid.org/en/packages/com.termux/).
- **For Raspberry Pi**: Ensure you have a functional terminal environment with `git` and `pkg`.

---

## **Notes**
- **RAM & GPU Requirements**: Models like `deepseek-r1:14b` and `32b` require high memory and GPU resources. Ensure your device meets these requirements before proceeding.
- **Default Directory**: The `ollama` repository will be cloned to `~/ollama` by default.

---

## **Support**
For additional support or updates, visit the [GitHub repository](https://github.com/sudo-xda/DeepSeekManager).




