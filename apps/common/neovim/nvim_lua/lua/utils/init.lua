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
        path = path .. sep .. v
    end

    if utils.get_ext(v) == nil then
        return path .. sep
    else
        return path
    end
end


function path_exists(path)
    return vim.loop.fs_stat(path) ~= nil
end


function utils.mkdir(path)
    if not path_exists(path) then
        os.mkdir(path)
    end
end


function utils.check_os()
    local is_linux = os_name == "Linux"
    local is_mac = os_name == "Darwin"
    local is_windows = os_name == "Windows_NT"

    return is_linux,is_mac,is_windows
end
