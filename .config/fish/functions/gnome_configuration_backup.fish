function gnome_configuration_backup --description="create a backup of gnome configuration"
    if [ ! -d ~/.config/gnome/keybindings ]
        mkdir -p ~/.config/gnome/keybindings
    end
    dconf dump "/org/gnome/settings-daemon/plugins/media-keys/" > ~/.config/gnome/keybindings/media-keys.dconf
    dconf dump "/org/gnome/desktop/wm/keybindings/"             > ~/.config/gnome/keybindings/wm.dconf
    dconf dump "/org/gnome/shell/keybindings/"                  > ~/.config/gnome/keybindings/shell.dconf
    dconf dump "/org/gnome/mutter/keybindings/"                 > ~/.config/gnome/keybindings/mutter.dconf
    dconf dump "/org/gnome/mutter/wayland/keybindings/"         > ~/.config/gnome/keybindings/mutter-wayland.dconf
    if [ ! -d ~/.config/gnome/extensions ]
        mkdir -p ~/.config/gnome/extensions
    end
    dconf dump "/org/gnome/shell/extensions/"                   > ~/.config/gnome/extensions/extensions.dconf
    echo "backup done"
end
