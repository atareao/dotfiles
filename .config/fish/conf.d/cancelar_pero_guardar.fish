function cancelar_pero_guardar
    set -l contenido (commandline)
    if test -n "$contenido"
        echo "$contenido" | wl-copy 2>/dev/null
        echo -e "\n"(set_color yellow)"󱘝 Guardado en portapapeles: $contenido"(set_color normal)
        sleep 0.4
    end
    commandline -r ""
    commandline -f repaint
end
