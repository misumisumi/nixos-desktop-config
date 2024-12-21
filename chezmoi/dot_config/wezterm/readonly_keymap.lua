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
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(copy_mode, {
        key = "c",
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(copy_mode, {
        key = "g",
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(copy_mode, {
        key = "q",
        mods = "NONE",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(search_mode, {
        key = "Escape",
        mods = "NONE",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(search_mode, {
        key = "c",
        mods = "CTRL|LEADER",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(search_mode, {
        key = "g",
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
    table.insert(search_mode, {
        key = "q",
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            os.execute("fcitx5-remote -g SKK")
            win:perform_action(act.CopyMode("Close"), pane)
        end),
    })
end

-- Use "SUPER" for Linux (qtile and xmonad cannot distinguish between left and right alt)
-- Use "RightAlt" for Windows/Mac (Windows and mac cannot be used because shortcuts are assigned to super key.)
local function with_mod()
    local mod = wezterm.target_triple == "x86_64-unknown-linux-gnu" and "SUPER" or "LEADER"
    return {
        { key = "+", mods = string.format("%s", mod), action = act.IncreaseFontSize },
        { key = "-", mods = string.format("%s", mod), action = act.DecreaseFontSize },
        {
            key = "/",
            mods = string.format("%s", mod),
            action = wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g EN")
                win:perform_action(act.Search("CurrentSelectionOrEmptyString"), pane)
            end),
        },
        { key = "f", mods = string.format("%s", mod), action = act.ScrollByPage(1) },
        { key = "b", mods = string.format("%s", mod), action = act.ScrollByPage(-1) },
        {
            key = "Enter",
            mods = string.format("SHIFT|%s", mod),
            action = act.SplitPane({ direction = "Right", size = { Percent = 30 } }),
        },
        {
            key = "Enter",
            mods = string.format("%s", mod),
            action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }),
        },
        { key = "Space", mods = string.format("%s", mod), action = act.TogglePaneZoomState },
        { key = "h", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Left") },
        { key = "j", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Down") },
        { key = "k", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Up") },
        { key = "l", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Right") },
        { key = "p", mods = string.format("%s", mod), action = act.ShowLauncher },
        { key = "q", mods = string.format("%s", mod), action = act.QuickSelect },
        {
            key = "s",
            mods = string.format("%s", mod),
            action = act.PaneSelect({ alphabet = "", mode = "SwapWithActive" }),
        },
        {
            key = "t",
            mods = string.format("%s", mod),
            action = act.SpawnCommandInNewTab({ domain = "CurrentPaneDomain", cwd = wezterm.home_dir }),
        },
        {
            key = "u",
            mods = string.format("%s", mod),
            action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
        },
        { key = "c", mods = string.format("CTRL|%s", mod), action = act.CloseCurrentPane({ confirm = true }) },
        { key = "w", mods = string.format("CTRL|%s", mod), action = act.CloseCurrentTab({ confirm = true }) },
        {
            key = "x",
            mods = string.format("%s", mod),
            action = wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g EN")
                win:perform_action(act.ActivateCopyMode, pane)
            end),
        },
    }
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
        { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
        { key = "=", mods = "CTRL", action = act.ResetFontSize },
        {
            key = "f",
            mods = "SHIFT|CTRL",
            action = wezterm.action_callback(function(win, pane)
                os.execute("fcitx5-remote -g EN")
                win:perform_action(act.Search("CurrentSelectionOrEmptyString"), pane)
            end),
        },
        { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
        { key = "Enter", mods = "CTRL", action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }) },
        {
            key = "Enter",
            mods = "SHIFT|CTRL",
            action = act.SplitPane({ direction = "Right", size = { Percent = 30 } }),
        },
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
        {
            key = "c",
            mods = "CTRL|LEADER",
            action = wezterm.action_callback(function(win, pane)
                win:perform_action(act.ScrollToBottom, pane)
                win:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
            end),
        },
        { key = "Space", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
        { key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
        { key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
        { key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
        { key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
        { key = "o", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
        { key = "q", mods = "CTRL|LEADER", action = act.QuickSelect },
        { key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
        { key = "s", mods = "CTRL|SHIFT", action = act.PaneSelect({ alphabet = "", mode = "SwapWithActive" }) },
        { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
        {
            key = "u",
            mods = "CTRL",
            action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
        },
        { key = "c", mods = "CTRL", action = act.CloseCurrentPane({ confirm = true }) },
        { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
        { key = '"', mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
        { key = "0", mods = "CTRL", action = act.ResetFontSize },
        {
            key = "D",
            mods = "CTRL|SHIFT",
            action = act.DetachDomain("CurrentPaneDomain"),
        },
    },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL",
        action = act.ActivateTab(i - 1),
    })
end

for _, v in ipairs(with_mod()) do
    table.insert(config.keys, v)
end

return config
