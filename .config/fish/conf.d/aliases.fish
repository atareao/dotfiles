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

function ycom -d "yadm git commit with chatgpt"
    yadm commit -am "$(dime -i "Eres un fantástico desarrollador, especializado en gestionar proyectos con control de versiones" -q "genera un mensaje conciso para un `git commit` que resuma los cambios producidos en ```$(yadm -P diff)```. Solo me tienes que dar el mensaje, ni la descripción, ni una explicación. Únicamente un mensaje en español, que comience con un gitmoji y sin comillas")"
end

function ypus -d "yadm push"
    yadm push
end

function yadd -d "yadm add"
    yadm add $argv
end

function ypul -d "yadm pull"
    yadm pull
end

function ysta -d "yadm status"
    yadm status
end


function gcom -d "git commit with chatgpt"
    git commit -am "$(dime -i "Eres un fantástico desarrollador, especializado en gestionar proyectos con control de versiones" -q "genera un mensaje conciso para un `git commit` que resuma los cambios producidos en ```$(git -P diff)```. Solo me tienes que dar el mensaje, ni la descripción, ni una explicación. Únicamente un mensaje en español, que comience con un gitmoji y sin comillas")"
end

function gpus -d "git push"
    git push
end

function gadd -d "git add"
    git add $argv
end

function gpul -d "git pull"
    git pull
end

function gsta -d "git status"
    git status
end

function gmer -d "git merge --no-edit --no-ff development"
    git switch main
    git merge --no-edit --no-ff development
    git push
    git switch development
end

function gc -d "gemini-cli-interactive"
    gemini -m "gemini-2.5-flash" -yp "$argv"
end

function gcli -d "gemini-cli"
    gemini -m "gemini-2.5-flash" -yp
end


