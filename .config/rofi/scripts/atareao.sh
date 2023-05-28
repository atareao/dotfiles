#!/bin/bash
ans=$(echo -e "" | rofi -p "Buscar en atareao.es:" -dmenu)
rs=$?
if [ $rs -eq 0 ] && [ "$ans" ]
then
    firefox "google.com/search?q=site:atareao.es+${ans}"
fi
