function secret-add --argument key value
    set -l secrets_file "$HOME/.secrets/secrets.yml"

    if test -z "$key"; or test -z "$value"
        echo "Uso: add-secret <clave> <valor>"
        return 1
    end

    if not test -f "$secrets_file"
        # Si el archivo no existe, lo inicializamos como un YAML vacío
        echo "---" | sops -e /dev/stdin > "$secrets_file"
    end

    # Usamos --set para que SOPS gestione la inserción directamente
    # Esto evita depender de yq para la edición básica
    sops --set "[\"$key\"] \"$value\"" "$secrets_file"

    if test $status -eq 0
        echo "✅ Secreto '$key' añadido/actualizado correctamente."
    else
        echo "❌ Error al procesar el secreto."
        return 1
    end
end
