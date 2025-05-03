#!/bin/bash

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

# Optional: We define the colors:
BLUE='\033[1;34m'  
PURPLE='\033[0;35m'
NC='\033[0m'       

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

sleep 1
done
