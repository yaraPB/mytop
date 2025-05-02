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


echo "$(get_os)" 