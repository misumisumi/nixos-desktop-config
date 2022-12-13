local bind = require("utils.keybind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd

local default_keymap = {
    -- Normal mode
    ["n|Y"] = map_cmd("y$"),
    ["n|D"] = map_cmd("d$"),
    ["n|n"] = map_cmd("nzzzv").with_noremap(), -- (n):検索結果の移動時に,(zz):カーソルを中央に,(zv):折りたたみに結果があれば折り畳みを開ける
    ["n|N"] = map_cmd("Nzzzv").with_noremap(),
    ["n:J"] = map_cmd("mzJ`z`").with_noremap(), -- カーソル位置を維持したまま一行にする
    ["n|ts"] = map_cr("setlocal spell! spellang=en_us"),

    ["n|<C-n>"] = map_cr("bnext"):with_noremap(),
    ["n|<C-p>"] = map_cr("bprevious"):with_noremap(),
    ["n|<Tab>"] = map_cr("tabnext"):with_noremap(),
    ["n|<S-Tab>"] = map_cr("tabprevious"):with_noremap(),
    ["n|<C-Tab>"] = map_cr("tabnew"):with_noremap(),


    ["n|<C-s>"] = map_cr("write"):with_noremap(),
    ["n|<C-q>"] = map_cmd(":wq<CR>"):with_noremap(),
    ["n|<C-S-q>"] = map_cmd(":q!<CR>"):with_noremap(),

    ["n|<C-h>"] = map_cmd("<C-w>h").with_noremap(),
    ["n|<C-l>"] = map_cmd("<C-w>l").with_noremap(),
    ["n|<C-j>"] = map_cmd("<C-w>j").with_noremap(),
    ["n|<C-k>"] = map_cmd("<C-w>k").with_noremap(),
    ["n|<C-S-H>"] = map_cmd("vertical resize -5").with_noremap(),
    ["n|<C-S-H>"] = map_cmd("vertical resize +5").with_noremap(),
    ["n|<C-S-H>"] = map_cmd("resize -2").with_noremap(),
    ["n|<C-S-H>"] = map_cmd("resize +2").with_noremap(),

    -- Insert mode
    ["i|jj"] = map_cmd("<ESC>^i"):with_noremap(),
    ["i|<C-s>"] = map_cmd("<ESC>:w<CR>"),
    ["i|<C-q>"] = map_cmd("<ESC>:wq<CR>"),

    -- Visual mode
    ["v|jj"] = map_cmd("<ESC>"),
    ["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
    ["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),
    ["v|<"] = map_cmd("<gv"),
    ["v|>"] = map_cmd(">gv"),

    -- Command line
    ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
}

bind.nvim_load_mapping(def_map)
