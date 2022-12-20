local bind = require("utils.keybind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd


local plug_keymap = {
    -- Packer
    ["n|<leader>ps"] = map_cr("PackerSync"):with_silent():with_nowait(),
    ["n|<leader>pu"] = map_cr("PackerUpdate"):with_silent():with_nowait(),
    ["n|<leader>pi"] = map_cr("PackerInstall"):with_silent():with_nowait(),
    ["n|<leader>pc"] = map_cr("PackerClean"):with_silent():with_nowait(),
    -- hlslens.nvim
    ["n|n"] = map_cmd([[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|N"] = map_cmd([[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|*"] = map_cr("*<Cmd>lua require('hlslens').start()"):with_silent(),
    ["n|#"] = map_cr("#<Cmd>lua require('hlslens').start()"):with_silent(),
    ["n|g*"] = map_cr("g*<Cmd>lua require('hlslens').start()"):with_silent(),
    ["n|g#"] = map_cr("g#<Cmd>lua require('hlslens').start()"):with_silent(),
    ["n|<leader>h"] = map_cr("noh"):with_silent(),
    -- accelerated_jk.nvim
    ["n|j"] = map_cmd("<Plug>(accelerated_jk_gj)"),
    ["n|k"] = map_cmd("<Plug>(accelerated_jk_gk)"),
    -- bufdelete.nvim
    ["n|<A-q>"] = map_cr(":Bwipeout"),
    -- hop.nvim
    ["n|<leader>w"] = map_cu("HopWord"),
    ["n|<leader>l"] = map_cu("HopLineStart"),
    ["n|<leader>/"] = map_cu("HopPattern"),
    ["n|<leader>c"] = map_cu("HopChar1AC"),
    ["n|<leader>cc"] = map_cu("HopChar2AC"),
    ["n|<leader>C"] = map_cu("HopChar1BC"),
    ["n|<leader>CC"] = map_cu("HopChar2BC"),
    -- open-browser
    ["n|<leader>bo"] = map_cr("OpenBrowserSmartSearch"),
    ["n|<leader>bs"] = map_cmd("OpenBrowserSearch"),
    -- todo-comments.nvim
    ["n|]t"] = map_cr("lua require('todo-comments').jump_next()"),
    ["n|[t"] = map_cr("lua require('todo-comments').jump_prev()"),
    -- vim-easy-align
    ["n|gea"] = map_cmd("<Plug>(clever-f-repeat-forward)"):with_expr(),
    ["x|gea"] = map_cmd("<Plug>(clever-f-repeat-forward)"):with_expr(),
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
    -- ["n|gcc"] = map_cr("CommentToggle"),
    -- neo-tree
    ["n|<leader>e"] = map_cr("NeoTreeShowToggle"):with_silent(),
    -- undo-tree
    ["n|<leader>ud"] = map_cr("UndotreeToggle"),
    -- toggleterm.nvim
    ["n|<leader><cr>"] = map_cr("ToggleTerm"),
    ["n|<leader><S-cr>"] = map_cr("ToggleTerm direction=tab"),
    --telescope.nvim
    ["n|<leader>fb"] = map_cu("Telescope buffers"):with_silent(),
    ["n|<leader>fc"] = map_cu("Telescope colorscheme"):with_silent(),
    ["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_silent(),
    ["n|<leader>ff"] = map_cu("Telescope find_files"):with_silent(),
    ["n|<leader>fg"] = map_cu("Telescope live_grep"):with_silent(),
    ["n|<leader>fh"] = map_cu("Telescope help_tag"):with_silent(),
    ["n|<leader>fz"] = map_cu("Telescope zoxide list"):with_silent(),
    --nvim-treehopper
    ["o|<silent>m"] = map_cu("lua require('tsht').nodes()"),
    ["x|<silent>m"] = map_cr("lua require('tsht').nodes()"),
    -- Lsp mapp work when insertenter and lsp start
	["n|<leader>li"] = map_cr("LspInfo"):with_silent():with_nowait(),
	["n|<leader>lr"] = map_cr("LspRestart"):with_silent():with_nowait(),
	["n|go"] = map_cr("Lspsaga outline"):with_silent(),
	["n|g["] = map_cr("Lspsaga diagnostic_jump_prev"):with_silent(),
	["n|g]"] = map_cr("Lspsaga diagnostic_jump_next"):with_silent(),
	["n|gs"] = map_cr("lua vim.lsp.buf.signature_help()"):with_silent(),
	["n|gr"] = map_cr("Lspsaga rename"):with_silent(),
	["n|K"] = map_cr("Lspsaga hover_doc"):with_silent(),
	["n|ga"] = map_cr("Lspsaga code_action"):with_silent(),
	["v|ga"] = map_cu("Lspsaga code_action"):with_silent(),
	["n|gd"] = map_cr("Lspsaga peek_definition"):with_silent(),
	["n|gD"] = map_cr("lua vim.lsp.buf.definition()"):with_silent(),
	["n|gh"] = map_cr("Lspsaga lsp_finder"):with_silent(),
	["n|gps"] = map_cr("G push"):with_silent(),
	["n|gpl"] = map_cr("G pull"):with_silent(),
}

bind.nvim_load_mapping(plug_keymap)

return plug_keymap
