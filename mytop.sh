#!/bin/bash

# optional: defining colors
WHITE_BG="\033[47m"
BLACK_TXT="\033[30m"
BLUE='\033[1;34m'  
PURPLE='\033[0;35m'
BLACK='\033[0;30m'
GREY_BG='\033[48;5;235m'
NC='\033[0m'   

# the menu 
show_help() {
    clear
    echo -e "${WHITE_BG}${BLACK_TXT}"
    echo -e "Available Commands:"
    echo "  q     Quit the application"
    echo "  h     Display this help message"
    echo "  SPACE Refresh immediately"
    echo
    echo "Press any key to return..."
    echo -e "${NC}"
    read -n 1 -s
}

main_application(){ 

while true; do
    clear

cat << "EOF"
                    __            
   ____ ___  __  __/ /_____  ____ 
  / __  __ \/ / / / __/ __ \/ __ \
 / / / / / / /_/ / /_/ /_/ / /_/ /
/_/ /_/ /_/\__, /\__/\____/ .___/ 
          /____/         /_/  

EOF

# 1. Display a header showing system summary information
# Current time and system uptime 
# Load averages (e.g., 1min, 5min, and 15 minutes)

# when the load average is for the past 1 minute, 5 minute and 15 minutes
    # -p means pretty 
# Define colors

# Print colored metrics, white values
printf "${BLUE}Current time:${NC} %-8s  ${BLUE}Uptime:${NC} %-10s  ${BLUE}Load(1m):${NC} %-5s  ${BLUE}Load(5m):${NC} %-5s  ${BLUE}Load(15m):${NC} %-5s\n" \
"$(uptime | cut -d' ' -f2)" \
"$(uptime -p | cut -d' ' -f2-)" \
"$(uptime | awk '{print $(NF-2)}')" \
"$(uptime | awk '{print $(NF-1)}')" \
"$(uptime | awk '{print $NF}')"



# Total number of processes (running, sleeping, stopped)
ps -eo stat | awk '
  BEGIN {
    BLUE = "\033[1;34m"
    NC = "\033[0m"
    R = 0
    S = 0
    T = 0
    total = 0
  }

  # Skip the header (NR > 1 to process only process lines)
  NR > 1 {
    state = substr($1, 1, 1)
    if (state == "R") R++
    else if (state == "S") S++
    else if (state == "T") T++
    total++
  }

  END {
    printf "\n%sTotal number of processes:%s %d ", BLUE, NC, total
    printf "(Running: %d, Sleeping: %d, Stopped: %d)\n", R, S, T
  }
'


# CPU usage percentage (user, system)
# please if you don't have it install sysstat through the following command: 
# sudo apt install sysstat
# for the user level is %usr and for the system level is %sys

mpstat | awk '{if(NR>1) print $2, $3, $5}'


# Memory usage (total, used, free)
# this is displayed in Mi (mebibytes)
#!/bin/bash

echo
printf "%-8.8s %8.8s %8.8s %8.8s\n" "" "total" "used" "free"
free -m | awk 'NR==2 || NR==3 { printf "%-8.8s %8.8s %8.8s %8.8s\n", $1, $2, $3, $4 }'

# 2. Display a sorted list of processes with the following columns
    
echo
ps -eo pid,user,pri,pcpu,pmem,comm,time --sort=-pcpu | head -n 5

    # Refreshing the page
   echo
        echo -e "Commands: [SPACE] Refresh  [h] Help  [q] Quit"
        echo -n "Input (waiting 5s): "

        # waiting a max of 5s 
        read -t 5 -n 1 input 

        if [[ $? -eq 0 ]]; then 
            case "$input" in
                " ")
                    continue ;; 
                "q"|"Q")
                    echo -e "\nExiting..."
                    exit 0 ;;
                "h"|"H")
                    clear
                    show_help ;;
            esac
        fi

done

}

main_application