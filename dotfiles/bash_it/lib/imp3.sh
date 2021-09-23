#!/usr/bin/env bash

function imp3(){
    jpg_file=$(ls *.jpg | head -1)
    mp3_file=$(ls *.mp3 | head -1)
    echo $jpg_file
    echo $mp3_file
    echo ${mp3_file/.mp3}_original.mp3
    eyeD3 --add-image "$jpg_file":FRONT_COVER "$mp3_file"
    eyeD3 -P itunes-podcast --add "$mp3_file"
    eyeD3 -P itunes-podcast "$mp3_file"
    eyeD3 "$mp3_file"
    title=$(head -n1 podcast.md)
    title="${title:2}"
    track=$(basename $(pwd))
    track="${track:1}"
    date=$(date "+%Y-%m-%d")
    year=$(date "+%Y")
    mid3v2 "${mp3_file}" \
           --TALB "atareao con Linux" \
           --TCOM "Lorenzo Carbonell" \
           --TCON "Podcast" \
           --TCOP "Copyright © 2021 Lorenzo Carbonell (CC BY 4.0)" \
           --TDRC "${date}" \
           --TIT2 "${title}" \
           --TIT3 "atareao con Linux. El podcast sobre Linux y Open Source" \
           --TOPE "Lorenzo Carbonell" \
           --TPE1 "Lorenzo Carbonell" \
           --TPE2 "Lorenzo Carbonell" \
           --TRCK "${track}"
    mid3v2 "${mp3_file}"
}
