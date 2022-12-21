-- PackerのUtils
local vim = vim
local fn, uv, api = vim.fn, vim.loop, vim.api
local utils = require("utils")
local joinpath = utils.joinpath
local global = require("core.global")
local is_mac = global.is_mac
local modules_dir = global.modules_dir


local settings = require("pack_utils.settings")
local compiled_dir = settings.compiled_dir
local packer_compiled = settings.packer_compiled
local backup_compiled = settings.backup_compiled
local use_ssh = settings.use_ssh

local packer = nil
local Packer = {}
Packer.__index = Packer


function Packer:load_plugins()
    self.repos = {}
    local function get_plugins_list()
        local list = {}
        local tmp = vim.split(fn.globpath(modules_dir, joinpath("*", "plugins.lua")), "\n")

        for _,f in ipairs(tmp) do
            list[#list + 1] = f:sub(#modules_dir - 6, -1)
        end

        return list
    end

    local plugins_file = get_plugins_list()

    -- Each plugins.lua return { "<repo>" = { conf=foo } }
    for _,m in ipairs(plugins_file) do
        local repos = require(m:sub(0, #m - 4))
        for repo, conf in pairs(repos) do
            self.repos[#self.repos + 1] = vim.tbl_extend("force", { repo }, conf)
        end
    end
end


function Packer:load_packer()
    if not packer then
        api.nvim_command("packadd packer.nvim")
        packer = require("packer")
    end
    local clone_prefix = use_ssh and "git@github.com:%s" or "https://github.com/%s"
    if not is_mac then
        packer.init({
            compile_path = packer_compiled,
            git = {
                clone_timeout = 60,
                default_url_format = clone_prefix
            },
            display_commands = true,
            display = {
                open_fn = function() return require("packer.util").float({ border = "rounded" }) end
            },
        })
    else
        packer.init({
            compile_path = packer_compiled,
            git = {
                clone_timeout = 60,
                default_url_format = clone_prefix
            },
            display_commands = true,
            display = {
                open_fn = function() return require("packer.util").float({ border = "rounded" }) end
            },
            max_jobs = 20,
        })
    end
    packer.reset()

    self:load_plugins()
    packer.use({ "wbthomason/packer.nvim", opt = true })
    for _, repo in ipairs(self.repos) do
        -- for i,k in ipairs(repo) do
        --     print(k)
        --     break
        -- end
        packer.use(repo)
    end
end


function Packer:init_ensure_plugins()
    local packer_dir = settings.packer_dir
    if not (utils.path_exists(packer_dir)) then
        local cmd = (
            use_ssh and "!git clone git@github.com:wbthomason/packer.nvim.git "
            or "!git clone https://github.com/wbthomason/packer.nvim "
        ) .. packer_dir
        api.nvim_command(cmd)
	utils.mkdir(compiled_dir, 511)
        self:load_packer()
        packer.install()
    end
end


local plugins = setmetatable({}, {
    __index = function(_, key)
        if not packer then
            Packer:load_packer()
        end
        return packer[key]
    end
})


function plugins.ensure_plugins()
    Packer:init_ensure_plugins()
end


function plugins.back_compile()
    if vim.fn.filereadable(packer_compiled) == 1 then
        os.rename(packer_compiled, backup_compiled)
    end
    plugins.compile()
    vim.notify("Packer Compile Success!", vim.log.levels.INFO, { title = "Success!" })
end


function plugins.auto_compile()
    local file = vim.fn.expand("%:p")
    if file:match(modules_dir) then
        plugins.clean()
        plugins.back_compile()
    end
end


function plugins.load_compile()
    if vim.fn.filereadable(packer_compiled) == 1 then
        require("_compiled")
    else
        plugins.back_compile()
    end

    local cmds = { "Compile", "Install", "Update", "Sync", "Clean", "Status" }
    for _, cmd in ipairs(cmds) do
        api.nvim_create_user_command("Packer" .. cmd, function()
            require("pack_utils")[cmd == "Compile" and "back_compile" or string.lower(cmd)]()
        end, { force = true })
    end

    api.nvim_create_autocmd("User", {
        pattern = "PackerComplete",
        callback = function() require("pack_utils").back_compile() end
    })
end

return plugins
