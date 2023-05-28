#!/bin/bash
declare -A moptions
question=''
bluetoothctl devices | {
    while read line
    do 
        line=${line//Device }
        mac=${line%% *}
        option=${line//$mac}
        moptions["${option:1}"]="${mac}"
        question+="${option:1}\n"
    done
    ans=$(echo -e "${question::-2}" | rofi -dmenu)
    rs=$?
    if [ $rs -eq 0 ]
    then
        echo "Connecting to ${ans} with mac ${moptions[${ans}]}"
        bluetoothctl connect ${moptions["${ans}"]}
    fi
}
