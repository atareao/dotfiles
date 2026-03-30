function transcribe --description 'Transcribe un audio usando Whisper con soporte CUDA'
    # 1. Verificación de dependencias
    if not command -v whisper > /dev/null
        set_color red; echo "Error: whisper-ai no está instalado. Instálalo con 'pip install openai-whisper'."; set_color normal
        return 1
    end

    # 2. Verificación de argumento
    if test (count $argv) -lt 1
        set_color yellow; echo "Uso: transcribe <archivo_audio>"; set_color normal
        return 1
    end

    set -l input $argv[1]

    # 3. Validaciones de archivo
    if not test -f "$input"
        set_color red; echo "Error: El archivo '$input' no existe."; set_color normal
        return 1
    end

    set_color cyan; echo "🤖 Iniciando transcripción con Whisper..."; set_color normal
    set_color blue; echo "📄 Archivo: $input"
    echo "⚙️  Configuración: Modelo Medium | CUDA | Idioma: Español"; set_color normal

    # 4. Ejecución de Whisper
    # Nota: Usamos --output_dir . para asegurar que se guarde en la carpeta actual
    if whisper --device cuda \
               --language Spanish \
               --model medium \
               --output_format srt \
               --task transcribe \
               --output_dir . \
               "$input"

        set_color green; echo "✓ Transcripción completada con éxito."
        
        # Obtener el nombre del archivo generado para el feedback
        set -l srt_file (string replace -r '\.[^.]+$' '.srt' $input)
        echo "💾 Subtítulos generados en: $srt_file"; set_color normal

        # Notificación de escritorio
        if command -v notify-send > /dev/null
            notify-send "Whisper finalizado" "La transcripción de $input ha terminado."
        end
    else
        set_color red; echo "X Error durante la transcripción. Comprueba el estado de los drivers de NVIDIA/CUDA."; set_color normal
        return 1
    end
end
