function watch_rust_project
    echo "Monitoreando el proyecto Rust..."
    # Usamos watchexec para detectar cambios en la carpeta src/
    inotifywait -m -r -e close_write src/ | while read -l directory events filename
        notify-send "Cambios, Cambios!!!"
        emit rust_file_changed
    end
end

function handle_build --on-event rust_file_changed
    notify-send "Building..."
    if cargo build --release
        notify-send Build
        set -l bin_path "./target/release/mi_mcp_skill"
        emit build_success $bin_path
    else
        emit build_failure $status
    end
end

function update_container --on-event build_success
    set -l bin_path $argv[1]
    notify-send "Actualizando contenedor Podman con $bin_path..."

    # Comandos de Podman para copiar el binario y reiniciar
    if podman cp $bin_path mcp_container:/usr/local/bin/
        podman restart mcp_container
        emit deployment_complete Producción
    else
        emit warning_me
    end
end

function log_deployment --on-event deployment_complete
    set -l entorno $argv[1]
    echo "[$(date)] Despliegue exitoso en $entorno" >>~/dev_history.log
    notify-send "[$(date)] Despliegue exitoso en $entorno"
end

function warning_me --on-event build_failure
    notify-send "Algo pasó"
end
