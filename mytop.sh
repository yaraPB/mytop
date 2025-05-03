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

# 1. Display a header showing system summary information
# Current time and system uptime 
# Load averages (e.g., 1min, 5min, and 15 minutes)

# when the load average is for the past 1 minute, 5 minute and 15 minutes
    # echo "Current time  System uptime    Load averages:  1min 5mins  15mins "
    # echo "----------------------------------------------"

echo "========= System Summary ========="
echo
echo "Current time     : $(uptime | awk '{print $1}')"
echo "System uptime (hh:mm)   : $(uptime | awk '{print $2, $3}')"
echo "Load average (1m): $(uptime | awk '{print $(NF-2)}')"
echo "Load average (5m): $(uptime | awk '{print $(NF-1)}')"
echo "Load average (15m): $(uptime | awk '{print $NF}')"
echo "=================================="
echo
echo

# Total number of processes (running, sleeping, stopped)
echo "============== Process informations ==============="
ps -eo stat | awk '
  BEGIN {
    R=0; S=0; T=0; total=0
  }
  #  we use NR to skip the header (NR stands for the number of records)
  NR>1 {
    state=substr($1,1,1)
    if(state=="R") R++
    else if(state=="S") S++
    else if(state=="T") T++
    total++
  }
  END {
    printf "\nTotal number of processes : %d\n", total
    printf "Running : %d\n", R
    printf "Sleeping : %d\n", S
    printf "Stopped : %d\n", T
  }
'
echo "==================================================="
echo

# CPU usage percentage (user, system)
# please if you don't have it install sysstat through the following command: 
# sudo apt install sysstat
# for the user level is %usr and for the system level is %sys
    
echo "======== CPU usage percentage ============"
mpstat | awk '{if(NR>1) print $2, $3, $5}'
echo "=========================================="
echo

# Memory usage (total, used, free)
# this is displayed in Mi (mebibytes)
echo "============ Memory Usage ================"
echo
free -m | awk '{print $1, $2, $3, $4}'
echo "=========================================="
echo 

# 2. Display a sorted list of processes with the following columns
    
echo "================== Active processes ===================="
echo
ps -eo pid,user,pri,pcpu,pmem,comm,time --sort=-pcpu | head -n 5
echo "========================================================"

sleep 1

done
