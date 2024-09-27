local color_scheme = "Catppuccin Mocha"
local wezterm = require("wezterm")
local tab_col = wezterm.color.get_builtin_schemes()[color_scheme].tab_bar

return {
    color_scheme = color_scheme,

    colors = {
        tab_bar = {
            new_tab = {
                fg_color = tab_col.inactive_tab.fg_color,
                bg_color = tab_col.inactive_tab.bg_color,
            },
        },
    },
}
