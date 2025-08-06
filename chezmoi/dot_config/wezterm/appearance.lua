local wezterm = require("wezterm")

local config = {
    window_close_confirmation = "AlwaysPrompt",
    font = wezterm.font_with_fallback({
        {
            family = "Moralerspace Neon NF",
            weight = "Regular",
            harfbuzz_features = { "liga", "calt", "ss01", "ss06", "ss07", "ss08", "ss09" },
        },
        "FiraCode Nerd Font Mono",
    }),
    font_size = 10.0,
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
    front_end = "WebGpu",
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
