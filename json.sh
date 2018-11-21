#! /bin/bash

indent=''
tab='\t'
output=''

json=$@

for (( i=0; i<${#json}; i++ )); do
    char="${json:$i:1}"
    case $char in
        "[")
            indent=$indent$tab
            output="$output$char\n$indent"
            ;;
        "]")
            indent=${indent::-2}
            output="$output\n$indent$char"
            ;;

        "{")
            indent=$indent$tab
            output="$output$char\n$indent"
            ;;
        "}")
            indent=${indent::-2}
            output="$output\n$indent$char"
            ;;
        ",")
            output="$output$char\n$indent"
            ;;
        " ")
            ;;
        *)
            output="$output$char"
    esac
done

echo -e $output' '
