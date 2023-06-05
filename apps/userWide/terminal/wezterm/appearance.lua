local wezterm = require("wezterm")

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = ""

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local color_set = {
    bg = "#282a36",
    fg = "#f8f8f2",
    bg_tab = "#44475a",
    fg_tab = "#f8f8f2",
    bg_active = "#6272a4",
    fg_active = "#f8f8f2",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local edge_background = color_set.bg_tab
    local right_edge_background = nil
    local background = color_set.bg_tab
    local foreground = color_set.fg_tab

    if tab.is_active then
        if tab.tab_index == (#tabs - 1) then
            edge_background = color_set.bg
        end
        background = color_set.bg_active
        foreground = color_set.fg_active
    elseif not tab.is_active then
        if tab.tab_index == (#tabs - 1) then
            edge_background = color_set.bg
            SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
        elseif (tab.tab_index + 1) <= (#tabs - 1) and not tabs[tab.tab_index + 2].is_active then
            edge_background = color_set.bg_tab
            right_edge_background = "#7aa2f7"
            SOLID_RIGHT_ARROW = utf8.char(0xe0b1)
        else
            edge_background = color_set.bg_active
            SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
        end
        background = color_set.bg_tab
        foreground = color_set.fg_tab
    elseif hover then
        background = "#3b3052"
        foreground = "#909090"
    end

    local edge_foreground = background
    if right_edge_background == nil then
        right_edge_background = background
    end

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    local title = " " .. tab.tab_index .. " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 5) .. " "

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = right_edge_background } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

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
        { family = "UDEV Gothic 35NFLG", weight = "Medium" },
        { family = "PlemolJP35 Console NFJ", weight = "Medium" },
        "FiraCode Nerd Font",
    }),
    font_size = 13.0,
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
    tab_max_width = 32,
    default_cwd = wezterm.home_dir,
    quick_select_patterns = {
        -- match things that look like sha1 hashes
        -- (this is actually one of the default patterns)
        -- "[0-9a-zA-Z]{7,40}",
        -- ".{1,80}.[a-z]+",
        "[[a-zA-Z0-9][!-~]+]{8,160}",
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