#Created By Black Frieza
# Fixed: Added the dot to target your hidden folder
SCRIPT_DIR="$HOME/.setup"

# Color Codes for Termux
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Helper function to execute and validate child scripts safely
run_script() {
    local script_name="$1"
    local step_info="$2"
    local full_path="$SCRIPT_DIR/$script_name"

    if [ -n "$step_info" ]; then
        echo -e "${BLUE}[$step_info] Launching ${script_name}...${RESET}"
    else
        echo -e "${BLUE}[*] Launching ${script_name}...${RESET}\n"
    fi

    # Check if script exists inside the hidden folder
    if [ ! -f "$full_path" ]; then
        echo -e "${RED}[!] Error: ${script_name} not found in hidden directory ${SCRIPT_DIR}!${RESET}"
        return 1
    fi

    # Execute target script using its absolute path
    bash "$full_path"
    local status=$?

    if [ $status -ne 0 ]; then
        echo -e "${RED}\n[!] Error: ${script_name} failed with exit code $status.${RESET}"
        return 1
    fi

    echo -e "${GREEN}[+] ${script_name} has completely exited successfully.${RESET}\n"
    return 0
}

# Function to display the banner
show_banner() {
    clear
    echo -e "${CYAN}    ┌──────────────────────────────────────────────────┐"
    echo "    │░█▀▀░█▀▄░▀█▀░█▀▀░▀█▀░█▀█░░░░░░░░░░░░░░░░░░░░░░░░░░│"
    echo "    │░█▀▀░█▀▄░░█░░█▀▀░░█░░█▀█░░░░░░░░░░░░░░░░░░░░░░░░░░│"
    echo "    │░▀░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░░░░░░░░░░░░░░░░░░░░░░░░│"
    echo -e "    └──────────────────────────────────────────────────┘${RESET}"
    echo -e "    [*] By-${YELLOW} Black Frieza${RESET}"
    echo -e "    [*] Path: ${RED}${SCRIPT_DIR} (Hidden)${RESET}"
    echo ""
    echo -e "    All Setups (Step-by-Step)"
    echo -e "    Run Programs (program.sh)"
    echo -e "    Run Neovim Setup (nvim.sh)"
    echo -e "    Run GUI Setup (gui.sh)"
    echo -e "    Run Kali Setup (kali.sh)"
    echo -e "    Quit"
    echo ""
}

# Infinite loop to keep showing the menu until the user quits
while true; do
    show_banner
    
    # Prompt user input cleanly
    read -p "    [Select Option]: " choice

    case "$choice" in
        1)
            echo -e "\n${YELLOW}=================================================="
            echo "   STARTING SEQUENTIAL SETUP CHAIN (ONE BY ONE)"
            echo -e "==================================================${RESET}\n"
            
            # Step 1: Run nvim.sh
            run_script "nvim.sh" "Step 1/4"
            if [ $? -ne 0 ]; then
                read -n 1 -s -r -p "Chain broken. Press any key to return to menu..."
                continue
            fi
            sleep 1.0

            # Step 2: Run program.sh
            run_script "program.sh" "Step 2/4"
            if [ $? -ne 0 ]; then
                read -n 1 -s -r -p "Chain broken. Press any key to return to menu..."
                continue
            fi
            sleep 1.0

            # Step 3: Run gui.sh
            run_script "gui.sh" "Step 3/4"
            if [ $? -ne 0 ]; then
                read -n 1 -s -r -p "Chain broken. Press any key to return to menu..."
                continue
            fi
            sleep 1.0

            # Step 4: Run kali.sh
            run_script "kali.sh" "Step 4/4"
            if [ $? -ne 0 ]; then
                read -n 1 -s -r -p "Chain broken. Press any key to return to menu..."
                continue
            fi
            
            # Clear screen and display successful sequential message
            clear
            echo -e "${GREEN}"
            echo "    ┌──────────────────────────────────────────────┐"
            echo "    │  [+] SUCCESS: ALL SCRIPTS EXECUTED SAFELY!   │"
            echo "    │  Every file setup has completely exited.     │"
            echo "    └──────────────────────────────────────────────┘"
            echo -e "${RESET}"
            read -n 1 -s -r -p "Press any key to return to main menu..."
            ;;
        2)
            echo ""
            run_script "program.sh"
            read -n 1 -s -r -p "Press any key to return to menu..."
            ;;
        3)
            echo ""
            run_script "nvim.sh"
            read -n 1 -s -r -p "Press any key to return to menu..."
            ;;
        4)
            echo ""
            run_script "gui.sh"
            read -n 1 -s -r -p "Press any key to return to menu..."
            ;;
        5)
            echo ""
            run_script "kali.sh"
            read -n 1 -s -r -p "Press any key to return to menu..."
            ;;
        6)
            echo -e "\n${RED}[!] Exiting script. Goodbye!${RESET}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] Invalid Option! Please choose a number from 1 to 6.${RESET}"
            sleep 1.5
            ;;
    esac
done
