default:
    @just --choose

install:
    #!/bin/bash
    if [[ ! -d fast-syntax-highlighting ]]; then
        git clone git@github.com:zdharma-zmirror/fast-syntax-highlighting.git
    else
        echo "fast-syntax-highlighting is already installed"
    fi
    if [[ ! -d zsh-autosuggestions ]]; then
        git clone git@github.com:zsh-users/zsh-autosuggestions.git
    else
        echo "zsh-autosuggestions is already installed"
    fi
    if [[ ! -d zsh-completions ]]; then
        git clone git@github.com:zsh-users/zsh-completions.git
    else
        echo "completions is already installed"
    fi

update:
    find . -maxdepth 1 \
           -mindepth 1 \
           -type d \
           -not \( -path ./atareao -prune \) \
           -not \( -path ./custom-completions -prune \) \
           -printf "%P\n" \
           -exec git \
           --git-dir={}/.git \
           --work-tree=$PWD/{} pull  \;
