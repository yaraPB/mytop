#!/bin/bash

while true; do
    clear 

# Used cat instead of echo so that the '/' in the ASCII art don't get interpreted

cat << "EOF"
                    __            
   ____ ___  __  __/ /_____  ____ 
  / __  __ \/ / / / __/ __ \/ __ \
 / / / / / / /_/ / /_/ /_/ / /_/ /
/_/ /_/ /_/\__, /\__/\____/ .___/ 
          /____/         /_/  

EOF


    echo "PID USER     PRI %CPU %MEM COMMAND   TIME+"
    echo "----------------------------------------------"

    ps -eo pid,user,pri,pcpu,pmem,comm,time --sort=-pcpu | head -n 11

    sleep 1
done
