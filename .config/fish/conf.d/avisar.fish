function avisar --on-event tarea_completada
    # Recibe argumentos pasados por el emit
    set -l nombre_tarea $argv[1]
    set -l estado $argv[2]

    echo "--- [Notificación del Sistema] ---"
    echo "La tarea '$nombre_tarea' finalizó con estado: $estado"

    # Podrías incluso usar un comando de escritorio
    notify-send "Tarea terminada" "$nombre_tarea: $estado"
end
