local os = require("os")
local wezterm = require("wezterm")
local act = wezterm.action

local copy_mode = nil
local search_mode = nil
if wezterm.gui then
    copy_mode = wezterm.gui.default_key_tables().copy_mode
    search_mode = wezterm.gui.default_key_tables().search_mode
    table.insert(copy_mode, {
        key = "Escape",
        mods = "NONE",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
    table.insert(copy_mode, {
        key = "c",
        mods = "CTRL",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
    table.insert(copy_mode, {
        key = "g",
        mods = "CTRL",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
    table.insert(copy_mode, {
        key = "q",
        mods = "NONE",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
    table.insert(search_mode, {
        key = "Escape",
        mods = "NONE",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
    table.insert(search_mode, {
        key = "c",
        mods = "CTRL|LEADER",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
    table.insert(search_mode, {
        key = "g",
        mods = "CTRL",
        action = act.Multiple({
            wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g skk")
            end),
            act.CopyMode("Close"),
        }),
    })
end

local config = {
    disable_default_key_bindings = true,
    leader = { key = "c", mods = "CTRL", timeout_milliseconds = 1000 },
    key_tables = {
        copy_mode = copy_mode,
        search_mode = search_mode,
    },
    keys = {
        { key = "%", mods = "SHIFT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
        { key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
        {
            key = "/",
            mods = "CTRL",
            action = wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g EN")
                win:perform_action(act.Search("CurrentSelectionOrEmptyString"), pane)
            end),
        },
        { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
        { key = "Enter", mods = "CTRL", action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }) },
        { key = "Enter", mods = "SHIFT|CTRL", action = act.SplitPane({ direction = "Right", size = { Percent = 30 } }) },
        { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
        { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
        { key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
        {
            key = "X",
            mods = "CTRL|SHIFT",
            action = wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g EN")
                win:perform_action(act.ActivateCopyMode, pane)
            end),
        },
        { key = "c", mods = "CTRL|LEADER", action = act.SendKey({ key = "c", mods = "CTRL" }) },
        { key = "Space", mods = "CTRL", action = act.TogglePaneZoomState },
        { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
        { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
        { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
        { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
        { key = "p", mods = "SHIFT|CTRL", action = act.ShowLauncher },
        { key = "q", mods = "CTRL|LEADER", action = wezterm.action.QuickSelect },
        { key = "s", mods = "CTRL|LEADER", action = act.PaneSelect({ alphabet = "", mode = "SwapWithActive" }) },
        { key = "t", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "u", mods = "CTRL", action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }) },
        { key = "w", mods = "CTRL|LEADER", action = act.CloseCurrentTab({ confirm = true }) },
        { key = '"', mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    },
}

for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL",
        action = act.ActivateTab(i - 1),
    })
end

return config
