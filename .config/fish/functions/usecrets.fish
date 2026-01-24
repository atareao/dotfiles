function usecrets --description="Unload secrets"
    set -l STORE $HOME/.secrets/secrets.yml
    if not test -f $store
        echo "Error: No se encontró el almacén de contraseñas en $store" >&2
        return 1
    end
    # unset variables
    set -e (sops -d $STORE | yq -r 'keys | .[] | select(. != "sops") | ascii_upcase')
    echo "🧹 Secreto descargados"
end
