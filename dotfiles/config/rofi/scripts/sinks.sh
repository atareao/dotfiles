#!/bin/bash
declare -A moptions
contador=0
pacmd list-sinks | grep -e 'name:' -e 'index:' | {
    while read line
    do 
        nada=$(echo $line | grep index)
        if [ $? -eq 0 ]
        then
            n=${line##*:}
            read line
            option=${line#*.}
            moptions[${option::-1}]=${n:1}
        fi
    done
    ans=$(echo ${!moptions[@]} | tr ' ' '\n' | rofi -dmenu)
    rs=$?
    if [ $rs -eq 0 ]
    then
        pacmd set-default-sink ${moptions["${ans}"]}
    fi
}
