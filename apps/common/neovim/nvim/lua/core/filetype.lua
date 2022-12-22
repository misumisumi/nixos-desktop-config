local conf = {}
local keybind = require("utils.keybind")


local exit_filetype = {
    help = { ["n|q"] = keybind.map_cr("q") },
    quickfix = { ["n|q"] = keybind.map_cr("q") },
}

local indent_level = {}

-- From https://google.github.io/styleguide/
indent_level["2"] = {
    "nix",
    "c",
    "cpp",
    "html",
    "css",
    "js",
    "java",
    "sh",
    "swift",
}


for lang,bind in ipairs(exit_filetype) do
    conf[lang] = function() keybind(bind) end
end


local function set_indent(tab_length, is_hard_tab)
    if is_hard_tab then
        vim.bo.expandtab = false
    else
        vim.bo.expandtab = true
    end

    vim.bo.shiftwidth  = tab_length
    vim.bo.softtabstop = tab_length
    vim.bo.tabstop     = tab_length
end


for level,langs in pairs(indent_level) do
    for _,lang in ipairs(langs) do
        conf[lang] = function() set_indent(tonumber(level), false) end
    end
end


setmetatable(conf, {
    __index = function()
        return function()
        end
    end
})


vim.api.nvim_create_augroup("vimrc_augroup", {})
vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc_augroup",
    pattern = "*",
    callback = function(args) conf[args.match]() end
})

