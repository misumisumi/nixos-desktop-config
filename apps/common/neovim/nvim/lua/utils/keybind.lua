local rhs_options = {}


local function split(str, delim)
    if str:find(delim) == nil then
        return { str }
    end
    local result = {}
    local pat = "(.-)" .. delim .."()"
    local last_pos
    for part,pos in str:gmatch(pat) do
        table.insert(result, part)
        last_pos = pos
    end
    table.insert(result, str:sub(last_pos))

    return result
end


function rhs_options:new()
    local instance = {
        cmd = "",
        options = {
            expr = false,
            remap = false,
            nowait = false,
            silent = false,
            buffer = false,
            desc = false,
        },
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end


function rhs_options:map_args(cmd_string)
    self.cmd = (":%s<Space>"):format(cmd_string)
    return self
end


function rhs_options:map_cmd(cmd_string)
    self.cmd = cmd_string
    return self
end


function rhs_options:map_cr(cmd_string)
    self.cmd = (":%s<CR>"):format(cmd_string)
    return self
end


function rhs_options:map_cu(cmd_string)
    -- 範囲指定の数字を削除した後コマンド実行
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    return self
end


function rhs_options:with_expr()
    self.options.expr = true
    return self
end


function rhs_options:with_remap()
    self.options.remap = true
    return self
end


function rhs_options:with_nowait()
    self.options.nowait = true
    return self
end


function rhs_options:with_silent()
    self.options.silent = true
    return self
end


function rhs_options:with_buffer(num)
    self.options.buffer = num
    return self
end


function rhs_options:with_desc(str)
    self.options.desc = str
    return self
end


local pbind = {}


function pbind.map_args(cmd_string)
    local ro = rhs_options:new()
    return ro:map_args(cmd_string)
end


function pbind.map_cmd(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cmd(cmd_string)
end


function pbind.map_cr(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cr(cmd_string)
end


function pbind.map_cu(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cu(cmd_string)
end


function pbind.nvim_load_mapping(mapping)
    for key, value in pairs(mapping) do
        local mode, keymap = key:match("([^|]*)|?(.*)")
        mode = split(mode, ",")
        if type(value) == "table" then
            local rhs = value.cmd
            local options = value.options
            vim.keymap.set(mode, keymap, rhs, options)
            -- if buf then
            --     vim.api.nvim_buf_set_keymap(buf, mode, keymap, rhs, options)
            -- else
            --     vim.api.nvim_set_keymap(mode, keymap, rhs, options)
            -- end
        end
    end
end


return pbind
