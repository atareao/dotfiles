local wezterm = require 'wezterm';
local act = wezterm.action
return {
    enable_wayland = true,
    window_background_opacity = 0.90,
    font = wezterm.font({
        family="JetBrainsMono Nerd Font Mono",
        harfbuzz_features={"calt=1", "clig=1", "liga=1"}
    }),
    font_size = 12,
    color_scheme = "Ayu Dark (Gogh)",
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    warn_about_missing_glyphs = false,
    keys = {
        {key="c", mods="CTRL|ALT", action=act{CopyTo="ClipboardAndPrimarySelection"}},
        {key="v", mods="CTRL|ALT", action=act{PasteFrom="PrimarySelection"}},
        {key="t", mods="SHIFT|ALT", action=act{SpawnTab="CurrentPaneDomain"}},
        {key="%", mods="CTRL|SHIFT|ALT", action=act.SplitHorizontal{domain="CurrentPaneDomain"}},
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
