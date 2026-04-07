function imp3 --description 'Etiqueta el archivo MP3 del episodio con metadatos ID3'
    set -l EPISODE $argv[1]
    
    # 1. Validación de parámetro
    if test -z "$EPISODE"
        echo "Introduce el número del episodio"
        return 1
    end

    set -l NEED_EXIT 0

    # 2. Comprobación de archivos base
    set -l MP3_FILE "/data/podcasts/audio/e$EPISODE.mp3"
    if not test -f "$MP3_FILE"
        echo "No existe el archivo $MP3_FILE"
        set NEED_EXIT 1
    end

    set -l JPG_FILE "/data/podcasts/image/e$EPISODE""_sqr.jpg"
    if not test -f "$JPG_FILE"
        echo "No existe el archivo $JPG_FILE"
        set NEED_EXIT 1
    end

    # 3. Validación de notas (buscando unicidad como en portada_podcast)
    set -l MD_FILES (rg -l "^episode: $EPISODE" "/data/notas/Podcasts/atareao con Linux/")
    if test (count $MD_FILES) -ne 1
        echo "Error: Se esperaba 1 archivo de notas, se encontraron "(count $MD_FILES)
        set NEED_EXIT 1
    else
        set -f MD_FILE $MD_FILES[1]
    end

    if test "$NEED_EXIT" -eq 1
        return 1
    end

    # 4. Extracción de metadatos del Markdown
    echo "Procesando metadatos para episodio $EPISODE..."
    echo "Audio: $MP3_FILE"
    echo "Imagen: $JPG_FILE"
    echo "Notas: $MD_FILE"

    set -l title (grep "^title: " "$MD_FILE" | head -n 1 | string replace "title: " "")
    set -l season (grep "^season: " "$MD_FILE" | head -n 1 | string replace "season: " "")
    set -l current_date (date "+%Y-%m-%d")
    set -l current_year (date "+%Y")

    # 5. Ejecución de id3cli
    id3cli edit \
        --album "atareao con Linux" \
        --composer "Lorenzo Carbonell" \
        --genre "Podcast" \
        --copyright "Copyright © $current_year Lorenzo Carbonell (CC BY 4.0)" \
        --date "$current_date" \
        --year "$current_year" \
        --title "$title" \
        --subtitle "atareao con Linux. El podcast sobre Linux y Open Source" \
        --original-artist "Lorenzo Carbonell" \
        --artist "Lorenzo Carbonell" \
        --album-artist "Lorenzo Carbonell" \
        --cover "$JPG_FILE" \
        --track "$EPISODE" \
        --season "$season" \
        "$MP3_FILE"

    # 6. Verificación final
    id3cli show "$MP3_FILE"
    ffprobe -hide_banner "$MP3_FILE" 2>&1 | grep Duration
end
