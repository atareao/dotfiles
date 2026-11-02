function transcribe --description 'Transcribe uno o varios audios a SRT usando Whisper'
    # 0. Parseo de argumentos
    set -l options 'h/help' 'm/model=' 'l/language=' 'f/force'
    argparse -n transcribe $options -- $argv
    or return 1

    if set -q _flag_help
        echo 'Uso: transcribe [OPCIONES] ARCHIVO_AUDIO...'
        echo
        echo 'Transcribe uno o varios audios a subtítulos .srt en el directorio actual.'
        echo
        echo 'Opciones:'
        echo '  -h, --help             Muestra esta ayuda y sale.'
        echo '  -m, --model MODELO     Modelo de Whisper (tiny, base, small, medium, large, turbo).'
        echo '                         Por defecto: $WHISPER_MODEL si está definida, o "turbo".'
        echo '  -l, --language IDIOMA  Idioma del audio (p. ej. es, en). Por defecto: es.'
        echo '  -f, --force            Sobrescribe el .srt si ya existe.'
        echo
        echo 'Ejemplos:'
        echo '  transcribe podcast.mp3'
        echo '  transcribe -m small -l en charla.mp3 entrevista.mp4'
        echo '  WHISPER_MODEL=medium transcribe -f reunion.wav'
        return 0
    end

    # 1. Verificación de dependencias
    if not command -v whisper > /dev/null
        set_color red; echo "✗ Error: openai-whisper no está instalado. Instálalo con 'pip install openai-whisper'."; set_color normal
        return 1
    end
    if not command -v ffmpeg > /dev/null
        set_color red; echo "✗ Error: ffmpeg no está instalado y Whisper lo necesita para leer el audio."; set_color normal
        set_color yellow; echo "  Instálalo con el gestor de paquetes de tu distribución (p. ej. 'sudo apt install ffmpeg')."; set_color normal
        return 1
    end

    # 2. Modelo e idioma (modelo: -m > $WHISPER_MODEL > turbo)
    set -l model turbo
    if set -q WHISPER_MODEL; and test -n "$WHISPER_MODEL"
        set model $WHISPER_MODEL
    end
    if set -q _flag_model
        set model $_flag_model
    end

    set -l language es
    if set -q _flag_language
        set language $_flag_language
    end

    # 3. Verificación de argumentos
    if test (count $argv) -lt 1
        set_color yellow; echo "Uso: transcribe [OPCIONES] ARCHIVO_AUDIO..."; set_color normal
        set_color yellow; echo "Ayuda: transcribe --help"; set_color normal
        return 1
    end

    # 4. Cabecera con la configuración realmente en uso
    set_color cyan; echo "🤖 Iniciando transcripción con Whisper..."; set_color normal
    set_color blue
    echo "⚙️  Modelo: $model | Idioma: $language | Dispositivo: auto (cuda si disponible)"
    set_color normal

    # 5. Procesado de cada fichero (uno problemático no aborta el resto)
    set -l ok 0
    set -l skipped 0
    set -l failed 0

    for input in $argv
        set_color blue; echo "📄 Archivo: $input"; set_color normal

        # 5.1 Validaciones del fichero de entrada
        if not test -f "$input"
            set_color red; echo "✗ Error: el archivo '$input' no existe o no es un fichero regular."; set_color normal
            set failed (math $failed + 1)
            continue
        end
        if not test -r "$input"
            set_color red; echo "✗ Error: el archivo '$input' no se puede leer (permisos)."; set_color normal
            set failed (math $failed + 1)
            continue
        end

        # 5.2 Whisper, con --output_dir ., escribe el .srt en el DIRECTORIO ACTUAL
        #     usando SOLO el basename del audio sin extensión (y le añade .srt).
        #     Calculamos esa ruta real para no mentir en el mensaje.
        set -l srt (path change-extension srt (path basename -- $input))

        # 5.3 Guarda de sobrescritura
        if test -e "$srt"; and not set -q _flag_force
            set_color yellow; echo "⏭  Omitido: '$srt' ya existe. Usa -f/--force para sobrescribirlo."; set_color normal
            set skipped (math $skipped + 1)
            continue
        end

        # 5.4 Comprobación previa de que el fichero es audio legible
        if command -v ffprobe > /dev/null
            set -l probe (ffprobe -v error -select_streams a:0 -show_entries stream=codec_type -of csv=p=0 -- "$input" 2>&1)
            set -l probe_status $status
            if test $probe_status -ne 0; or test -z "$(string join '' $probe)"
                set_color red; echo "✗ Error: '$input' no parece un audio legible (ffprobe falló)."; set_color normal
                if test (count $probe) -gt 0
                    set_color red; printf '%s\n' $probe | tail -n 5; set_color normal
                end
                set failed (math $failed + 1)
                continue
            end
        end

        # 5.5 Ejecución de Whisper (dispositivo por defecto: cuda si hay GPU, si no CPU)
        #     Mostramos el progreso en vivo con tee y a la vez lo guardamos en un
        #     temporal para poder imprimir las últimas líneas si algo falla.
        #     El código de salida que nos interesa es el de whisper ($pipestatus[1]).
        echo "⏳ Transcribiendo '$input'..."
        set -l log_file (mktemp)
        whisper --model $model --language $language --output_format srt --output_dir . -- "$input" 2>&1 | tee $log_file
        set -l code $pipestatus[1]
        set -l log (cat $log_file)
        command rm -f $log_file

        # 5.6 Verificación REAL del resultado: no basta con que whisper salga con 0
        if test $code -ne 0
            set_color red; echo "✗ Error durante la transcripción de '$input' (whisper salió con $code)."; set_color normal
            if test (count $log) -gt 0
                set_color red; printf '%s\n' $log | tail -n 5; set_color normal
            end
            set failed (math $failed + 1)
            continue
        end
        if not test -s "$srt"
            set_color red; echo "✗ Error: Whisper terminó sin errores pero '$srt' no existe o está vacío."; set_color normal
            if test (count $log) -gt 0
                set_color red; printf '%s\n' $log | tail -n 5; set_color normal
            end
            set failed (math $failed + 1)
            continue
        end

        set_color green; echo "✓ Transcripción completada: $srt"; set_color normal
        set ok (math $ok + 1)
    end

    # 6. Resumen único por notificación y exit code
    set_color cyan; echo "📊 Resumen: $ok correctos | $skipped omitidos | $failed fallidos"; set_color normal

    if command -v notify-send > /dev/null
        notify-send "Whisper: transcripción finalizada" "$ok correctos, $skipped omitidos, $failed fallidos."
    end

    if test $failed -gt 0
        return 1
    end
    return 0
end
