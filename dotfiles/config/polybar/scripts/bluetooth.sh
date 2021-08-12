#!/bin/sh

bluetooth_print() {
    bluetoothctl show | grep -i "Powered: yes" > /dev/null
    rs=$?
    if [ $rs -eq 0 ]
    then
        device=$(bluetooth_info)
        if [ -z "$device" ]
        then
            echo "󰂯 "
        else
            echo "󰂰 $device"
        fi
    else
        echo "󰂲"
    fi
}

bluetooth_info(){
    devices_paired=$(bluetoothctl paired-devices | grep Device)
    echo "$devices_paired" | while read -r line; do
        ITEM=${line#* }
        ID=${ITEM%% *}
        NAME=${ITEM#* }
        bluetoothctl info $ID | grep "Connected: yes" > /dev/null
        rs=$?
        if [ $rs -eq 0 ]
        then
            echo $NAME
            return
        fi
    done
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    --test)
        bluetooth_test
        ;;
    *)
        bluetooth_print
        ;;
esac
