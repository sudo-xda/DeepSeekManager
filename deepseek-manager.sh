#!/bin/bash

# ========================================
# DeepSeek Manager Script for Termux / Raspberry Pi
# ========================================
clear
echo "Welcome to the DeepSeek Manager Script!"
echo "Choose an option from the menu below:"

# Menu function
menu() {
  echo "1. Install DeepSeek"
  echo "2. Run DeepSeek"
  echo "3. Show running processes"
  echo "4. Exit"
  echo -n "Select an option [1-4]: "
  read option
}

# Install DeepSeek function
install_deepseek() {
  echo "Installing DeepSeek..."

  # Update system and install essential dependencies
  if [ -x "$(command -v apt)" ]; then
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y git cmake golang libjpeg-turbo
  elif [ -x "$(command -v pkg)" ]; then
    pkg update -y && pkg upgrade -y
    pkg install -y git cmake golang libjpeg-turbo
  else
    echo "Unsupported package manager. Exiting."
    exit 1
  fi

  # Clone the Ollama repository
  git clone https://github.com/ollama/ollama.git ~/ollama

  # Navigate to the ollama directory
  cd ~/ollama

  # Generate Go files and build the application
  go generate ./
  go build .

  echo "Installation completed! You can now run DeepSeek using the 'Run DeepSeek' option."
}

# Kill existing Ollama process function
kill_existing_process() {
  echo "Checking for any running Ollama processes..."

  # Kill any existing Ollama processes
  existing_process=$(pgrep -f 'ollama serve')
  
  if [ -z "$existing_process" ]; then
    echo "No existing Ollama process found."
  else
    echo "Found existing Ollama process with PID: $existing_process. Killing it..."
    kill -9 $existing_process
    echo "Ollama process killed successfully."
  fi
}

# Run DeepSeek function
run_deepseek() {
  # Kill any existing Ollama process before starting a new one
  kill_existing_process
  
  # Show model selection menu
  echo "Select the DeepSeek model version to use:"
  echo "1. deepseek-r1:1.5b"
  echo "2. deepseek-r1:7b"
  echo "3. deepseek-r1:8b"
  echo "4. deepseek-r1:14b"
  echo "5. deepseek-r1:32b"
  echo -n "Select a model version [1-5]: "
  read model_option

  # Handle model selection
  case $model_option in
    1)
      model="deepseek-r1:1.5b"
      ;;
    2)
      model="deepseek-r1:7b"
      ;;
    3)
      model="deepseek-r1:8b"
      ;;
    4)
      echo "Warning: The 14b model requires high RAM and GPU resources."
      model="deepseek-r1:14b"
      ;;
    5)
      echo "Warning: The 32b model requires very high RAM and GPU resources."
      model="deepseek-r1:32b"
      ;;
    *)
      echo "Invalid model selection. Exiting."
      exit 1
      ;;
  esac

  # Start DeepSeek server and pull the selected model
  echo "Starting DeepSeek with model $model..."
  
  # Start Ollama server in the background
  ./ollama serve &
  
  # Pull the selected DeepSeek model
  ./ollama pull $model
  
  echo "DeepSeek is running with model $model! Press Ctrl+C to stop."
}

# Show running processes function
show_processes() {
  echo "Current running processes related to DeepSeek:"
  
  # List processes with the name 'ollama'
  ps aux | grep 'ollama'
}

# Main loop
while true; do
  menu
  case $option in
    1) 
      install_deepseek
      ;;
    2) 
      run_deepseek
      ;;
    3) 
      show_processes
      ;;
    4)
      echo "Exiting script. Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid option! Please select a valid option [1-4]."
      ;;
  esac
done
