function ollama-audit --description 'Compara contexto actual vs máximo soportado'
    printf "%-25s %-12s %-12s\n" "MODELO" "ACTUAL" "MÁXIMO"
    printf "%-25s %-12s %-12s\n" "------" "------" "------"

    for model in (curl -s http://localhost:11434/api/tags | jq -r '.models[].name')
        set -l details (curl -s -X POST http://localhost:11434/api/show -d "{\"name\": \"$model\"}")
        
        # 1. Extraer contexto ACTUAL (de los parámetros)
        set -l actual (echo $details | jq -r '.parameters' | string match -r 'num_ctx\s+(\d+)' | string split -m1 " " --fields 2)
        if test -z "$actual"; set actual "4096*"; end

        # 2. Extraer contexto MÁXIMO (de model_info)
        # Usamos un truco de jq para buscar cualquier clave que termine en .context_length
        set -l max (echo $details | jq -r '.model_info | to_entries[] | select(.key | endswith(".context_length")) | .value')
        if test -z "$max"; set max "Desconocido"; end

        printf "%-25s %-12s %-12s\n" $model $actual $max
    end
    echo "* Asterisco indica valor por defecto de Ollama"
end
