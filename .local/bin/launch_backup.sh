#!/bin/bash

while read -r item;do
    variable="${item/\//_}"
    echo "${variable}"
    export "${variable}=$(gopass show --password "$item")"
done < <(gopass list --flat)
yadm alt

/bin/bash "$HOME/lorenzo/.local/bin/backup.sh"
