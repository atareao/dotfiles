#!/bin/bash
# Copyright (c) 2023 Lorenzo Carbonell <a.k.a. atareao>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


function portada_podcast(){
    MAINDIR="/data/podcasts"
    IMAGEDIR="${MAINDIR}/image"
    RESOURCESDIR="/data/Vídeos/recursos"
    NUMBER="$1"
    TOTAL=$(($(fd "yo-.*\.png" "${RESOURCESDIR}" | wc -l) - 1))
    SELECTED=$(($RANDOM%${TOTAL} + 1))
    DIA=$(printf "%0*d" 2 $SELECTED)
    echo "DIA: ${DIA}"
    NEED_EXIT=0

    if [[ ! -d "$MAINDIR" ]]
    then
        mkdir -p "$MAINDIR"
    fi
    if [[ -f "${IMAGEDIR}/podcast_image.jpg" ]]
    then
        rm "${IMAGEDIR}/podcast_image.jpg"
    fi
    if [[ -z $NUMBER ]]
    then
        echo "No has introducido el número del episodio"
        NEED_EXIT=1
    fi
    PORTADAJPG=$(find ~/Descargas -maxdepth 1 -type f -name "*.jpg" -printf '%TY%Tm%Td%TH%TM %p\n' | sort -r | head -1 | awk '{print $2}')
    if [[ ! -f "$PORTADAJPG" ]]
    then
        echo No existe la portada JPG
        NEED_EXIT=1
    fi
    MD_FILE=$(rg -l "^episode: ${NUMBER}" "/data/notas/Podcasts/atareao con Linux")
    if [[ ! -f "${MD_FILE}" ]];then
        echo "No existe el archivo ${MD_FILE}"
        NEED_EXIT=1
    fi
    TITLE=$(grep "^title: " "${MD_FILE}" | head -n1)
    TITLE="${TITLE//title: /}"
    if [[ -z $TITLE ]];then
        echo "No hay título"
        NEED_EXIT=1
    fi
    if [[ $NEED_EXIT -eq 1 ]];then
        echo "Saliendo..."
        return 1
    fi
    echo '================'
    echo "Portada: ${PORTADAJPG}"
    echo "Notas: ${MD_FILE}"
    echo "Título: ${TITLE}"
    echo '================'
    TEMPLATE="${RESOURCESDIR}/plantilla_podcast.svg" 
    TEMPLATE_2000="${RESOURCESDIR}/plantilla_podcast_2000.svg" 

    mv "${PORTADAJPG}" "${IMAGEDIR}/temporal.jpg"
    magick "${IMAGEDIR}/temporal.jpg" -resize 2000x2000! "${IMAGEDIR}/portada_sqr.jpg"
    magick "${IMAGEDIR}/temporal.jpg" -resize 1920x1080! "${IMAGEDIR}/portada.jpg"
    rm "${IMAGEDIR}/temporal.jpg"

    export NUMBER
    export TITLE
    export DIA

    jinrender -j "$TEMPLATE_2000" -o "${IMAGEDIR}/plantilla_podcast_2000.svg"
    inkscape --export-type="png" "${IMAGEDIR}/plantilla_podcast_2000.svg" -o "${IMAGEDIR}/plantilla_podcast_2000.png"
    magick "${IMAGEDIR}/plantilla_podcast_2000.png" "${IMAGEDIR}/e${NUMBER}_sqr.jpg"

    jinrender -j "$TEMPLATE" -o "${IMAGEDIR}/plantilla_podcast.svg"
    inkscape --export-type="png" "${IMAGEDIR}/plantilla_podcast.svg" -o "${IMAGEDIR}/plantilla_podcast.png"
    magick "${IMAGEDIR}/plantilla_podcast.png" "${IMAGEDIR}/e${NUMBER}.jpg"

    if [[ -f "${IMAGEDIR}/plantilla_podcast_2000.svg" ]]; then
        rm "${IMAGEDIR}/plantilla_podcast_2000.svg"
    fi
    if [[ -f "${IMAGEDIR}/plantilla_podcast_2000.png" ]]; then
        rm "${IMAGEDIR}/plantilla_podcast_2000.png"
    fi
    if [[ -f "${IMAGEDIR}/plantilla_podcast.svg" ]]; then
        rm "${IMAGEDIR}/plantilla_podcast.svg"
    fi
    if [[ -f "${IMAGEDIR}/plantilla_podcast.png" ]]; then
        rm "${IMAGEDIR}/plantilla_podcast.png"
    fi
    if [[ -f "${IMAGEDIR}/portada.jpg" ]]; then
        rm "${IMAGEDIR}/portada.jpg"
    fi
    if [[ -f "${IMAGEDIR}/portada_sqr.jpg" ]]; then
        rm "${IMAGEDIR}/portada_sqr.jpg"
    fi
}
