function gnome_keybind_backup --description="create a backup of gnome keybinds"
    if [ ! -d /data/gnome/keybindings ]
        mkdir -p /data/gnome/keybindings
    end
    dconf dump "/org/gnome/settings-daemon/plugins/media-keys/" > /data/gnome/keybindings/media-keys.dconf
    dconf dump "/org/gnome/desktop/wm/keybindings/"             > /data/gnome/keybindings/wm.dconf
    dconf dump "/org/gnome/shell/keybindings/"                  > /data/gnome/keybindings/shell.dconf
    dconf dump "/org/gnome/mutter/keybindings/"                 > /data/gnome/keybindings/mutter.dconf
    dconf dump "/org/gnome/mutter/wayland/keybindings/"         > /data/gnome/keybindings/mutter-wayland.dconf
    echo "backup done"
end
