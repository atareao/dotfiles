function load_pass --description="Load pass"
    set STORE_PATH $(path normalize ~/.password-store)
    echo $STORE_PATH
    fd -g "*.gpg" $STORE_PATH | while read -l item
        set key $(string replace "$STORE_PATH/" "" $item | path change-extension '')
        set variable $(string upper $key | string replace "/" "_")
        echo "Setting $variable"
        set -xg $variable "$(pass $key)"
    end
end
