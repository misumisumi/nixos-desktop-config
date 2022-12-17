local bind = require("keymap.bind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd


plug_keymap = {
    -- hlslens.nvim
    ["n|n"] = map_cmd([[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]):with_noremap():with_silent(),
    ["n|N"] = map_cmd([[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]):with_noremap():with_silent(),
    ["n|*"] = map_cr("*<Cmd>lua require('hlslens').start()"):with_noremap():with_silent(),
    ["n|#"] = map_cr("#<Cmd>lua require('hlslens').start()"):with_noremap():with_silent(),
    ["n|g*"] = map_cr("g*<Cmd>lua require('hlslens').start()"):with_noremap():with_silent(),
    ["n|g#"] = map_cr("g#<Cmd>lua require('hlslens').start()"):with_noremap():with_silent(),
    ["n|<leader>l"] = map_cr("noh"):with_noremap():with_silent(),

    -- accelerated_jk.nvim
    ["n|j"] = mcp_cmd("v:lua.enhance_jk_move('j')"):with_silent():with_expr(),
    ["n|k"] = mcp_cmd("v:lua.enhance_jk_move('k')"):with_silent():with_expr(),

    -- bufdelete.nvim
    ["n|<A-q>"] = map_cr(":Bwipeout"),
    -- hop.nvim
    ["n|<leader>w"] = map_cu("HopWord"):with_noremap(),
    ["n|<leader>l"] = map_cu("HopLineStart"):with_noremap(),
    ["n|<leader>/"] = map_cu("HopPattern"):with_noremap(),
    ["n|<leader>c"] = map_cu("HopChar1AC"):with_noremap(),
    ["n|<leader>cc"] = map_cu("HopChar2AC"):with_noremap(),
    ["n|<leader>C"] = map_cu("HopChar1BC"):with_noremap(),
    ["n|<leader>CC"] = map_cu("HopChar2BC"):with_noremap(),
    -- open-browser
    ["n|<leader>bo"] = map_cr("OpenBrowserSmartSearch"),
    ["n|<leader>bs"] = map_cmd("OpenBrowserSearch"),
    -- todo-comments.nvim
    ["n|]t"] = map_cr("lua require('todo-comments').jump_next()"),
    ["n|[t"] = map_cr("lua require('todo-comments').jump_prev()"),
    -- vim-easy-align
    ["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
	["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),
    -- vim-fugitive
    ["n|<leader>gs"] = map_cr("Git"),
    ["n|<leader>ga"] = map_cr("Gwrite"),
    ["n|<leader>gc"] = map_cr("Git commit"),
    ["n|<leader>gd"] = map_cr("Gdiffsplit"),
    ["n|<leader>gpp"] = map_cr("Git push"),
    ["n|<leader>gpP"] = map_cmd(":Git push"),
    ["n|<leader>gpl"] = map_cr("Git pull"),
    ["n|<leader>gpL"] = map_cmd(":Git pull"),
    ["n|<leader>gr"] = map_cr("Git rebase"),
    ["n|<leader>gm"] = map_cmd("GMove"),
    ["n|<leader>gd"] = map_cr("GDelete"),
    ["n|<leader>gD"] = map_cr("GDelete!"),
    -- nvim-comment (This is default bind.)
    -- ["n|gcc"] = map_cr("CommentToggle"):with_noremap(),
    ["n|gcc"] = map_cmd("CommentToggle"):with_noremap(),

}

bind.nvim_load_mapping(_plug_keymap)

return plug_keymap
