local utils = require("utils")
local global = require("core.global")
local data_dir = global.data_dir


local settings = {
    use_ssh = true,
    packer_dir = utils.joinpath(data_dir, "pack", "packer", "opt", "packer.nvim"),
    compiled_dir = utils.joinpath(data_dir, "lua"),
    packer_compiled = utils.joinpath(data_dir, "lua", "_compiled.lua"),
    backup_compiled = utils.joinpath(data_dir, "lua", "_compiled.lua.backup"),
}

return settings
