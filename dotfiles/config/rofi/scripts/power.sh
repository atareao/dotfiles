#!/bin/bash

apagar=" Apagar"
reiniciar=" Reiniciar"
suspender=" Suspender"
salvapantallas="Salvapantallas"
bloquear=" Bloquear"
logout=" Cerrar sesión"

options="${apagar}\n${reiniciar}\n${suspender}\n${salvapantallas}\n${bloquear}"
ans=$(echo -e $options | rofi -p "Elige:" -dmenu)
rs=$?
if [ $rs -eq 0 ]
then
    echo "$ans"
    case "$ans" in
        "$apagar")
            systemctl poweroff
            ;;
        "$reiniciar")
            systemctl reboot
            ;;
        "$suspender")
            systemctl suspend
            ;;
        "$salvapantallas")
			betterlockscreen
            ;;
        "$bloquear")
			betterlockscreen -l
            ;;
        "$logout")
            bspc quit
            ;;
    esac
fi
