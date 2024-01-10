function ya --description="execute yazi"
    set TMP "$(mktemp -t 'yazi-cuwd.XXXXX')"
    yazi --cwd-file="$TMP" $argv
    set CWD "$(cat -- $TMP)"
    if test -n "$CWD"; and test "$CWD" != "$PWD"
        cd -- "$CWD"
    end
    rm -f -- "$TMP"
end
