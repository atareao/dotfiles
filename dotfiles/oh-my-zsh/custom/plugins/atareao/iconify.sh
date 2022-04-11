#!/bin/bash

function iconify(){
    filename="$1"
    if [[ -f "${filename}" ]]
    then
        output="${filename/.png}.webp"
        cwebp "${filename}" -o "${output}"
        salida=$(base64 < "${output}" | tr -d '\n')
        echo "data:image/webp;base64,${salida}"
    fi
}
