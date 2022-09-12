#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Copyright (c) 2022 Lorenzo Carbonell <a.k.a. atareao>

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

function imp3(){
    EPISODE="$1"
    if [[ -z "$EPISODE" ]];then
        echo "Introduce el número del episodio"
        return 1
    fi
    NEED_EXIT=0
    MP3_FILE="/data/podcasts/audio/e${EPISODE}.mp3"
    if [[ ! -f "${MP3_FILE}" ]];then
        echo "No existe el archivo ${MP3_FILE}"
        NEED_EXIT=1
    fi
    JPG_FILE="/data/podcasts/image/e${EPISODE}.jpg"
    if [[ ! -f "${JPG_FILE}" ]];then
        echo "No existe el archivo ${JPG_FILE}"
        NEED_EXIT=1
    fi
    MD_FILE="/data/notas/podcasts/T05/e${EPISODE}.md"
    if [[ ! -f "${MD_FILE}" ]];then
        echo "No existe el archivo ${MD_FILE}"
        NEED_EXIT=1
    fi
    if [[ $NEED_EXIT -eq 1 ]];then
        return 1
    fi
    echo "$MP3_FILE"
    echo "$JPG_FILE"
    echo "$MD_FILE"
    eyeD3 --add-image "$JPG_FILE":FRONT_COVER "$MP3_FILE"
    eyeD3 -P itunes-podcast --add "$MP3_FILE"
    eyeD3 -P itunes-podcast "$MP3_FILE"
    eyeD3 "$MP3_FILE"
    title=$(grep "^# " "${MD_FILE}" | head -n1)
    title="${title:2}"
    track=$(basename "$(pwd)")
    track="${track:1}"
    date=$(date "+%Y-%m-%d")
    year=$(date "+%Y")
    mid3v2 "${MP3_FILE}" \
           --TALB "atareao con Linux" \
           --TCOM "Lorenzo Carbonell" \
           --TCON "Podcast" \
           --TCOP "Copyright © ${year} Lorenzo Carbonell (CC BY 4.0)" \
           --TDRC "${date}" \
           --TIT2 "${title}" \
           --TIT3 "atareao con Linux. El podcast sobre Linux y Open Source" \
           --TOPE "Lorenzo Carbonell" \
           --TPE1 "Lorenzo Carbonell" \
           --TPE2 "Lorenzo Carbonell" \
           --TRCK "${EPISODE}"
    mid3v2 "${MP3_FILE}"
    ffprobe -hide_banner "${MP3_FILE}" 2>&1 | grep Duration
}
