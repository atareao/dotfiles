function secret-show
    set -l secret_name $argv[1]
    set -l store "$HOME/.secrets/secrets.yml"

    if test -z "$secret_name"
        echo "❌ Uso: show_pass <nombre_de_la_variable>"
        return 1
    end

    # Extraemos el valor usando sops y yq para asegurar que el output sea limpio
    set -l value (sops -d --extract "[\"$secret_name\"]" $store 2>/dev/null)

    if test $status -eq 0
        echo $value
        # Opcional: Copiar al portapapeles si usas xclip o wl-copy
        # echo $value | wl-copy 
        # echo "📋 ¡Copiado al portapapeles!"
    else
        echo "❌ No se encontró la clave '$secret_name' en $store"
    end
end
