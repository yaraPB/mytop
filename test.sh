#! /bin/bash

# detecting what OS the user has: 
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

# Getting the window size: 

get_term_size() {
    # Get terminal size ('stty' is POSIX and always available).
    # This can't be done reliably across all bash versions in pure bash.
    read -r LINES COLUMNS < <(stty size)
    echo "LINES=$LINES, COLUMNS=$COLUMNS" 
}

# Trapping the window in a specific size
trapping_term_size(){
    trap 'get_term_size' WINCH
}