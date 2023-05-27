local wezterm = require 'wezterm';
return {
    enable_wayland = true,
    window_background_opacity = 0.90,
    font = wezterm.font({
        family="JetBrains Mono",
        harfbuzz_features={"calt=1", "clig=1", "liga=1"}
    }),
    font_size = 13,
    color_scheme = "ayu",
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        {key="c", mods="CTRL|ALT", action=wezterm.action{CopyTo="ClipboardAndPrimarySelection"}},
        {key="v", mods="CTRL|ALT", action = act.PasterFrom "PrimarySelection"}
    },
    mouse_bindings = {
        {event={Up={streak=1, button="Right"}}, mods="NONE", action=wezterm.action{PasteFrom="PrimarySelection"}},
    },
    ssh_domains = {
        {
            name = "gk55",
            remote_address = "gk55",
            username = "lorenzo"
        }
    }
}
