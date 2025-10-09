bind -M insert \eh prevd-or-backward-word
bind -M insert \el nextd-or-forward-word
bind -M visual \eh prevd-or-backward-word
bind -M visual \el nextd-or-forward-word
bind -M default \eh prevd-or-backward-word
bind -M default \el nextd-or-forward-word

bind -M default / history-pager
bind -M insert \cr history-pager
