#!/bin/bash

function vcover(){
    portadajpg=$1
    title=$2
    subtitle=$3
    if [[ -z "${title}" || -z "${subtitle}" ]]
    then
        echo "El título y el subtítulo son obligatorios"
        exit 1
    fi
    if [ ! -f "${portadajpg}" ]
    then
        echo No existe la portada JPG
        exit 1
    fi
    cp "$portadajpg" ./portada.jpg
    cp ~/Vídeos/recursos/portada.svg ./plantilla.svg
    sed -i "s/||TITLE||/${title}/g" plantilla.svg
    sed -i "s/||SUBTITLE||/${subtitle}/g" plantilla.svg
    inkscape --export-type="png" plantilla.svg
    convert plantilla.png cover.jpg
    if [[ -f plantilla.svg ]]; then
        rm plantilla.svg
    fi
    if [[ -f plantilla.png ]]; then
        rm plantilla.png
    fi
    if [[ -f portada.jpg ]]; then
        rm portada.jpg
    fi
}
