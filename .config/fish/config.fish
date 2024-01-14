fish_add_path -g ~/.cargo/bin ~/.local/bin ~/go/bin/ ~/bin /usr/local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    # remove welcome message
    set -g fish_greeting
    # Theme
    fish_config theme choose "ayu Mirage"
    # starship
    starship init fish | source
    # atuin
    atuin init fish | source
    # zoxide
    zoxide init fish | source
end
