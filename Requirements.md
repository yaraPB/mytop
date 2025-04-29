# mytop
Shell script that mimics the functionalities of the top command
Custom System Monitor

Project Overview

In this project, you will create a shell script called mytop that mimics the functionality of the Linux top command. The top command provides a dynamic real-time view of system processes, allowing users to monitor system resource usage and process activity. Your implementation will focus on displaying essential system metrics in a user-friendly, terminal-based interface that refreshes at regular intervals.

## Basic Functionality

**1. Display a header showing system summary information,                                            35pts**
* Current time and system uptime
* Load averages (e.g., 1min, 5min, and 15 minutes)
* Total number of processes (running, sleeping, stopped)
* CPU usage percentage (user, system)
* Memory usage (total, used, free)
  
**2. Display a sorted list of processes with the following columns,                                   25pts**
* PID (Process ID)
* USER (Username of process owner)
* PR (Priority)
* %CPU (CPU usage percentage)
* %MEM (Memory usage percentage)
* TIME+ (CPU time used)

**3. Auto-refresh the display every 5 seconds                                                                    10pts**
* Interactive commands                                                                                              30pts
* 'q' to quit
* Space to refresh immediately
* 'h' to display help

**Advanced Features (Optional)**

1. Color-coded output
* Highlight high CPU or memory usage processes
* Differentiate between system and user processes
* Use different colors for header and data sections
  
2. Sorting capabilities:
* Sort by CPU usage (default)
* Sort by memory usage ('M' key)
* Sort by process ID ('P' key)
* Sort by running time ('T' key)
 

**Deliverables**

1. A well-documented and commented shell script named mytop.sh
2. A README file explaining:
    * How to use the script
    * Command-line options and interactive commands
    * Implementation details
    * Known limitations
    * Future improvements
3. Testing results showing how your implementation compares to the standard top command
