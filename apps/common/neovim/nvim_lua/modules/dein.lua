local utils = require("utils")

local dein_path = utils.home .. "/.cache/dein"
local dein_url="https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"

vim.opt.runtimepath:append(dein_path .. "/repos/github.com/Shougo/dein.vim")

-- dein.vimの自動インストール
if not utils.dir_exists("dein_path") then
    vim.fn.system(print("mkdir -p %s"))
    os.execute("mkdir -p " .. dein_path)
    os.execute(string.format("curl %s > %s/install.sh", dein_url, dein_dir))
    os.execute(string.format("sh %s/install.sh %s", dein_path, dein_path))
end

-- プラグインの読み込み
-- tomlは起動時読み込み、lazy_tomlは遅延読み込み
if vim.fn["dein#load_state"](dein_path) then
    vim.fn["dein#begin"](dein_path)

    vim.g.rc_dir = vim.fn.expand(dein_path)
    local toml = vim.g.rc_dir .. "/dein.toml"
    local lazy_toml = vim.g.rc_dir .. "/dein_lazy.toml"

    vim.fn["dein#load_toml"](toml, { lazy = 0 })
    vim.fn["dein#load_toml"](lazy_toml, { lazy = 1 })
    vim.fn["dein#end"]()
    vim.fn["dein#save_state"]()
end

-- deinの自動更新
vim.g["dein#auto_recache"] = true
