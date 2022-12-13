local utils = require("utils")

function set_indent_level(filetype, level)
    vim.fn.autocmd(string.format("FileType %s setlocal sw=%d sts=%d ts=%d et", filetype, level, level, level))
end


if vim.fn.has("autocmd") then
    set_indent_level("cpp", 2)
    set_indent_level("cs", 2)
    set_indent_level("dart", 2)
    set_indent_level("json", 2)
    set_indent_level("lua", 2)
    set_indent_level("markdown", 2)
    set_indent_level("nix", 2)
    set_indent_level("sh", 2)
    set_indent_level("vim", 2)
    set_indent_level("yaml", 2)
end

if vim.fn.has("clipboard") then
    vim.opt.clipboard = "unnamedplus"
end
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.hidden = true -- bufの移動時に警告が出なくなる
vim.opt.ignorecase = true -- 検索時に大文字小文字の違いを無視する
vim.opt.incsearch = true
vim.opt.nowrap = true
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wildmenu = true

vim.opt.cmdheight = 2
vim.opt.history = 500
vim.opt.pumblend = 20 -- ポップアップメニューの透過率(%)
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.winblend = 20 -- ウィンドウの透過率(%)

vim.opt.ambiwidth = "single" -- 全角は半角2文字分
vim.opt.colorcolumn = { 80, 100 }
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,iso-2202-jp,euc-jp,sjis"
vim.opt.fileformats = { "unix", "mac", "dos"}
vim.opt.helplang = { "ja", "en" }
vim.opt.matchpairs.append("<:>")
vim.opt.iskeyword.remove("_")
vim.opt.mouse = "a"
vim.opt.nrformts = ""
vim.opt.wildmode = "longerst,full"
