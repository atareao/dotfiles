function gnome_keybind_restore --description="restore a backup of gnome keybinds"
    if [ -d /.config/gnome/keybindings ]
        dconf reset -f "/org/gnome/settings-daemon/plugins/media-keys/"
        dconf reset -f "/org/gnome/desktop/wm/keybindings/"
        dconf reset -f "/org/gnome/shell/keybindings/"
        dconf reset -f "/org/gnome/mutter/keybindings/"
        dconf reset -f "/org/gnome/mutter/wayland/keybindings/"

        dconf load "/org/gnome/settings-daemon/plugins/media-keys/" < /.config/gnome/keybindings/media-keys.dconf
        dconf load "/org/gnome/desktop/wm/keybindings/"             < /.config/gnome/keybindings/wm.dconf
        dconf load "/org/gnome/shell/keybindings/"                  < /.config/gnome/keybindings/shell.dconf
        dconf load "/org/gnome/mutter/keybindings/"                 < /.config/gnome/keybindings/mutter.dconf
        dconf load "/org/gnome/mutter/wayland/keybindings/"         < /.config/gnome/keybindings/mutter-wayland.dconf
    end
    if [ -d /.config/gnome/extensions ]
        dconf reset -f "/org/gnome/shell/extensions/"
        dconf load "/org/gnome/shell/extensions/"                   < /.config/gnome/extensions/extensions.dconf
    echo "restore done"
end
