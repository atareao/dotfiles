function unjinja --description="Fill scripts"
    set -l STORE $HOME/.secrets/secrets.yml
    if not test -f $store
        echo "Error: No se encontró el almacén de contraseñas en $store" >&2
        return 1
    end
    sops -d $STORE | yq -r 'to_entries | .[] | select(.key != "sops") | ((.key | ascii_upcase) + " " + (.value | tostring))' | while read -l key value
        echo "✅ Loading $key"
        set -gx $key $value
    end
    echo "🚀 Secretos cargados"
    yadm list -a | while read -l item
        if [ $(path extension $item) = ".jinja" ]
            set jinja $(path normalize ~/"$item")
            set output $(path change-extension '' "$jinja")
            jinrender --jinja "$jinja" --output "$output"
        end
    end
    echo "📝 Templates configurados"
    # unset variables
    set -e (sops -d $STORE | yq -r 'keys | .[] | select(. != "sops") | ascii_upcase')
    echo "🧹 Secreto descargados"
end
