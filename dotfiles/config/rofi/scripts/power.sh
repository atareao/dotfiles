#!/bin/bash

apagar="Apagar"
reiniciar="Reiniciar"
suspender="Suspender"
salvapantallas="Salvapantallas"
bloquear="Bloquear"
logout="Cerrar sesión"

options="${apagar}\n${reiniciar}\n${suspender}\n${salvapantallas}\n${bloquear}"
ans=$(echo -e $options | rofi -p "Selecciona:" -dmenu)
rs=$?
if [ $rs -eq 0 ]
then
    echo $ans
    case "$ans" in
        $apagar)
            bus-send --system --print-reply --dest=org.freedesktop.login1 \
            /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" \
            boolean:true
            ;;
        $reiniciar)
            dbus-send --system --print-reply --dest=org.freedesktop.login1 \
            /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" \
            boolean:true
            ;;
        $suspender)
            systemctl suspend
            ;;
        $salvapantallas)
            gnome-screensaver-command --activate
            ;;
        $bloquear)
            gnome-screensaver-command --lock
            ;;
        $logout)
            bspc quit
            ;;
    esac
fi
