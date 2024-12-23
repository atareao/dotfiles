function create_extension --description="create a gnome shell extension"
    if [ -f ./metadata.json ]
        set -x name $(cat ./metadata.json | jq -r ".name")
        set -x description $(cat ./metadata.json | jq -r ".description")
        set -x uuid $(cat ./metadata.json | jq -r ".uuid")
    else
        set -x name $(gum input --placeholder "name")
        set -x description $(gum input --placeholder "description")
        set -x uuid $(gum input --placeholder "uuid")
    end
    set -x owner $(git remote get-url origin | cut -d"/" -f1 | cut -d":" -f2)
    set -x project $(git remote get-url origin | cut -d"/" -f2 | cut -d"." -f1)
    set -x gs_version $(gnome-shell --version | cut -d" " -f3 | cut -d"." -f1)
    if [ $status -ne 0 ]
        exit
    end
    if [ ! -d "./assets" ]
        mkdir "./assets"
    end
    if [ ! -d "./dist" ]
        mkdir "./dist"
    end
    if [ ! -d "./icons" ]
        mkdir "./icons"
    end
    if [ ! -d "./schemas" ]
        mkdir "./schemas"
    end
    if [ ! -d "./src" ]
        mkdir "./src"
    end
    if [ ! -d "./tests" ]
        mkdir "./tests"
    end
    cp ~/.config/fish/functions/resources/.eslintrc.yml ./
    cp ~/.config/fish/functions/resources/.justfile ./
    cp ~/.config/fish/functions/resources/eslint.config.js ./
    cp ~/.config/fish/functions/resources/gnome.d.ts ./
    cp ~/.config/fish/functions/resources/metadata.json.in ./
    cp ~/.config/fish/functions/resources/package.json.in  ./
    cp ~/.config/fish/functions/resources/tsconfig.json  ./
    cp ~/.config/fish/functions/resources/stylesheet.css  ./
    cp ~/.config/fish/functions/resources/org.gnome.shell.extensions.name.gschema.xml.in  "./schemas/org.gnome.shell.extensions.$project.gschema.xml.in"
    jinrender --jinja ./metadata.json.in --output ./metadata.json
    rm ./metadata.json.in
    jinrender --jinja ./package.json.in --output ./package.json
    rm ./package.json.in
    jinrender --jinja "./schemas/org.gnome.shell.extensions.$project.gschema.xml.in" --output "./schemas/org.gnome.shell.extensions.$project.gschema.xml"
    rm "./schemas/org.gnome.shell.extensions.$project.gschema.xml.in"
end
