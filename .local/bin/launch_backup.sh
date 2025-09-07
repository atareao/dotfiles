#!/bin/bash

# while read -r item;do
#     variable="${item/\//_}"
#     echo "${variable}"
#     export "${variable}=$(gopass show --password "$item")"
# done < <(gopass list --flat)
# yadm alt
# 
# /bin/bash "$HOME/.local/bin/backup.sh"
/bin/bash "$HOME/.local/bin/backup.sh"
/bin/bash "$HOME/.local/bin/rustic_backup.sh"
