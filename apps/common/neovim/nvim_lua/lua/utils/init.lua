local vim = vim
local uv = vim.loop
local os_name = vim.loop.os_uname().sysname
local sep = (os_name == "Windows_NT") and "\\" or "/"

local utils = {}


function utils.get_home()
    return (os_name == "Windows_NT") and os.getenv("USERPROFILE") or os.getenv("HOME")
end


function utils.get_ext(path)
    return path:match("^.+(%..+)$")
end


function utils.joinpath(...)
    local arg = {...}
    local path = ""
    for i,v in ipairs(arg) do
        if i == 1 then
            path = v
        else
            path = path .. sep .. v
        end
    end

    if utils.get_ext(path) == nil then
        return path .. sep
    else
        return path
    end
end


function utils.path_exists(path)
    return vim.loop.fs_stat(path) ~= nil
end


function utils.mkdir(path, mode)
    mode = mode == nil and 755 or mode
    uv.fs_mkdir(path, mode, function()
        assert(true, ("Failed to mkdir %s!"):format(path))
    end)
    -- if not utils.path_exists(path) then
    --     os.mkdir(path)
    -- end
end


function utils.check_os()
    local is_linux = os_name == "Linux"
    local is_mac = os_name == "Darwin"
    local is_windows = os_name == "Windows_NT"

    return is_linux,is_mac,is_windows
end


function utils.load_plugin(plugins)
    if type(plugins) == "string" then
        vim.api.nvim_command(("packadd %s"):format(plugins))
    else
        for _,plugin in ipairs(plugins) do
            vim.api.nvim_command(("packadd %s"):format(plugin))
        end
    end
end

return utils
