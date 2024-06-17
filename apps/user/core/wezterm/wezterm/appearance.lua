local wezterm = require("wezterm")
local color_set = require("color-set")

local config = {
    window_close_confirmation = "AlwaysPrompt",
    color_scheme = "tokyonight-storm",
    colors = {
        compose_cursor = "cyan",
        tab_bar = {
            background = color_set.bg,
            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = color_set.bg,
                fg_color = color_set.fg,
            },
            new_tab_hover = {
                bg_color = color_set.bg_tab,
                fg_color = color_set.fg_tab,
                italic = true,
            },
        },
    },
    -- color_scheme = "Catppuccin Mocha",
    font = wezterm.font_with_fallback({
        {
            family = "Moralerspace Neon NF",
            weight = "Regular",
            harfbuzz_features = {'liga','calt', 'ss01',  'ss06', 'ss07', 'ss08', 'ss09'}
        },
        "FiraCode Nerd Font Mono",
    }),
    font_size = 10.0,
    enable_scroll_bar = true,
    window_padding = {
        left = 0,
        right = 2,
        top = 0,
        bottom = 0,
    },

    window_background_opacity = 0.8, -- For non linux
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
}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "powershell.exe", "-NoLogo" }
end

-- Set "WebGpu" as frontend when you can use "Vulkan".
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    if gpu.backend == "Vulkan" and gpu.device_type == "IntegratedGpu" then
        config.webgpu_preferred_adapter = gpu
        config.front_end = "WebGpu"
        break
    end
end

return config
