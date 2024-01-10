function yadmalt --description="generate templates with gopass variables"
    # set variables
    gopass list --flat | while read -l item
        set variable $(string replace \/ _ "$item" | string upper)
        echo $variable
        set -xg $variable "$(gopass show --password $item)"
    end
    # configure templates
    yadm alt
    # unset variables
    gopass list --flat | while read -l item
        set variable $(string replace \/ _ "$item" | string upper)
        set -e "$variable"
    end
end
