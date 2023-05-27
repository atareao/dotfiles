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
    EPISODIO="$1"
    NEED_EXIT=0

    if [[ ! -d "$MAINDIR" ]]
    then
        mkdir -p "$MAINDIR"
    fi
    if [[ -f "${IMAGEDIR}/podcast_image.jpg" ]]
    then
        rm "${IMAGEDIR}/podcast_image.jpg"
    fi
    if [[ -z $EPISODIO ]]
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
    MD_FILE=$(find /data/notas/podcasts/ -maxdepth 2 -type f -name "e${EPISODIO}.md")
    if [[ ! -f "${MD_FILE}" ]];then
        echo "No existe el archivo ${MD_FILE}"
        NEED_EXIT=1
    fi
    title=$(grep "^# " "${MD_FILE}" | head -n1)
    title="${title:2}"
    if [[ -z $title ]];then
        echo "No hay título"
        NEED_EXIT=1
    fi
    if [[ $NEED_EXIT -eq 1 ]];then
        echo "Saliendo..."
        return 1
    fi
    echo '================'
    echo "Portada: ${PORTADAJPG}"
    echo "Título: ${title}"
    echo '================'

    mv "${PORTADAJPG}" "${IMAGEDIR}/temporal.jpg"
    convert -resize 2000x2000! "${IMAGEDIR}/temporal.jpg" "${IMAGEDIR}/portada_sqr.jpg"
    convert -resize 1920x1080! "${IMAGEDIR}/temporal.jpg" "${IMAGEDIR}/portada.jpg"
    rm "${IMAGEDIR}/temporal.jpg"

    cp "${RESOURCESDIR}/plantilla_podcast_2000.svg" "${IMAGEDIR}/plantilla_podcast_2000.svg"
    sed -i "s/||NUMBER||/$EPISODIO/g" "${IMAGEDIR}/plantilla_podcast_2000.svg"
    sed -i "s/||TITLE||/$title/g" "${IMAGEDIR}/plantilla_podcast_2000.svg"
    inkscape --export-type="png" "${IMAGEDIR}/plantilla_podcast_2000.svg"
    convert "${IMAGEDIR}/plantilla_podcast_2000.png" "${IMAGEDIR}/e${EPISODIO}_sqr.jpg"

    cp "${RESOURCESDIR}/plantilla_podcast.svg" "${IMAGEDIR}/plantilla_podcast.svg"
    sed -i "s/||NUMBER||/$EPISODIO/g" "${IMAGEDIR}/plantilla_podcast.svg"
    sed -i "s/||TITLE||/$title/g" "${IMAGEDIR}/plantilla_podcast.svg"
    inkscape --export-type="png" "${IMAGEDIR}/plantilla_podcast.svg"
    convert "${IMAGEDIR}/plantilla_podcast.png" "${IMAGEDIR}/e${EPISODIO}.jpg"

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
