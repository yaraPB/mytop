#!/bin/bash

# Function to print the table with dynamic column widths
print_table() {
    # Calculate the width for the columns dynamically
    local metric_width=20
    local value_width=20

    # Find the longest metric name
    for metric in "$@"; do
        metric_length=${#metric}
        if (( metric_length > metric_width )); then
            metric_width=$metric_length
        fi
    done

    # Find the longest value
    for value in "${metric_values[@]}"; do
        value_length=${#value}
        if (( value_length > value_width )); then
            value_width=$value_length
        fi
    done

    # Print the table
    echo "------------------------ System Summary ------------------------"
    printf "| %-$(($metric_width))s | %-$(($value_width))s |\n" "Metric" "Value"
    echo "---------------------------------------------------------------"
    
    # Iterate over the metrics and print them
    for i in "${!metric_names[@]}"; do
        printf "| %-$(($metric_width))s | %-$(($value_width))s |\n" "${metric_names[$i]}" "${metric_values[$i]}"
    done
    echo "---------------------------------------------------------------"
}

# Collect metrics
metric_names=("Current time" "System uptime (hh:mm)" "Load average (1m)" "Load average (5m)" "Load average (15m)")
metric_values=()

# Collect system information
metric_values+=("$(date '+%H:%M:%S')")                      # Current time
metric_values+=("$(uptime | awk '{print $3, $4}')")          # System uptime (hh:mm)
metric_values+=("$(uptime | awk '{print $(NF-2)}')")         # Load average (1m)
metric_values+=("$(uptime | awk '{print $(NF-1)}')")         # Load average (5m)
metric_values+=("$(uptime | awk '{print $NF}')")             # Load average (15m)

# Print the table
print_table "${metric_names[@]}"
