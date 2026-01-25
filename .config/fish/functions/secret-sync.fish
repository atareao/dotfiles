function secret-sync --argument message
    set -l secrets_dir "$HOME/.secrets"
    
    if not test -d "$secrets_dir"
        echo "❌ El directorio $secrets_dir no existe."
        return 1
    end

    builtin cd $secrets_dir

    # 1. Intentar descargar cambios primero
    echo "🔄 Sincronizando con el remoto..."
    if not git pull --rebase origin main # Ajusta 'main' si tu rama se llama 'master'
        echo "⚠️ Error al descargar cambios. Resuelve los conflictos manualmente en $secrets_dir"
        builtin cd - >/dev/null
        return 1
    end

    # 2. Comprobar si hay algo nuevo que subir
    if test -n (git status --porcelain)
        git add .
        
        if test -z "$message"
            set message "Sync secrets: "(date "+%Y-%m-%d %H:%M:%S")
        end

        git commit -m "$message"
        
        if git push origin main
            echo "🚀 Sincronización completada: Cambios locales subidos."
        else
            echo "❌ Falló el push al remoto."
            builtin cd - >/dev/null
            return 1
        end
    else
        echo "✅ Todo estaba al día. No hay cambios locales para subir."
    end

    # Volvemos al directorio original
    popd
end
