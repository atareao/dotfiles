function notas -d "Edit notas"
    set current_dir $PWD
    cd /data/notas/
    nvim index.md
    cd $current_dir
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
    yadm commit -am "$(dime -i "Eres un fantástico desarrollador, especializado en gestionar proyectos con control de versiones" -q "genera un mensaje conciso para un `git commit` que resuma los cambios producidos en ```$(yadm -P diff --cached)```. Solo me tienes que dar el mensaje, ni la descripción, ni una explicación. Únicamente un mensaje en español, que comience con un gitmoji y sin comillas")"
end


function gcom -d "git commit with chatgpt"
    git add .;git commit -am "$(dime -i "Eres un fantástico desarrollador, especializado en gestionar proyectos con control de versiones" -q "genera un mensaje conciso para un `git commit` que resuma los cambios producidos en ```$(git -P diff --cached)```. Solo me tienes que dar el mensaje, ni la descripción, ni una explicación. Únicamente un mensaje en español, que comience con un gitmoji y sin comillas")"
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


