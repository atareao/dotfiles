#!/usr/bin/env bash

function new_typescript(){
    NAME="$1"
    if [[ -z "$NAME" ]]; then
        exit 1
    fi
    mkdir -p "$NAME"/{src,build}
    cd "$NAME" || exit
    cp ~/.config/zsh/plugins/atareao/typescript_resources/package.json ./
    sed -i "s/\$NAME/${NAME}/g" ./package.json
    npm install @stylistic/eslint-plugin-ts \
                @typescript-eslint/eslint-plugin \
                @typescript-eslint/parser \
                eslint \
                eslint-config-standard-with-typescript \
                eslint-plugin-import \
                eslint-plugin-n \
                eslint-plugin-promise \
                typescript \
                --save-dev
    cp ~/.config/zsh/plugins/atareao/typescript_resources/tsconfig.json ./
    cp ~/.config/zsh/plugins/atareao/typescript_resources/.eslintrc.js ./
    cp ~/.config/zsh/plugins/atareao/typescript_resources/.justfile ./
    cp ~/.config/zsh/plugins/atareao/typescript_resources/app.ts ./src/app.ts
}
