#!/bin/bash

# optional: defining colors
WHITE_BG="\033[47m"
BLACK="\033[30m"
BLUE="\033[1;34m"  
PURPLE="\033[0;35m"
YELLOW="\033[1;33m"
GREY_BG="\033[48;5;235m"
NC="\033[0m"   

# the menu 
show_help() {
    clear
    echo -e "${WHITE_BG}${BLACK}"
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
# in the awk, we need to pass the colors seperately 
ps -eo stat | awk '
  BEGIN {
    BLUE = "\033[1;34m"
    YELLOW="\033[1;33m"
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
    printf "%s(Running:%s %d, %sSleeping:%s %d, %sStopped:%s %d%s)%s\n", YELLOW, NC, R, YELLOW, NC, S, YELLOW, NC, T, YELLOW, NC
  }
'


# CPU usage percentage (user, system)
# please if you don't have it install sysstat through the following command: 
# sudo apt install sysstat
# for the user level is %usr and for the system level is %sys
echo
mpstat | 
awk 'BEGIN {
  PURPLE="\033[0;35m"
  NC="\033[0m"
  printf PURPLE "CPU USAGE\t %-12s %-12s" NC "\n", "User Usage", "System Usage"
}
END {
  printf "\t\t %-12s %-12s\n", sprintf("%.1f%%", $3*100), sprintf("%.1f%%", $5*100)
}'

# Memory usage (total, used, free)
# this is displayed in Mi (mebibytes)
echo
free -m | 
awk 'BEGIN {
  PURPLE="\033[0;35m"
  NC="\033[0m"
  printf PURPLE "%-12s %12s %12s %12s" NC "\n", "", "total(MiB)", "used(MiB)", "free(MiB)"
}
NR==2 || NR==3 {
  printf "%-12s %12s %12s %12s\n", $1, $2, $3, $4
}'

# 2. Display a sorted list of processes with the following columns
    
# Reserve space for header, spacing, and footer (command bar)
    height=$(tput lines)

echo

    # Get terminal height and width using stty
    read rows cols < <(stty size)

    # Lines to reserve (command bar + padding)
    overhead_lines=18
    reserved=1
    process_lines=$((rows - overhead_lines - reserved))

    # Print only what fits before the last line
ps -eo pid,user,pri,pcpu,pmem,comm,time --sort=-pcpu | head -n "$process_lines" | awk '
BEGIN {
    GREEN_FG = "\033[1;32m"
    GREY_FG  = "\033[1;30m"
    RED_BG   = "\033[41m"
    WHITE_BG = "\033[47m"
    NC       = "\033[0m"
}
NR==1 {
    print
    next
}
{
    cpu = $4 + 0
    mem = $5 + 0

    # Default color by user
    fg = ($2 == "root") ? GREY_FG : GREEN_FG
    bg = ""

    # Apply background color by usage
    if (cpu > 0.5 || mem > 0.3) bg = RED_BG
    else if (cpu > 0.2 || mem > 0.15) bg = WHITE_BG

    printf "%s%s%-5s %-10s %-5s %-5s %-5s %-20s %s%s\n", bg, fg, $1, $2, $3, $4, $5, $6, $7, NC
}'


    # Move cursor to bottom line using tput
    tput cup $((rows - 1)) 0
    echo -ne "${WHITE_BG}${BLACK}Commands: [SPACE] Refresh  [h] Help  [q] Quit${NC}"

        # waiting a max of 5s 
        read -t 5 -n 1 input 

        if [[ $? -eq 0 ]]; then 
            case "$input" in
                " ")
                    continue ;; 
                "q"|"Q")
                    exit 0 ;;
                "h"|"H")
                    clear
                    show_help ;;
            esac
        fi
done
}
main_application