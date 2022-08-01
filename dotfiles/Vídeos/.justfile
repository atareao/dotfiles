create origen episode:
    #!/usr/bin/env bash
    set -euxo pipefail
    echo {{origen}} {{episode}}
    if [[ -f "{{origen}}" ]]; then
        mv "{{origen}}" "completos/e{{episode}}.mkv"
        ffmpeg -i "completos/e{{episode}}.mkv" -map 0:1 -ac 1 -vn -ab 128000 -c:a libmp3lame "/data/podcasts/audio/e{{episode}}.mp3"
    fi

cover origen episode:
    #!/usr/bin/env bash
    set -euxo pipefail
    echo {{origen}} {{episode}}
    if [[ -f "{{origen}}" ]]; then
        mv "{{origen}}" "/data/podcasts/image/tmp_e{{episode}}.jpg"
        convert -resize 1200x800! /data/podcasts/image/tmp_e{{episode}}.jpg /data/podcasts/image/e{{episode}}.jpg
        rm /data/podcasts/image/tmp_e{{episode}}.jpg
    fi

