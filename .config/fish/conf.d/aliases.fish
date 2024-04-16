function enotas -d "Edit notes"
    z notas
    nvim root.md
end

function dv -d "Docker volume"
    set volumes ""
    for i in $argv
        if test $volumes = ""
            set volumes "--volume" "$i:/$i"
        else
            set volume "--volume" "$i:/$i"
            set -a volumes $volume
        end
    end
    if count $argv >/dev/null
        echo docker run -it --init --rm --name=dv $volumes busybox sh
        docker run -it --init --rm --name=dv $volumes busybox sh
    else
        echo docker run -it --init --rm --name=dv busybox sh
        docker run -it --init --rm --name=dv busybox sh
    end
end
