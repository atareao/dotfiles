#!/usr/bin/env bash

function imp3(){
    JPG_FILE="$(find . -type f -name '*.jpg' | head -n1)"
    MP3_FILE="$(find . -type f -name '*.mp3' | head -n1)"
    MD_FILE="$(find . -type f -name '*.md' | head -n1)"
    echo "$JPG_FILE"
    echo "$MP3_FILE"
    echo "${MP3_FILE/.mp3}_original.mp3"
    eyeD3 --add-image "$JPG_FILE":FRONT_COVER "$MP3_FILE"
    eyeD3 -P itunes-podcast --add "$MP3_FILE"
    eyeD3 -P itunes-podcast "$MP3_FILE"
    eyeD3 "$MP3_FILE"
    title=$(head -n1 "${MD_FILE}")
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
           --TRCK "${track}"
    mid3v2 "${MP3_FILE}"
    ffprobe -hide_banner "${MP3_FILE}" 2>&1 | grep Duration
}
