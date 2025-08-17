fish_add_path -g ~/.cargo/bin ~/.local/bin ~/go/bin/ ~/bin /usr/local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    # remove welcome message
    set -g fish_greeting
    # set TERM
    set -g TERM kitty
    # set starship config
    set -g STARSHIP_CONFIG ~/.config/starship/starship.toml
    # Theme
    fish_config theme choose "ayu Mirage"
    # starship
    starship init fish | source
    # atuin
    atuin init fish | source
    # zoxide
    zoxide init fish | source
    # direnv
    direnv hook fish | source
    # uv
    uv generate-shell-completion fish | source
end

# pnpm
set -gx PNPM_HOME "/home/lorenzo/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/lorenzo/.lmstudio/bin
# End of LM Studio CLI section

