#!/bin/bash

while true; do
    clear

    echo "PID USER     PRI %CPU %MEM COMMAND   TIME+"
    echo "----------------------------------------------"

    ps -eo pid,user,pri,pcpu,pmem,comm,time --sort=-pcpu | head -n 11

    sleep 1
done
