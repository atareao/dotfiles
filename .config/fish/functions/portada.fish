function portada --description 'Genera portadas con validación estricta de notas y escalado IA'
    set -l MAINDIR "/data/podcasts"
    set -l IMAGEDIR "$MAINDIR/image"
    set -l RESOURCESDIR "/data/Vídeos/recursos"
    set -l NUMBER $argv[1]
    
    if test -z "$NUMBER"
        echo "Error: Indica el número del episodio."
        return 1
    end

    # 1. VALIDACIÓN ESTRICTA DE NOTAS (Markdown)
    # Buscamos archivos que contengan exactamente "episode: NUMBER" al inicio de línea
    set -l MD_FILES (rg -l "^episode: $NUMBER" "/data/notas/Podcasts/atareao con Linux")
    set -l MD_COUNT (count $MD_FILES)

    if test $MD_COUNT -eq 0
        echo "Error: No se encontró ningún archivo de notas para el episodio $NUMBER."
        return 1
    else if test $MD_COUNT -gt 1
        echo "Error: Se encontraron múltiples archivos para el episodio $NUMBER:"
        for f in $MD_FILES; echo "  -> $f"; end
        return 1
    end
    
    set -l MD_FILE $MD_FILES[1]
    set -gx TITLE (grep "^title: " "$MD_FILE" | head -n 1 | string replace "title: " "")
    set -gx NUMBER $NUMBER

    # 2. DETECCIÓN Y ESCALADO IA (Real-ESRGAN) de los PNGs en Descargas
    set -l png_files (fd . ~/Descargas -e png -X ls -t | head -2)
    
    if test (count $png_files) -ne 2
        echo "Error: Se necesitan exactamente 2 archivos PNG en Descargas (encontrados: "(count $png_files)")."
        return 1
    end

    echo ">>> Analizando y escalando imágenes de Descargas..."
    echo $png_files
    for input_file in $png_files
        echo "=== Working on: $input_file ==="

        # --- PASO 1: Conversión inicial a JPG ---
        set -l tmp_jpg "tmp_processing_$NUMBER.jpg"
        magick "$input_file" "$tmp_jpg"

        # --- PASO 2: Obtener dimensiones ---
        set -l width (magick identify -format "%w" "$tmp_jpg")
        set -l height (magick identify -format "%h" "$tmp_jpg")
        
        # Multiplicamos el ratio por 100 para trabajar con enteros
        set -l ratio_int (math "100 * $width / $height")

        set -l final_name ""
        set -l target_w 0
        set -l target_h 0
        set -l needs_upscale 0

        # --- PASO 3: Lógica con enteros ---
        # 16:9 está entre 160 y 190
        if test $ratio_int -ge 160; and test $ratio_int -le 190
            set final_name "episode-$NUMBER.jpg"
            if test "$width" -lt 1920; or test "$height" -lt 1080
                set needs_upscale 1
            end
            set target_w 1920
            set target_h 1080
        else
            set final_name "episode-$NUMBER-sqr.jpg"
            if test "$width" -lt 2000; or test "$height" -lt 2000
                set needs_upscale 1
            end
            set target_w 2000
            set target_h 2000
        end

        # --- PASO 4: Escalado y salida ---
        if test "$needs_upscale" -eq 1
            echo "Escalando con Real-ESRGAN -> $final_name"
            set -l tmp_esrgan "tmp_esrgan_$NUMBER.png"
            
            if realesrgan-ncnn-vulkan -i "$tmp_jpg" -o "$tmp_esrgan" -s 2
                # El "!" fuerza el tamaño exacto
                magick "$tmp_esrgan" -resize "$target_w"x"$target_h!" "/tmp/$final_name"
                rm "$tmp_esrgan"
                echo "¡Procesado y reescalado con éxito!"
            else
                echo "Error en Real-ESRGAN, guardando sin escalar."
                mv "$tmp_jpg" "/tmp/$final_name"
            end
        else
            magick "$tmp_jpg" -resize "$target_w"x"$target_h!" "/tmp/$final_name"
            echo "Imagen final: $final_name (no requería escala)"
        end

        # Limpieza final de temporales por si acaso
        if test -f "$tmp_jpg"; rm "$tmp_jpg"; end
    end

    # 3. SELECCIÓN DE RECURSOS (DIA)
    set -l files (fd "yo-.*\.png" "$RESOURCESDIR")
    set -gx DIA (printf "%02d" (random 1 (math (count $files) - 1)))
    
    set -l PORTADAJPG "/tmp/episode-$NUMBER.jpg"
    set -l PORTADAJPG_SQR "/tmp/episode-$NUMBER-sqr.jpg"

    # 4. RENDERIZADO Y OPTIMIZACIÓN
    if not test -d "$IMAGEDIR"; mkdir -p "$IMAGEDIR"; end
    cp "$PORTADAJPG" "$IMAGEDIR/portada.jpg"
    cp "$PORTADAJPG_SQR" "$IMAGEDIR/portada_sqr.jpg"

    for t in "plantilla_podcast" "plantilla_podcast_2000"
        set -l out_suffix ""; test "$t" = "plantilla_podcast_2000"; and set out_suffix "_sqr"
        
        jinrender -j "$RESOURCESDIR/$t.svg" -o "$IMAGEDIR/tmp.svg"
        inkscape --export-type="png" "$IMAGEDIR/tmp.svg" -o "$IMAGEDIR/tmp.png"
        
        set -l final_out "$IMAGEDIR/e$NUMBER$out_suffix.jpg"
        magick "$IMAGEDIR/tmp.png" "$final_out"
        
        # Optimización de peso (< 1MB)
        if test (stat -c%s "$final_out") -gt 1048576
            echo " -> Optimizando peso de "(basename "$final_out")
            magick "$final_out" -strip -sampling-factor 4:2:0 -quality 85 -define jpeg:extent=980KB "$final_out"
        end
    end

    # 5. LIMPIEZA
    rm "$IMAGEDIR/tmp.svg" "$IMAGEDIR/tmp.png" "$IMAGEDIR/portada.jpg" "$IMAGEDIR/portada_sqr.jpg"
    echo ">>> Proceso completado para el episodio $NUMBER. Notas usadas: "(basename "$MD_FILE")
end
