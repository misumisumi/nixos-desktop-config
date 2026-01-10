local wezterm = require("wezterm")

local config = {
    audible_bell = "Disabled",
    window_close_confirmation = "AlwaysPrompt",
    font = wezterm.font_with_fallback({
        {
            family = "Moralerspace Neon",
            weight = "Regular",
            harfbuzz_features = { "liga", "calt", "ss01", "ss06", "ss07", "ss08", "ss09" },
        },
        "FiraCode Nerd Font Mono",
    }),
    font_size = wezterm.target_triple:match("darwin") ~= nil and 14 or 10,
    enable_scroll_bar = true,
    window_padding = {
        left = 0,
        right = "1cell",
        top = 0,
        bottom = 0,
    },

    window_background_opacity = 0.92, -- For non linux
    inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.4,
    },

    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    tab_max_width = 16,
    default_cwd = wezterm.home_dir,
    quick_select_patterns = {
        "(?<=[\\(|{|`|'|\"])[^[\\(|{|`|'|\"][\\)|}|`|'|\"]]+(?=[\\)|}|`|'|\"])",
    },
    front_end = "OpenGL",
}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "powershell.exe", "-NoLogo" }
end

return config
