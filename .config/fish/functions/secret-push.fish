function secret-push --argument message
    set -l secrets_dir "$HOME/.secrets"
    
    if not test -d "$secrets_dir"
        echo "❌ No se encuentra el directorio $secrets_dir"
        return 1
    end

    # Entramos al directorio para operar con Git
    builtin cd $secrets_dir

    # Comprobamos si hay cambios (archivos modificados o nuevos)
    if test -n (git status --porcelain)
        git add .
        
        # Si no hay mensaje, usamos uno por defecto con la fecha
        if test -z "$message"
            set message "Update secrets: "(date "+%Y-%m-%d %H:%M:%S")
        end

        git commit -m "$message"
        echo "📦 Cambios registrados: $message"
        
        # Intentamos el push
        if git push
            echo "🚀 Secretos subidos correctamente."
        else
            echo "❌ Error al subir los cambios al remoto."
            return 1
        end
    else
        echo "✅ No hay cambios que subir. Todo limpio."
    end

    # Volvemos al directorio original
    popd
end
