fish_add_path -g ~/.cargo/bin ~/.local/bin ~/go/bin/ ~/bin /usr/local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    # remove welcome message
    set -g fish_greeting
    # set TERM
    set -g TERM wezterm
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
end

# pnpm
set -gx PNPM_HOME "/home/lorenzo/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
