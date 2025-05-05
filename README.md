Name: Yara Kouttane 
ID: 136406

# mytop

## How to use the script

Please first make sure that you have the following installed: 

* sysstat (if not please run
 sudo apt install sysstat)
* procps (sudo apt install procps)

**To run the script** please run the following command on your terminal (after going to the directory where mytop.sh is stored):
./mytop.sh

## Command-line options and interactive commands

![Command-line options and interactive commands](./public/img1.png)

```shell
 Available Commands:

  [q]     Quit the application
  [h]     Display this help message
  [SPACE] Refresh immediately

 To change the sort criteria:
  [C]     Sort by CPU usage
  [M]     Sort by memory usage
  [P]     Sort by process ID
  [T]     Sort by running time

  Press any key to return
```

## Implementation details

This project has implemented all the requirements and advanced features of the project as for the key components it displays: 

* Current time and system uptime and Load averages (e.g., 1min, 5min, and 15 minutes) 

```shell
uptime
```

* Total number of processes (running, sleeping, stopped) 

```shell
ps -eo stat | awk 
```

* CPU usage percentage (user, system)
```shell
mpstat
```

* Memory usage (total, used, free)
```shell
free -m
```