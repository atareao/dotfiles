local wezterm = require 'wezterm';
local act = wezterm.action
return {
    enable_wayland = true,
    window_background_opacity = 0.90,
    font = wezterm.font_with_fallback({
      -- /usr/share/fonts/TTF/JetBrainsMonoNerdFontMono-Regular.ttf, FontConfig
      -- AKA: "JetBrainsMono NFM"
      {family="JetBrainsMono Nerd Font Mono", harfbuzz_features={"calt=1", "clig=1", "liga=1"}},
      -- /usr/share/fonts/TTF/JetBrainsMono-Regular.ttf, FontConfig
      "JetBrains Mono",
      -- /usr/share/fonts/noto/NotoColorEmoji.ttf, FontConfig
      -- Assumed to have Emoji Presentation
      -- Pixel sizes: [128]
      "Noto Color Emoji",
      -- /usr/share/fonts/TTF/SymbolsNerdFontMono-Regular.ttf, FontConfig
      "Symbols Nerd Font Mono",
    }),
    -- font = wezterm.font({
    --     family="JetBrainsMono Nerd Font Mono",
    --     harfbuzz_features={"calt=1", "clig=1", "liga=1"}
    -- }),
    font_size = 12,
    color_scheme = "Ayu Dark (Gogh)",
    use_fancy_tab_bar = true,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    warn_about_missing_glyphs = true,
    keys = {
        {key="c", mods="CTRL|ALT", action=act{CopyTo="ClipboardAndPrimarySelection"}},
        {key="v", mods="CTRL|ALT", action=act{PasteFrom="PrimarySelection"}},
        {key="t", mods="SHIFT|ALT", action=act{SpawnTab="CurrentPaneDomain"}},
        {key="%", mods="CTRL|SHIFT|ALT", action=act.SplitHorizontal{domain="CurrentPaneDomain"}},
        {key="t", mods="CTRL|SUPER", action=act{SpawnTab="CurrentPaneDomain"}},
        {key="t", mods="CTRL|SUPER|ALT", action=act.CloseCurrentTab{confirm = true}},
        {key="1", mods="CTRL|SUPER", action=act{ActivateTab=0}},
        {key="2", mods="CTRL|SUPER", action=act{ActivateTab=1}},
        {key="3", mods="CTRL|SUPER", action=act{ActivateTab=2}},
        {key="4", mods="CTRL|SUPER", action=act{ActivateTab=3}},
        {key="5", mods="CTRL|SUPER", action=act{ActivateTab=4}},
        {key="6", mods="CTRL|SUPER", action=act{ActivateTab=5}},
        {key="7", mods="CTRL|SUPER", action=act{ActivateTab=6}},
        {key="8", mods="CTRL|SUPER", action=act{ActivateTab=7}},
        {key="9", mods="CTRL|SUPER", action=act{ActivateTab=8}},
        {key="0", mods="CTRL|SUPER", action=act{ActivateTab=9}},
        {key="-", mods="CTRL|SUPER|ALT", action=act{SplitVertical={domain="CurrentPaneDomain"}}},
        {key="|", mods="CTRL|SUPER", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="-", mods="CTRL|SUPER", action=act.DecreaseFontSize},
        {key="+", mods="CTRL|SUPER", action=act.IncreaseFontSize},
        {key="c", mods="CTRL|SUPER", action=act.ResetFontSize},
        {key="h", mods="CTRL|SUPER", action=act{ActivatePaneDirection="Left"}},
        {key="l", mods="CTRL|SUPER", action=act{ActivatePaneDirection="Right"}},
        {key="j", mods="CTRL|SUPER", action=act{ActivatePaneDirection="Up"}},
        {key="k", mods="CTRL|SUPER", action=act{ActivatePaneDirection="Down"}},
        {key="h", mods="CTRL|SUPER|ALT", action=act{AdjustPaneSize={"Left", 1}}},
        {key="l", mods="CTRL|SUPER|ALT", action=act{AdjustPaneSize={"Right", 1}}},
        {key="j", mods="CTRL|SUPER|ALT", action=act{AdjustPaneSize={"Up", 1}}},
        {key="k", mods="CTRL|SUPER|ALT", action=act{AdjustPaneSize={"Down", 1}}},
        {key="p", mods="CTRL|SUPER|ALT", action=act.CloseCurrentPane {confirm= true}},
        {key="w", mods="CTRL|SUPER", action=act.SpawnWindow},
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
