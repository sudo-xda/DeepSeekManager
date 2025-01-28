

# ========================================
# DeepSeek Manager Script for Termux
# ========================================
clear
echo "Welcome to the DeepSeek Manager Script for Termux!"
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
  
  # Step 1: Update system and install essential dependencies
  pkg update -y && pkg upgrade -y
  pkg install -y git cmake golang libjpeg-turbo
  
  # Step 2: Clone the Ollama repository
  git clone https://github.com/ollama/ollama.git ~/ollama

  # Step 3: Navigate to the ollama directory
  cd ~/ollama

  # Step 4: Generate Go files
  go generate ./

  # Step 5: Build the application
  go build .

  echo "Installation completed! You can now run DeepSeek using the 'Run DeepSeek' option."
}

# Run DeepSeek function
run_deepseek() {
  echo "Starting DeepSeek..."
  
  # Start Ollama server in the background
  ./ollama serve &

  # Pull the DeepSeek model
  ./ollama pull deepseek-r1:1.5b
  
  echo "DeepSeek is running! Press Ctrl+C to stop."
}

# Show running processes function
show_processes() {
  echo "Current running processes related to DeepSeek:"
  
  # List processes with the name 'ollama' (or adjust as necessary)
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
