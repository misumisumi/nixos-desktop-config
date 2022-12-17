local bind = require("utils.keybind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd


local function map_leader()
    vim.g.mapleader = "\\<Space>"
end


local default_keymap = {
    -- Normal mode
    ["n|Y"] = map_cmd("y$"),
    ["n|D"] = map_cmd("d$"),
    ["n|n"] = map_cmd("nzzzv"), -- (n):検索結果の移動時に,(zz):カーソルを中央に,(zv):折りたたみに結果があれば折り畳みを開ける
    ["n|N"] = map_cmd("Nzzzv"),
    ["n:J"] = map_cmd("mzJ`z`"), -- カーソル位置を維持したまま一行にする
    ["n|ts"] = map_cr("setlocal spell! spellang=en_us"),

    ["n|<C-n>"] = map_cr("bnext"),
    ["n|<C-p>"] = map_cr("bprevious"),
    ["n|<Tab>"] = map_cr("tabnext"),
    ["n|<S-Tab>"] = map_cr("tabprevious"),
    ["n|<C-Tab>"] = map_cr("tabnew"),


    ["n|<C-s>"] = map_cr("write"),
    ["n|<C-q>"] = map_cmd(":wq<CR>"),
    ["n|<C-S-q>"] = map_cmd(":q!<CR>"),

    ["n|<C-h>"] = map_cmd("<C-w>h"),
    ["n|<C-l>"] = map_cmd("<C-w>l"),
    ["n|<C-j>"] = map_cmd("<C-w>j"),
    ["n|<C-k>"] = map_cmd("<C-w>k"),
    ["n|<C-S-H>"] = map_cmd("vertical resize -5"),
    ["n|<C-S-H>"] = map_cmd("vertical resize +5"),
    ["n|<C-S-H>"] = map_cmd("resize -2"),
    ["n|<C-S-H>"] = map_cmd("resize +2"),

    -- Insert mode
    ["i|jj"] = map_cmd("<ESC>^i"),
    ["i|<C-s>"] = map_cmd("<ESC>:w<CR>"),
    ["i|<C-q>"] = map_cmd("<ESC>:wq<CR>"),

    -- Visual mode
    ["v|jj"] = map_cmd("<ESC>"),
    ["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
    ["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),
    ["v|<"] = map_cmd("<gv"),
    ["v|>"] = map_cmd(">gv"),

    -- Command line
    ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]),
}


set_leader()
bind.nvim_load_mapping(def_map)
