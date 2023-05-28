#!/bin/bash
ans=$(echo -e "" | rofi -p "Buscar en Google:" -dmenu)
rs=$?
if [ $rs -eq 0 ] && [ "$ans" ]
then
    sensible-browser "google.com/search?q=${ans}"
fi
