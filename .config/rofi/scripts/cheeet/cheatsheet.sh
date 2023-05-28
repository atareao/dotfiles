#!/bin/bash

# Original author: Wangz
# Rewrite by: Lorenzo Carbonell

# Lib
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_LIB="${SCRIPT_DIR}/lib"
THEME="${SCRIPT_DIR}/cheatsheet.rasi"


function Detail(){
    OPTION="$1"
    echo "Option: $OPTION"
    SHEET="$2"
    LINE1=$(awk 'NR==1' "${SCRIPT_LIB}/${SHEET}")
    t1=$(echo "${LINE1}" | cut -d'|' -f2)
    t2=$(echo "${LINE1}" | cut -d'|' -f3)
    t3=$(echo "${LINE1}" | cut -d'|' -f4)
    t4=$(echo "${LINE1}" | cut -d'|' -f5)
    n2=$(echo "${OPTION}" | cut -d'|' -f3 | sed 's/"/\"/g')
    LINE=$(grep -F "${OPTION}" "${SCRIPT_LIB}/${SHEET}")
    echo "LINE: $LINE."
    n1=$(echo "${LINE}" | cut -d'|' -f2 | sed 's/"/\\"/g')
    echo "n1: $n1."
    echo "n2: $n2."
    n3=$(echo "${LINE}" | cut -d'|' -f4 | sed 's/"/\\"/g')
    n4=$(echo "${LINE}" | cut -d'|' -f5 | sed 's/"/\\"/g')
    DETAIL=$(echo -e "> $t1: $n1\n> $t2: $n2\n> $t3: $n3\n> $t4: $n4")
    rofi -dmenu -p "Detail"  -config "${THEME}" -mesg "${DETAIL}"
}


function Sheet() {
    SHEET="$1"
    MESSAGE=$(awk 'NR==1' "${SCRIPT_LIB}/${SHEET}" | \
              cut -d'|' -f 1,2,3,4 | \
              sed 's/[ ]/=/g')
    OPTION=$(awk 'NR>1' "${SCRIPT_LIB}/${SHEET}" | \
             cut -d'|' -f 1,2,3,4 | \
             rofi -dmenu \
                  -mesg "${MESSAGE:0:100}" \
                  -p CheatSheet \
                  -config "${THEME}")

    if [ -n "$OPTION" ]; then
        Detail "${OPTION}" "${SHEET}"
    fi
}

function App() {
    OPTION=$(find "${SCRIPT_LIB}" -type f -printf "%f\n" | \
             rofi -dmenu -p "App" -config "${THEME}")
    if [[ -n "$OPTION" ]]
    then
        Sheet "${OPTION}"
    fi
}

function ShowHelp() {
    echo -e "    all -- show all apps/command cheatsheet in one page\n \
                 sgl -- just show apps/commands in the first page   "
}

if [[ "$1" == "all" ]]
then
    if [[ ! -f "${SCRIPT_LIB}/all" ]]
    then
        cat $(find "${SCRIPT_LIB}" -type f ! -name all) > "${SCRIPT_LIB}/all"
    fi
    Sheet all
elif [[ "$1" == "sgl" ]]
then
    App
else
    ShowHelp
fi
