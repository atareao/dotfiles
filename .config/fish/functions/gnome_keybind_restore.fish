function gnome_keybind_restore --description="restore a backup of gnome keybinds"
    if [ -d /data/gnome/keybindings ]
        dconf reset -f "/org/gnome/settings-daemon/plugins/media-keys/"
        dconf reset -f "/org/gnome/desktop/wm/keybindings/"
        dconf reset -f "/org/gnome/shell/keybindings/"
        dconf reset -f "/org/gnome/mutter/keybindings/"
        dconf reset -f "/org/gnome/mutter/wayland/keybindings/"

        dconf load "/org/gnome/settings-daemon/plugins/media-keys/" < /data/gnome/keybindings/media-keys.dconf
        dconf load "/org/gnome/desktop/wm/keybindings/"             < /data/gnome/keybindings/wm.dconf
        dconf load "/org/gnome/shell/keybindings/"                  < /data/gnome/keybindings/shell.dconf
        dconf load "/org/gnome/mutter/keybindings/"                 < /data/gnome/keybindings/mutter.dconf
        dconf load "/org/gnome/mutter/wayland/keybindings/"         < /data/gnome/keybindings/mutter-wayland.dconf
        echo "restore done"
    end
end
