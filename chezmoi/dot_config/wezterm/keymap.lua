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
        mods = "CTRL|LEADER",
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
    local keymaps_ctrl_as_mod = function(mod)
        return {
            -- easy split pane
            {
                key = "Enter",
                mods = string.format("%s", mod),
                action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }),
            },
            {
                key = "Enter",
                mods = string.format("%s|SHIFT", mod),
                action = act.SplitPane({ direction = "Right", size = { Percent = 30 } }),
            },
            -- cycle tabs
            { key = "Tab", mods = string.format("%s", mod), action = act.ActivateTabRelative(1) },
            { key = "Tab", mods = string.format("%s|SHIFT", mod), action = act.ActivateTabRelative(-1) },
        }
    end
    local keymaps_ctrl_shift_as_mod = function(mod)
        return {
            -- spawn new tab
            {
                key = "t",
                mods = string.format("%s", mod),
                action = act.SpawnCommandInNewTab({ domain = "CurrentPaneDomain", cwd = wezterm.home_dir }),
            },
            -- navigations
            { key = "h", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Left") },
            { key = "j", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Down") },
            { key = "k", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Up") },
            { key = "l", mods = string.format("%s", mod), action = act.ActivatePaneDirection("Right") },
            {
                key = "s",
                mods = string.format("%s", mod),
                action = act.PaneSelect({ alphabet = "", mode = "SwapWithActive" }),
            },
            { key = "b", mods = string.format("%s", mod), action = act.ScrollByPage(-1) },
            { key = "f", mods = string.format("%s", mod), action = act.ScrollByPage(1) },
            -- zoom pane
            { key = "Space", mods = string.format("%s", mod), action = act.TogglePaneZoomState },
            -- detach domain
            {
                key = "d",
                mods = string.format("%s", mod),
                action = act.DetachDomain("CurrentPaneDomain"),
            },
        }
    end
    local keymaps_leader_as_mod = function(mod)
        return {
            -- reload configuration
            { key = "r", mods = string.format("%s", mod), action = act.ReloadConfiguration },
            -- toggle tools
            { key = "o", mods = string.format("%s", mod), action = act.ShowDebugOverlay },
            { key = "p", mods = string.format("%s", mod), action = act.ShowLauncher },
            { key = "/", mods = string.format("%s", mod), action = act.QuickSelect },
            {
                key = "x",
                mods = string.format("%s", mod),
                action = wezterm.action_callback(function(win, pane)
                    os.execute("fcitx5-remote -g EN")
                    win:perform_action(act.ActivateCopyMode, pane)
                end),
            },
            {
                key = "z",
                mods = string.format("%s", mod),
                action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
            },
        }
    end
    local keymaps_ctrl_leader_as_mod = function(mod)
        -- close pane/tab
        return {
            { key = "q", mods = string.format("%s", mod), action = act.CloseCurrentPane({ confirm = true }) },
        }
    end
    local keymaps_shift_leader_as_mod = function(mod)
        return {
            -- spawn new tab
            { key = "T", mods = string.format("%s", mod), action = act.SpawnTab("CurrentPaneDomain") },
            -- tmux like split pane
            {
                key = "%",
                mods = string.format("%s", mod),
                action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
            },
            {
                key = '"',
                mods = string.format("%s", mod),
                action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
            },
            { key = "Q", mods = string.format("%s", mod), action = act.CloseCurrentTab({ confirm = true }) },
            {
                key = "?",
                mods = string.format("%s", mod),
                action = wezterm.action_callback(function(win, pane)
                    os.execute("fcitx5-remote -g EN")
                    win:perform_action(act.Search("CurrentSelectionOrEmptyString"), pane)
                end),
            },
        }
    end
    local keymaps = keymaps_ctrl_as_mod("CTRL")
    for _, v in ipairs(keymaps_ctrl_shift_as_mod("CTRL|SHIFT")) do
        table.insert(keymaps, v)
    end
    for _, v in ipairs(keymaps_leader_as_mod("LEADER")) do
        table.insert(keymaps, v)
    end
    for _, v in ipairs(keymaps_ctrl_leader_as_mod("LEADER|CTRL")) do
        table.insert(keymaps, v)
    end
    for _, v in ipairs(keymaps_shift_leader_as_mod("LEADER|SHIFT")) do
        table.insert(keymaps, v)
    end
    local function check_desktop_session()
        local session = os.getenv("DESKTOP_SESSION") or ""
        local not_use_super_session = { "xsession", "wayland" }
        for _, v in ipairs(not_use_super_session) do
            if string.find(session, v) then
                return true
            end
        end
        return false
    end
    if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
        local mod = "ALT"
        if check_desktop_session() then
            mod = "SUPER"
        end
        for _, v in ipairs(keymaps_ctrl_as_mod(mod)) do
            table.insert(keymaps, v)
        end
        for _, v in ipairs(keymaps_ctrl_shift_as_mod(mod)) do
            table.insert(keymaps, v)
        end
        for _, v in ipairs(keymaps_leader_as_mod(mod)) do
            table.insert(keymaps, v)
        end
        for _, v in ipairs(keymaps_ctrl_leader_as_mod(mod)) do
            table.insert(keymaps, v)
        end
        for _, v in ipairs(keymaps_shift_leader_as_mod(string.format("SHIFT|%s", mod))) do
            table.insert(keymaps, v)
        end
    end

    return keymaps
end

local config = {
    disable_default_key_bindings = true,
    leader = { key = "c", mods = "CTRL", timeout_milliseconds = 1000 },
    key_tables = {
        copy_mode = copy_mode,
        search_mode = search_mode,
    },
    keys = {
        -- common keymaps
        -- font size
        { key = "+", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
        { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
        { key = "=", mods = "CTRL", action = act.ResetFontSize },
        { key = "=", mods = "CTRL|SHIFT", action = act.ResetFontSize }, -- for jp key
        -- clipboard
        { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
        { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
        -- C-c passthrough
        {
            key = "c",
            mods = "CTRL|LEADER",
            action = wezterm.action_callback(function(win, pane)
                win:perform_action(act.ScrollToBottom, pane)
                win:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
            end),
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
