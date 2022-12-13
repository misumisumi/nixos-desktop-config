local utils = require("utils")
local global = require("core.global")
local data_dir = global.data_dir


local settings = {
    use_ssh = true,
    packer_dir = utils.joinpath(data_dir, "pack", "packer", "opt", "packer.nvim"),
    packer_compiled = utils.joinpath(data_dir, "packer", "_compiled.lua"),
    backup_compiled = utils.joinpath(data_dir, "packer", "_compiled.lua.backup"),
    -- format_on_save = true,
    -- format_disabled_dirs = {
    --     utils.joinpath(utils.get_home(), "format_disabled_dir_under_home")
    -- }
}

return settings
