function secret-pull
    set -l secrets_dir "$HOME/.secrets"

    if not test -d "$secrets_dir"
        echo "❌ No se encuentra el directorio $secrets_dir"
        return 1
    end

    builtin cd $secrets_dir

    echo "📥 Sincronizando secretos desde el remoto..."
    if git pull --rebase
        echo "✅ Secretos actualizados."
    else
        echo "❌ Error al descargar los cambios. Revisa si hay conflictos."
        return 1
    end

    # Volvemos al directorio original
    popd
end
