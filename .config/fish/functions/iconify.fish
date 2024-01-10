function iconify --description="create base64 image"
    if test $(count $argv) -eq 1; and [ -f $argv[1] ]
        set output $(string replace -r '.png$' '.webp' $argv[1])
        cwebp "$argv[1]" -o "$output"
        set salida $(base64 < "$output" | tr -d '\n')
        rm -f "$output"
        echo "data:image/webp;base64,$salida"
    end
end
