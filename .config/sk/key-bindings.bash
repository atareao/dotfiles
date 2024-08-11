#!/usr/bin/env bash
# Key bindings
# CTRL + T fuzzy find files
# CTRL + R fuzzy find history
# ------------
# shellcheck disable=2120
__sk_select__() {
  local cmd="${SKIM_CTRL_T_COMMAND:-"fd --type f \
    || git ls-tree -r --name-only HEAD \
    || rg --files \
    || find . \\( -path '*/\\.*' \
    -o -fstype 'sysfs' \
    -o -fstype 'devfs' \
    -o -fstype 'devtmpfs' \
    -o -fstype 'proc' \\) \
    -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-100%} \
    --layout=reverse \
    $SKIM_DEFAULT_OPTIONS \
    $SKIM_CTRL_T_OPTS" $(__skcmd) \
    --preview='bat --style=plain --color=always --theme=ansi-dark  {}' \
    --preview-window=70%:wrap -m "$@" \
    | while read -r item; do
      printf "%q %q" "${EDITOR:-vi}" "$item"
    done
  echo
}

if [[ $- =~ i ]]; then
  __skcmd() {
    [ -n "$TMUX_PANE" ] && { [ "${SKIM_TMUX:-0}" != 0 ] || [ -n "$SKIM_TMUX_OPTS" ]; } &&
      echo "sk-tmux ${SKIM_TMUX_OPTS:--d${SKIM_TMUX_HEIGHT:-100%}} -- " || echo "sk"
}

sk-file-widget() {
    # shellcheck disable=2155
    local selected="$(__sk_select__)"
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

__sk_history__() {
    local output
    output=$(
      builtin fc -lnr -2147483648 |
        last_hist=$(HISTTIMEFORMAT='' builtin history 1) \
        perl -n -l0 \
        -e 'BEGIN { getc; $/ = "\n\t"; $HISTCMD = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCMD - $. . "\t$_" if !$seen{$_}++' \
        | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-25%} \
        --layout=reverse $SKIM_DEFAULT_OPTIONS \
        --tiebreak=score,index $SKIM_CTRL_R_OPTS \
        -m --read0" $(__skcmd) \
        --query "$READLINE_LINE"
    ) || return
    READLINE_LINE=${output#*$'\t'}
    if [ -z "$READLINE_POINT" ]; then
      echo "$READLINE_LINE"
    else
      READLINE_POINT=0x7fffffff
    fi
}
# Required to refresh the prompt after sk
bind -m emacs-standard '"\er": redraw-current-line'
bind -m vi-command '"\C-z": emacs-editing-mode'
bind -m vi-insert '"\C-z": emacs-editing-mode'
bind -m emacs-standard '"\C-z": vi-editing-mode'

if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    # CTRL-T - Paste the selected file path into the command line
    # shellcheck disable=SC2016
    bind -m emacs-standard '"\C-t": " \C-b\C-k \C-u`__sk_select__`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
    bind -m vi-command '"\C-t": "\C-z\C-t\C-z"'
    bind -m vi-insert '"\C-t": "\C-z\C-t\C-z"'
    # CTRL-R - Paste the selected command from history into the command line
    # shellcheck disable=SC2016
    bind -m emacs-standard '"\C-r": "\C-e \C-u\C-y\ey\C-u"$(__sk_history__)"\e\C-e\er"'
    bind -m vi-command '"\C-r": "\C-z\C-r\C-z"'
    bind -m vi-insert '"\C-r": "\C-z\C-r\C-z"'
else
    # CTRL-T - Paste the selected file path into the command line
    bind -m emacs-standard -x '"\C-t": sk-file-widget'
    bind -m vi-command -x '"\C-t": sk-file-widget'
    bind -m vi-insert -x '"\C-t": sk-file-widget'
    # CTRL-R - Paste the selected command from history into the command line
    bind -m emacs-standard -x '"\C-r": __sk_history__'
    bind -m vi-command -x '"\C-r": __sk_history__'
    bind -m vi-insert -x '"\C-r": __sk_history__'
  fi
fi
