function scale --description 'Convierte imagen a JPG, escala por IA y renombra por episodio'
    set -l input_file $argv[1]
    set -l ep_number $argv[2]

    if test (count $argv) -ne 2
        echo "Uso: scale_episode <archivo> <numero_episodio>"
        return 1
    end

    # --- PASO 1: Conversión inicial a JPG ---
    set -l tmp_jpg "tmp_processing_$ep_number.jpg"
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
    # 16:9 está entre 170 y 185
    if test $ratio_int -ge 170; and test $ratio_int -le 185
        set final_name "episode-$ep_number.jpg"
        if test "$width" -lt 1920; or test "$height" -lt 1080
            set needs_upscale 1
            set target_w 1920
            set target_h 1080
        end

    # 1:1 está entre 95 y 105
    else if test $ratio_int -ge 95; and test $ratio_int -le 105
        set final_name "episode-$ep_number-sqr.jpg"
        if test "$width" -lt 2000; or test "$height" -lt 2000
            set needs_upscale 1
            set target_w 2000
            set target_h 2000
        end
    else
        echo "Aviso: Ratio detectado ($ratio_int). No es ni 16:9 ni 1:1."
        set final_name "episode-$ep_number-orig.jpg"
    end

    # --- PASO 4: Escalado y salida ---
    if test "$needs_upscale" -eq 1
        echo "Escalando con Real-ESRGAN -> $final_name"
        set -l tmp_esrgan "tmp_esrgan_$ep_number.png"
        
        if realesrgan-ncnn-vulkan -i "$tmp_jpg" -o "$tmp_esrgan" -s 2
            # El "!" fuerza el tamaño exacto
            magick "$tmp_esrgan" -resize "$target_w"x"$target_h!" "$final_name"
            rm "$tmp_esrgan"
            echo "¡Procesado y reescalado con éxito!"
        else
            echo "Error en Real-ESRGAN, guardando sin escalar."
            mv "$tmp_jpg" "$final_name"
        end
    else
        mv "$tmp_jpg" "$final_name"
        echo "Imagen final: $final_name (no requería escala)"
    end

    # --- PASO 5: Redimensionado ---
    set -l max_bytes 1048576 # 1MB exacto
    set -l current_bytes (stat -c%s "$final_name")

    if test $current_bytes -gt $max_bytes
        echo "Reduciendo peso: $current_bytes bytes detectados..."
        
        # Intento 1: Compresión estándar optimizada
        magick "$final_name" -strip -sampling-factor 4:2:0 -quality 95 "$final_name"
        
        # Verificación opcional
        set -l new_size (stat -c%s "$final_name")
        echo "Nuevo peso: $new_size bytes"
    end

    # Limpieza final de temporales por si acaso
    if test -f "$tmp_jpg"; rm "$tmp_jpg"; end
end
