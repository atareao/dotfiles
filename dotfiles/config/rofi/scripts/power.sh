#!/bin/bash

apagar=" Apagar"
reiniciar=" Reiniciar"
suspender=" Suspender"
salvapantallas="Salvapantallas"
bloquear=" Bloquear"
logout=" Cerrar sesión"

OPTIONS="${apagar}\n${reiniciar}\n${suspender}\n${salvapantallas}\n${bloquear}\n${logout}"
ans=$(echo -e "${OPTIONS}" | rofi -p "Elige:" -dmenu)
rs=$?
if [ $rs -eq 0 ]
then
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
