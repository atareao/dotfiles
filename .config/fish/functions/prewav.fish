function prewav --description 'Optimiza un WAV para Audacity: repara, pasa a mono y genera un archivo _enhanced'
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

    # Definición de nombres
    set -l nombre_base (string replace -r '\.[^.]+$' '' $archivo)
    set -l archivo_enhanced "$nombre_base"_enhanced.wav

    set_color blue; echo "🚀 Procesando: $archivo -> $archivo_enhanced"; set_color normal

    # Ejecución principal con asoftclip y 48kHz
    ffmpeg -i "$archivo" \
           -af "adeclip, asoftclip, highpass=f=80, agate=threshold=-30dB:ratio=2:attack=20:release=200, loudnorm=I=-16:TP=-1.5" \
           -ac 1 \
           -ar 48000 \
           -c:a pcm_s16le \
           "$archivo_enhanced" -y

    if test $status -eq 0
        set_color green; echo "✓ Proceso finalizado con éxito."
        echo "📦 Original mantenido: $archivo"
        echo "📦 Resultado mejorado: $archivo_enhanced"; set_color normal
    else
        set_color red; echo "X Error en FFmpeg. Reintentando sin asoftclip..."; set_color normal
        
        # Reintento de emergencia (manteniendo los 48kHz)
        ffmpeg -i "$archivo" \
               -af "adeclip, highpass=f=80, agate=threshold=-30dB, loudnorm=I=-16" \
               -ac 1 \
               -ar 48000 \
               -c:a pcm_s16le \
               "$archivo_enhanced" -y
        
        if test $status -eq 0
             set_color green; echo "✓ Finalizado (sin asoftclip)"; set_color normal
             echo "📦 Resultado mejorado: $archivo_enhanced"
        else
             set_color red; echo "X Error crítico: No se pudo procesar el archivo."; set_color normal
             test -f "$archivo_enhanced"; and rm "$archivo_enhanced"
             return 1
        end
    end
end
