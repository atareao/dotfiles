function secret-rm --argument key
    set -l secrets_file "$HOME/.secrets/secrets.yml"

    if test -z "$key"
        echo "Uso: secret-rm <clave>"
        return 1
    end

    if not test -f "$secrets_file"
        echo "❌ El archivo de secretos no existe."
        return 1
    end

    # Usamos env para cambiar el EDITOR temporalmente.
    # El comando sed borrará cualquier línea que empiece por la clave.
    # 'sops' se encarga de descifrar, ejecutar este "editor" y volver a cifrar.
    env EDITOR="sed -i \"/^$key:/d\"" sops "$secrets_file"

    if test $status -eq 0
        echo "🗑️ Secreto '$key' eliminado (si existía)."
    else
        echo "❌ Error al intentar acceder al archivo con SOPS."
        return 1
    end
end
