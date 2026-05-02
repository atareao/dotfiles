#!/usr/bin/env fish

# ==============================================================================
# SCRIPT: ollama-import.fish
# DESCRIPCIÓN: Importa modelos GGUF a Ollama (en Podman) con contexto personalizado.
# USO: ./ollama-import.fish archivo.gguf nombre-modelo contexto
# ==============================================================================

function ollama-import --argument gguf_file model_name ctx_value
    # 1. Verificación de argumentos
    if test -z "$gguf_file"; or test -z "$model_name"
        set_color red; echo "❌ Error: Faltan argumentos."
        set_color yellow; echo "Uso: ollama-import <archivo.gguf> <nombre-modelo> [contexto]"
        echo "Ejemplo: ollama-import mi_modelo.gguf super-ia 32768"
        set_color normal; return 1
    end

    # Contexto por defecto si no se indica
    if test -z "$ctx_value"
        set ctx_value 8192
    end

    # 2. Comprobar si el archivo existe
    if not test -f "$gguf_file"
        set_color red; echo "❌ Error: El archivo $gguf_file no existe."; set_color normal
        return 1
    end

    set -l container_name "ollama" # Cambia esto si tu contenedor se llama distinto

    set_color blue; echo "🚀 Iniciando importación de $model_name..."

    # 3. Copiar GGUF al contenedor
    echo "📦 Copiando GGUF al contenedor (esto puede tardar)..."
    if not podman cp "$gguf_file" "$container_name:/root/temp_model.gguf"
        set_color red; echo "❌ Error al copiar el archivo."; set_color normal
        return 1
    end

    # 4. Crear Modelfile dentro del contenedor
    echo "📝 Generando Modelfile con contexto de $ctx_value tokens..."
    set -l modelfile_content "FROM /root/temp_model.gguf\nPARAMETER num_ctx $ctx_value\nPARAMETER num_gpu -1"
    printf $modelfile_content | podman exec -i $container_name tee /root/temp_Modelfile > /dev/null

    # 5. Ejecutar ollama create
    echo "🏗️  Creando el modelo en Ollama..."
    if podman exec -it $container_name ollama create $model_name -f /root/temp_Modelfile
        set_color green; echo "✅ ¡Modelo '$model_name' creado con éxito!"
    else
        set_color red; echo "❌ Error al crear el modelo en Ollama."
    end

    # 6. Limpieza final
    echo "🧹 Limpiando archivos temporales..."
    podman exec -it $container_name rm /root/temp_model.gguf /root/temp_Modelfile
    set_color normal; echo "✨ Proceso finalizado."
end

# Ejecutamos la función
ollama-import $argv
