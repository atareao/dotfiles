function ya
    set TMP "$(mktemp -t 'yazi-cuwd.XXXXX')"
    set CWD "$PWD"
    yazi "$argv" --cwd-file="$TMP"
    set CWD "$(cat -- '$TMP')"
    if [[ -n "$CWD" ]] and [[ "$CWD" != "$PWD" ]]
        cd -- "$CWD"
    end
    rm -f -- "$TMP"
end
