function prewav --description 'Optimiza un WAV para Audacity usando normalización de 2 pasos'
    if not command -v ffmpeg > /dev/null
        set_color red; echo "Error: ffmpeg no está instalado."; set_color normal
        return 1
    end

    if test (count $argv) -lt 1
        set_color yellow; echo "Uso: prewav <archivo.wav>"; set_color normal
        return 1
    end

    set -l archivo $argv[1]
    if not test -f "$archivo"
        set_color red; echo "Error: El archivo '$archivo' no existe."; set_color normal
        return 1
    end

    set -l nombre_base (string replace -r '\.[^.]+$' '' $archivo)
    set -l archivo_enhanced "$nombre_base"_enhanced.wav

    set_color blue; echo "🔍 Paso 1: Analizando sonoridad de $archivo..."; set_color normal

    # Definimos los filtros previos comunes (limpieza)
    set -l filtros_previos "adeclip, asoftclip, highpass=f=80, agate=threshold=-30dB:ratio=2:attack=20:release=200"

    # PASO 1: Análisis (obtenemos el JSON de loudnorm)
    set -l stats (ffmpeg -i "$archivo" -af "$filtros_previos, loudnorm=I=-14:TP=-1.5:print_format=json" -f null - 2>&1 | \
                  sed -n '/{/,/}/p')

    # Extraemos las variables del JSON usando string match/replace (estilo Fish)
    set -l m_i (echo $stats | string match -r '"input_i" : "([^"]+)"' | tail -n 1)
    set -l m_lra (echo $stats | string match -r '"input_lra" : "([^"]+)"' | tail -n 1)
    set -l m_tp (echo $stats | string match -r '"input_tp" : "([^"]+)"' | tail -n 1)
    set -l m_thresh (echo $stats | string match -r '"input_thresh" : "([^"]+)"' | tail -n 1)

    if test -z "$m_i"
        set_color red; echo "X Falló el análisis de audio. Reintentando con método simple..."; set_color normal
        set -l loudnorm_cmd "loudnorm=I=-14:TP=-1.5"
    else
        set_color cyan; echo "📊 Stats detectadas: I: $m_i | LRA: $m_lra | TP: $m_tp"; set_color normal
        set -l loudnorm_cmd "loudnorm=I=-14:TP=-1.5:measured_I=$m_i:measured_LRA=$m_lra:measured_TP=$m_tp:measured_thresh=$m_thresh:linear=true"
    end

    set_color blue; echo "🚀 Paso 2: Procesado final -> $archivo_enhanced"; set_color normal

    # PASO 2: Aplicación real
    ffmpeg -i "$archivo" \
           -af "$filtros_previos, $loudnorm_cmd" \
           -ac 1 \
           -ar 48000 \
           -c:a pcm_s16le \
           "$archivo_enhanced" -y

    if test $status -eq 0
        set_color green; echo "✓ Episodio arreglado con éxito a -14 LUFS."; set_color normal
    else
        set_color red; echo "X Error crítico en el procesado."; set_color normal
        return 1
    end
end
