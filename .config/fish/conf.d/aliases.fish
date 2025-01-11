function enotas -d "Edit notes"
    z notas
    nvim root.md
end

function activate
    source .venv/bin/activate.fish
end

function dv -d "Docker volume"
    for i in $argv
        set -a volumes "--volume" "$i:/$i"
    end
    if count $argv >/dev/null
        docker run -it --init --rm --name=dv $volumes busybox sh
    else
        docker run -it --init --rm --name=dv busybox sh
    end
end

function gcom -d "git commit with chatgpt"
    git commit -am "$(dime -i "Eres un fantástico desarrollador, especializado en gestionar proyectos con control de versiones" -q "genera un mensaje conciso para un `git commit` que resuma los cambios producidos en ```$(git -P diff)```. Solo me tienes que dar el mensaje, ni la descripción, ni una explicación. Únicamente un mensaje en español, que comience con un gitmoji y sin comillas")"
end

function gpush -d "git push"
    git push
end

function gadd -d "git add"
    git add $argv
end

function gpull -d "git pull"
    git pull
end

function gstat -d "git status"
    git status
end

function gmerge -d "git merge --no-edit --no-ff development"
    git switch main
    git merge --no-edit --no-ff development
    git push
    git switch development
end
