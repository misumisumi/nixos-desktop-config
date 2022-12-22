local bind = require("utils.keybind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd


local function map_leader()
    vim.g.mapleader = " "
    vim.keymap.set("n", " ", "")
    vim.keymap.set("x", " ", "")
end


local default_keymap = {
    -- Normal mode
    ["n|Y"] = map_cmd("y$"),
    ["n|D"] = map_cmd("d$"),
    -- ["n|n"] = map_cmd("nzzzv"), -- (n):検索結果の移動時に,(zz):カーソルを中央に,(zv):折りたたみに結果があれば折り畳みを開ける
    -- ["n|N"] = map_cmd("Nzzzv"),
    ["n|J"] = map_cmd("mzJ`z`"), -- カーソル位置を維持したまま一行にする
    ["n|ts"] = map_cr("setlocal spell! spellang=en_us"),

    -- ["n|<C-n>"] = map_cr("bnext"):with_silent(),
    -- ["n|<C-p>"] = map_cr("bprevious"):with_silent(),
    ["n|<leader>r"] = map_cr("luafile %"):with_silent(),
    ["n|<Tab>"] = map_cr("tabnext"):with_silent(),
    ["n|<S-Tab>"] = map_cr("tabprevious"):with_silent(),
    ["n|<C-Tab>"] = map_cr("tabnew"):with_silent(),


    ["n|<C-s>"] = map_cr("write"),
    ["n|<C-q>"] = map_cmd(":wq<CR>"),
    ["n|<C-S-q>"] = map_cmd(":q!<CR>"),

    -- ["n|<C-h>"] = map_cmd("<C-w>h"),
    -- ["n|<C-l>"] = map_cmd("<C-w>l"),
    -- ["n|<C-j>"] = map_cmd("<C-w>j"),
    -- ["n|<C-k>"] = map_cmd("<C-w>k"),
    -- ToDO: ウィンドウの位置を把握して移動とキーを一致させる
    -- ["n|<A-h>"] = map_cmd(function ()
    --     local columns = vim.api.nvim_get_option("columns")
    --     if vim.fn.screencol() <= columns / 3 then
    --         vim.cmd("vertical resize +5")
    --     else
    --         vim.cmd("vertical resize -5")
    --     end
    -- end):with_silent(),
    -- ["n|<A-l>"] = map_cmd(function ()
    --     local columns = vim.api.nvim_get_option("columns")
    --     if vim.fn.screencol() >= columns / 3 * 2 then
    --         vim.cmd("vertical resize -5")
    --     else
    --         vim.cmd("vertical resize +5")
    --     end
    -- end):with_silent(),
    ["n|<A-h>"] = map_cr("vertical resize -5"):with_silent(),
    ["n|<A-l>"] = map_cr("vertical resize +5"):with_silent(),
    ["n|<A-j>"] = map_cr("resize -2"):with_silent(),
    ["n|<A-k>"] = map_cr("resize +2"):with_silent(),

    -- Insert mode
    ["i|jj"] = map_cmd("<ESC>"),
    ["i|<C-s>"] = map_cmd("<ESC>:w<CR>"),
    ["i|<C-q>"] = map_cmd("<ESC>:wq<CR>"),

    -- Visual mode
    ["v|<C-j>"] = map_cmd(":m '>+1<cr>gv=gv"),
    ["v|<C-k>"] = map_cmd(":m '<-2<cr>gv=gv"),
    ["v|<"] = map_cmd("<gv"),
    ["v|>"] = map_cmd(">gv"),

    -- Command line
    ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]),
}


map_leader()
bind.nvim_load_mapping(default_keymap)
