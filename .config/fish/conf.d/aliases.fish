function enotas -d "Edit notes"
    z notas
    nvim root.md
end

function dv -d "Docker volume"
    for i in $argv
        set -a volumes "--volume" "$i:/$i"
    end
    if count $argv >/dev/null
        echo docker run -it --init --rm --name=dv $volumes busybox sh
        docker run -it --init --rm --name=dv $volumes busybox sh
    else
        echo docker run -it --init --rm --name=dv busybox sh
        docker run -it --init --rm --name=dv busybox sh
    end
end
