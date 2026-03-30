#!/usr/bin/fish

function check_scope -a scope
    set -l cmd systemctl
    set -l j_scope ""
    if test "$scope" = "--user"
        set cmd systemctl --user
        set j_scope "--user"
    end

    # Obtenemos las unidades, limpiamos el punto (●) y filtramos solo .service
    set -l units ($cmd list-units --type=service --all --no-legend | awk '{print $1}' | string match -v "●" | string match "*.service")

    for unit in $units
        # Verificamos si es realmente un servicio de Podman/Quadlet mediante su descripción o dependencias
        if $cmd show $unit --property=Description,Wants,Requires | string match -rq "podman|quadlet"
            
            set -l state ($cmd is-active $unit)
            
            set -l color (set_color red)
            if test "$state" = "active"; set color (set_color green); end
            
            # Buscamos errores en las últimas 24h
            set -l errors (journalctl $j_scope -u $unit --since "-24h" -p 3..0 | wc -l)
            
            set -l err_color (set_color normal)
            if test "$errors" -gt 0; set err_color (set_color --bold red); end

            printf "[%-7s] %-45s %s%-10s%s Errores: %s%s%s\n" \
                (string replace -- "--" "" $scope) $unit $color $state (set_color normal) $err_color $errors (set_color normal)
        end
    end
end

function check_quadlets --description "Revisa el estado de los servicios de los Quadlets "
    echo (set_color --bold blue)"=== Reporte de Salud de Quadlets ==="(set_color normal)
    check_scope --system
    check_scope --user
end
