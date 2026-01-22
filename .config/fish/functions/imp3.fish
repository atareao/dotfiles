function imp3
    # El resto del código igual...
    set -l EPISODE $argv[1]
    
    if test -z "$EPISODE"
        echo "Introduce el número del episodio"
        return 1
    end

    set -l NEED_EXIT 0
    set -l MP3_FILE "/data/podcasts/audio/e$EPISODE.mp3"
    set -l JPG_FILE "/data/podcasts/image/e$EPISODE.jpg"
    
    if not test -f "$MP3_FILE"
        echo "No existe el archivo $MP3_FILE"
        set NEED_EXIT 1
    end

    if not test -f "$JPG_FILE"
        echo "No existe el archivo $JPG_FILE"
        set NEED_EXIT 1
    end

    set -l MD_FILE (rg -l "^episode: $EPISODE" "/data/notas/Podcasts/atareao con Linux/")
    
    if not test -f "$MD_FILE"
        echo "No existe el archivo de notas para el episodio $EPISODE"
        set NEED_EXIT 1
    end

    if test $NEED_EXIT -eq 1
        return 1
    end

    echo "Procesando: $MP3_FILE"

    set -l title (grep "^title: " "$MD_FILE" | head -n1 | string replace "title: " "" | string trim)
    set -l date (date "+%Y-%m-%d")
    set -l year (date "+%Y")

    id3cli --file "$MP3_FILE" \
           --album "atareao con Linux" \
           --composer "Lorenzo Carbonell" \
           --genre "Podcast" \
           --copyright "Copyright © $year Lorenzo Carbonell (CC BY 4.0)" \
           --date "$date" \
           --year "$year" \
           --title "$title" \
           --subtitle "atareao con Linux. El podcast sobre Linux y Open Source" \
           --original-artist "Lorenzo Carbonell" \
           --artist "Lorenzo Carbonell" \
           --album-artist "Lorenzo Carbonell" \
           --cover "$JPG_FILE" \
           --track "$EPISODE"

    id3cli --file "$MP3_FILE" --show
    ffprobe -hide_banner "$MP3_FILE" 2>&1 | grep Duration
end
