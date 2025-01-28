
# ========================================
# DeepSeek Manager Script for Raspberry Pi
# Author: sudo-xda
# GitHub: https://github.com/sudo-xda
# ========================================

# Colors for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
banner() {
  clear
  echo -e "${BLUE}"
  echo "========================================"
  echo "  DeepSeek Manager Script for Raspberry Pi"
  echo "  Author: ${GREEN}sudo-xda${BLUE}                       "
  echo "  GitHub: ${GREEN}https://github.com/sudo-xda${BLUE}    "
  echo "========================================"
  echo -e "${NC}"
}

# Menu function
menu() {
  echo -e "${YELLOW}Choose an option from the menu below:${NC}"
  echo "1. Install DeepSeek"
  echo "2. Run DeepSeek"
  echo "3. Show running processes"
  echo "4. Exit"
  echo -n -e "${GREEN}Select an option [1-4]: ${NC}"
  read option
}

# Install DeepSeek function
install_deepseek() {
  echo -e "${YELLOW}Installing DeepSeek...${NC}"

  # Update system and install essential dependencies
  echo -e "${BLUE}Updating system and installing dependencies...${NC}"
  sudo apt update -y && sudo apt upgrade -y
  sudo apt install -y git cmake golang libjpeg-turbo

  # Clone the Ollama repository
  echo -e "${BLUE}Cloning the Ollama repository...${NC}"
  git clone https://github.com/sudo-xda/ollama.git ~/ollama

  # Navigate to the ollama directory
  cd ~/ollama

  # Generate Go files and build the application
  echo -e "${BLUE}Building the application...${NC}"
  go generate ./
  go build .

  # Model selection for installation
  echo -e "${YELLOW}Select the DeepSeek model version to install:${NC}"
  echo "1. deepseek-r1:1.5b"
  echo "2. deepseek-r1:7b"
  echo "3. deepseek-r1:8b"
  echo "4. deepseek-r1:14b"
  echo "5. deepseek-r1:32b"
  echo -n -e "${GREEN}Select a model version [1-5]: ${NC}"
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
      echo -e "${RED}Warning: The 14b model requires high RAM and GPU resources.${NC}"
      model="deepseek-r1:14b"
      ;;
    5)
      echo -e "${RED}Warning: The 32b model requires very high RAM and GPU resources.${NC}"
      model="deepseek-r1:32b"
      ;;
    *)
      echo -e "${RED}Invalid model selection. Exiting.${NC}"
      exit 1
      ;;
  esac

  # Pull the selected model
  echo -e "${BLUE}Pulling the model: $model...${NC}"
  ./ollama pull $model
  
  echo -e "${GREEN}Installation completed! The model $model is installed. You can now run it using the 'Run DeepSeek' option.${NC}"
}

# Kill existing Ollama process function
kill_existing_process() {
  echo -e "${YELLOW}Checking for any running Ollama processes...${NC}"

  # Kill any existing Ollama processes
  existing_process=$(pgrep -f 'ollama serve')
  
  if [ -z "$existing_process" ]; then
    echo -e "${BLUE}No existing Ollama process found.${NC}"
  else
    echo -e "${RED}Found existing Ollama process with PID: $existing_process. Killing it...${NC}"
    kill -9 $existing_process
    echo -e "${GREEN}Ollama process killed successfully.${NC}"
  fi
}

# Run DeepSeek function
run_deepseek() {
  # Kill any existing Ollama process before starting a new one
  kill_existing_process
  
  # Show model selection menu for running
  echo -e "${YELLOW}Select the DeepSeek model to run:${NC}"
  echo "1. deepseek-r1:1.5b"
  echo "2. deepseek-r1:7b"
  echo "3. deepseek-r1:8b"
  echo "4. deepseek-r1:14b"
  echo "5. deepseek-r1:32b"
  echo -n -e "${GREEN}Select a model version to run [1-5]: ${NC}"
  read model_option

  # Handle model selection for running
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
      echo -e "${RED}Warning: The 14b model requires high RAM and GPU resources.${NC}"
      model="deepseek-r1:14b"
      ;;
    5)
      echo -e "${RED}Warning: The 32b model requires very high RAM and GPU resources.${NC}"
      model="deepseek-r1:32b"
      ;;
    *)
      echo -e "${RED}Invalid model selection. Exiting.${NC}"
      exit 1
      ;;
  esac

  # Start DeepSeek with the selected model
  echo -e "${BLUE}Running DeepSeek with model $model...${NC}"
  
  # Start Ollama server with the selected model
  ./ollama run $model
  
  echo -e "${GREEN}DeepSeek is running with model $model! Press Ctrl+C to stop.${NC}"
}

# Show running processes function
show_processes() {
  echo -e "${YELLOW}Current running processes related to DeepSeek:${NC}"
  
  # List processes with the name 'ollama'
  ps aux | grep 'ollama'
}

# Main loop
while true; do
  banner
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
      echo -e "${GREEN}Exiting script. Goodbye!${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option! Please select a valid option [1-4].${NC}"
      ;;
  esac
  echo -e "${YELLOW}Press Enter to continue...${NC}"
  read
done