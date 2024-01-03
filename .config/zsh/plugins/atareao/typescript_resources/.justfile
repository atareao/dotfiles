# lista todos los comandos
default:
    just --list
# ejecuta el linter sobre los archivos TypeScript
lint: 
    eslint --ext .ts "./**/*.ts"
# resuelve los errores de aplicar el linter
fix:
    eslint --ext .ts "./**/*.ts" --fix
# compila de TypeScript a JavaScript
build:
    tsc
# ejecuta la aplicación una vez comilada
run:
    node build/app.js
# inicia el servicio
start:
    npm start
# instala un paquete de forma local
install package:
    npm install {{ package }}
# desinstala un paquete local
uninstall package:
    npm until {{package}}

