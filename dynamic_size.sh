#!/bin/bash

# Read user input once
read -p "Enter input: " input

# display the OS type: 

    get_os() {
    case "$OSTYPE" in
        linux*)
          
        ;;

        darwin*)
          
        ;;

        openbsd*)
          
        ;;

        *)
            #...
        ;;
    esac

    echo "$OSTYPE"
}


while true; do

    # Get terminal dimensions
    cols=$(tput cols)
    rows=$(tput lines)

    # Clear the screen
    clear

    # Calculate positions
    input_length=${#input}
    top_right_col=$((cols - input_length))
    bottom_row=$((rows - 1))  # 0-indexed

    # Display input at all four corners
    # Top-left
    tput cup 0 0
    echo -n "$input"

    # Top-right
    tput cup 0 $top_right_col
    echo -n "$input"

    # Bottom-left
    tput cup $bottom_row 0
    echo -n "$input"

    # Bottom-right
    tput cup $bottom_row $top_right_col
    echo -n "$input"

    # Sleep before next refresh
    sleep 1
done
