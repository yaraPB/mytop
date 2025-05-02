#!/bin/bash

while true; do
    clear

    echo "PID     USER       %CPU    %MEM    COMMAND"
    echo "----------------------------------------------"

    ps -eo pid,user,pcpu,pmem,comm --sort=-pcpu | head -n 11

    sleep 1
done
