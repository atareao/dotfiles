function secret-ls
    set -l secrets_file "$HOME/.secrets/secrets.yml"

    if not test -f "$secrets_file"
        echo "❌ El archivo de secretos no existe."
        return 1
    end

    echo "🔑 Claves en $secrets_file:"
    echo "--------------------------------"

    # 1. Desciframos con sops
    # 2. Usamos yq para obtener solo las claves (keys)
    # 3. Aplicamos un formato de lista con un guión
    sops -d $secrets_file 2>/dev/null | yq 'keys | .[]' | sed 's/^/- /'

    if test $status -ne 0
        echo "❌ Error al leer los secretos. Revisa la configuración de SOPS/age."
        return 1
    end
    
    echo "--------------------------------"
end
