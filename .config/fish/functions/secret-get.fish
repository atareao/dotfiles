function secret-get --argument key
    set -l secrets_file "$HOME/.secrets/secrets.yml"

    if test -z "$key"
        echo "Uso: secret-get <clave>"
        return 1
    end

    if not test -f "$secrets_file"
        echo "❌ El archivo de secretos no existe."
        return 1
    end

    # 1. Desciframos con sops y lo pasamos a yq
    # 2. yq extrae solo el valor de esa clave
    # 3. wl-copy lo pone en el portapapeles (-n elimina el salto de línea)
    set -l secret_value (sops -d $secrets_file | yq -r ".$key")

    if test -z "$secret_value"; or test "$secret_value" = "null"
        echo "❌ La clave '$key' no existe o está vacía."
        return 1
    end

    echo $secret_value | wl-copy -n

    if test $status -eq 0
        echo "📋 Secreto '$key' copiado al portapapeles."
    else
        echo "❌ Error al copiar al portapapeles. ¿Está instalado wl-clipboard?"
        return 1
    end
end
