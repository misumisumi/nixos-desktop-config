local wezterm = require("wezterm")
local color_set = require("color-set")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local function tab_title(tab_info)
        local title = tab_info.tab_title
        -- if the tab title is explicitly set, take that
        if title and #title > 0 then
            return title
        end
        -- Otherwise, use the title from the active pane
        -- in that tab
        return tab_info.active_pane.title
    end
    -- The filled in variant of the < symbol
    local SOLID_LEFT_ARROW = ""

    -- The filled in variant of the > symbol
    local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

    local edge_background = color_set.bg_tab
    local right_edge_background = nil
    local background = color_set.bg_tab
    local foreground = color_set.fg_tab
    local zoomed = ""
    local extra_pad = 0
    if tab.active_pane.is_zoomed then
        zoomed = "[Z] "
        extra_pad = 4
    end
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
    local title = tab_title(tab)
    title = " " .. zoomed .. tab.tab_index .. " " .. wezterm.truncate_right(title, max_width - 5 - extra_pad) .. " "

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

wezterm.on("update-status", function(window, pane)
    -- Each element holds the text for a cell in a "powerline" style << fade
    local cells = {}

    -- Figure out the cwd and host of the current pane.
    -- This will pick up the hostname for the remote host if your
    -- shell is using OSC 7 on the remote host.
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
        local hostname = ""

        if type(cwd_uri) == "userdata" then
            -- Running on a newer version of wezterm and we have
            -- a URL object here, making this simple!
            hostname = cwd_uri.host or wezterm.hostname()
        else
            -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
            -- which doesn't have the Url object
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find("/")
            if slash then
                hostname = cwd_uri:sub(1, slash - 1)
            end
        end

        -- Remove the domain name portion of the hostname
        local dot = hostname:find("[.]")
        if dot then
            hostname = hostname:sub(1, dot - 1)
        end
        if hostname == "" then
            hostname = wezterm.hostname()
        end

        table.insert(cells, hostname)
    end

    -- I like my date/time in this style: "Wed Mar 3 08:14"
    local date = wezterm.strftime("%a %b %-d %H:%M")
    table.insert(cells, date)

    -- Color palette for the backgrounds of each cell
    local colors = {
        color_set.bg_tab,
        color_set.bg_active,
    }

    -- The elements to be formatted
    local elements = {}
    -- How many cells have been formatted
    local num_cells = 0

    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    table.insert(elements, { Foreground = { Color = colors[1] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    -- Translate a cell into elements
    local function push(text, is_last)
        local color_no = num_cells % 2 == 0 and 1 or 2
        table.insert(elements, { Foreground = { Color = color_set.fg } })
        table.insert(elements, { Background = { Color = colors[color_no] } })
        table.insert(elements, { Text = " " .. text .. " " })
        if not is_last then
            table.insert(elements, { Foreground = { Color = colors[color_no % 2 + 1] } })
            table.insert(elements, { Text = SOLID_LEFT_ARROW })
        end
        num_cells = num_cells + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
    end

    window:set_right_status(wezterm.format(elements))
end)
