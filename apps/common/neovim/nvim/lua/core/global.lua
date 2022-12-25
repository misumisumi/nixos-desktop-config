local utils = require("utils")
local global = {}


function global:load_variables()
    self.is_linux, self.is_mac, self.is_windows = utils.check_os()
    self.is_wsl = vim.fn.has("wsl") == 1
    local home = utils.get_home()
    self.vim_path = vim.fn.stdpath("config")
    self.cache_dir = utils.joinpath(home, ".cache", "nvim")
    self.data_dir = utils.joinpath(vim.fn.stdpath("data"), "site")
    self.modules_dir = utils.joinpath(self.vim_path, "lua", "modules")
    self.state_dir = vim.fn.stdpath("state")
    self.home = home
end

global:load_variables()

return global
