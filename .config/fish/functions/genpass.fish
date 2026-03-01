function genpass --description "Genera una contraseña aleatoria usando OpenSSL"
    # Definimos el argumento con un valor por defecto
    set -l length 32
    
    # Si el usuario pasa un argumento, actualizamos la variable
    if test (count $argv) -gt 0
        set length $argv[1]
    end

    # Generamos la contraseña
    # Usamos base64 y cortamos a la longitud exacta deseada
    openssl rand -base64 $length | head -c $length
    
    # Añadimos un salto de línea al final para que no se pegue al prompt
    echo "" 
end

