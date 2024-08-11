
# rgi() {
#     command rg --hidden --files-with-matches --no-heading --color "always" "$@" | xargs rg --color "always" "$@"
# }
 
rgf() {
    local file
    file=$(rg --files --hidden --no-ignore --no-messages --follow --glob "!.git" 2> /dev/null | fzf +m -q "$1" --preview "bat --style=numbers --color=always {} 2> /dev/null | head -500")
    if [[ -n "$file" ]]; then
        bat --style=numbers --color=always "$file"
    fi
}

