function unjinja --description="Fill scripts"
    set -l STORE $HOME/.secrets/secrets.yml
    if not test -f $STORE
        echo "Error: No se encontró el almacén de contraseñas en $STORE" >&2
        return 1
    end

    # 1. Carga de secretos
    sops -d $STORE | yq -r 'to_entries[] | select(.key != "sops") | [(.key | upcase), (.value | tostring)] | @tsv' | while read -l -d \t key value
        if test -n "$key"
            echo "✅ Loading $key"
            set -gx $key $value
        end
    end
    echo "🚀 Secretos cargados"

    # 2. Procesado de plantillas Jinja
    yadm list -a | while read -l item
        if test (path extension $item) = ".jinja"
            set -l jinja (path normalize ~/"$item")
            set -l output (path change-extension '' "$jinja")
            jinrender --jinja "$jinja" --output "$output"
        end
    end
    echo "📝 Templates configurados"

    # 3. Limpieza de variables (convertimos a mayúsculas usando string upper de Fish)
    set -l raw_keys (sops -d $STORE | yq -r 'keys[] | select(. != "sops")')
    if test -n "$raw_keys"
        set -l keys (string upper $raw_keys)
        set -e $keys
    end
    echo "🧹 Secretos descargados"
end
