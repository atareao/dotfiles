function ya
    set TMP "$(mktemp -t 'yazi-cuwd.XXXXX')"
    yazi --cwd-file="$TMP" $argv
    set CWD "$(cat -- $TMP)"
    if [ -n "$CWD" ]
        if [ "$CWD" != "$PWD" ]
            cd -- "$CWD"
        end
    end
    rm -f -- "$TMP"
end
