function unjinja --description="Fill scripts"
    set STORE_PATH $(path normalize ~/.password-store)
    echo $STORE_PATH
    fd -g "*.gpg" $STORE_PATH | while read -l item
        set key $(string replace "$STORE_PATH/" "" $item | path change-extension '')
        set variable $(path basename $key | string upper)
        set -xg $variable "$(pass $key)"
    end
    yadm list -a | while read -l item
        if [ $(path extension $item) = ".jinja" ]
            set jinja $(path normalize ~/"$item")
            set output $(path change-extension '' "$jinja")
            jinrender --jinja "$jinja" --output "$output"
        end
    end
    fd -g "*.gpg" $STORE_PATH | while read -l item
        set key $(string replace "$STORE_PATH/" "" $item | path change-extension '')
        set variable $(path basename $key | string upper)
        set -e "$variable"
    end
end
