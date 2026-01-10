function yadmalt --description="generate templates with pass variables"
    # set variables
    set -l store (set -q PASSWORD_STORE_DIR; and echo $PASSWORD_STORE_DIR; or echo $HOME/.password-store)
    if not test -d $store
        echo "Error: No se encontró el almacén de contraseñas en $store" >&2
        return 1
    end
    fd --extension gpg --base-directory $store | string replace -r '\.gpg$' '' | while read -l item
        set variable $(string replace \/ _ "$item" | string upper)
        echo $variable
        set -xg $variable "$(pass show $item)"
    end
    # configure templates
    yadm alt
    # unset variables
    fd --extension gpg --base-directory $store | string replace -r '\.gpg$' '' | while read -l item
        set variable $(string replace \/ _ "$item" | string upper)
        set -e "$variable"
    end
end
