if status is-interactive
    # Commands to run in interactive sessions can go here
    # starship
    starship init fish | source
    # atuin
    atuin init fish | source
    # zoxide
    zoxide init fish | source
end
