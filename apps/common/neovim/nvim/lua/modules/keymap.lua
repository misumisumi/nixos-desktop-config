local bind = require("utils.keybind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd


local plug_keymap = {
    -- Packer
    ["n|<leader><C-p>s"] = map_cr("PackerSync"):with_silent():with_nowait(),
    ["n|<leader><C-p>u"] = map_cr("PackerUpdate"):with_silent():with_nowait(),
    ["n|<leader><C-p>i"] = map_cr("PackerInstall"):with_silent():with_nowait(),
    ["n|<leader><C-p>c"] = map_cr("PackerComplete"):with_silent():with_nowait(),
    ["n|<leader><C-p>C"] = map_cr("PackerClean"):with_silent():with_nowait(),
    -- hlslens.nvim
    ["n|n"] = map_cmd([[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|N"] = map_cmd([[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|*"] = map_cmd([[*<Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|#"] = map_cmd([[#<Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|g*"] = map_cmd([[g*<Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    ["n|g#"] = map_cmd([[g#<Cmd>lua require('hlslens').start()<CR>]]):with_silent(),
    -- accelerated_jk.nvim
    ["n|j"] = map_cmd("<Plug>(accelerated_jk_gj)"),
    ["n|k"] = map_cmd("<Plug>(accelerated_jk_gk)"),
    -- bufdelete.nvim
    ["n|<C-w>q"] = map_cr("Bwipeout"):with_remap():with_silent(),
    -- Cheatsheat
    ["n|<leader>?"] = map_cr("Cheatsheet"):with_silent(),
    -- Bufferline
    ["n|gb"] = map_cr("BufferLinePick"):with_silent(),
    ["n|<C-n>"] = map_cr("BufferLineCycleNext"):with_silent(),
    ["n|<C-p>"] = map_cr("BufferLineCyclePrev"):with_silent(),
    ["n|<A-S-n>"] = map_cr("BufferLineMoveNext"):with_silent(),
    ["n|<A-S-p>"] = map_cr("BufferLineMovePrev"):with_silent(),
    ["n|<leader>be"] = map_cr("BufferLineSortByExtension"),
    ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"),
    ["n|<C-1>"] = map_cr("BufferLineGoToBuffer 1"):with_silent(),
    ["n|<C-2>"] = map_cr("BufferLineGoToBuffer 2"):with_silent(),
    ["n|<C-3>"] = map_cr("BufferLineGoToBuffer 3"):with_silent(),
    ["n|<C-4>"] = map_cr("BufferLineGoToBuffer 4"):with_silent(),
    ["n|<C-5>"] = map_cr("BufferLineGoToBuffer 5"):with_silent(),
    ["n|<C-6>"] = map_cr("BufferLineGoToBuffer 6"):with_silent(),
    ["n|<C-7>"] = map_cr("BufferLineGoToBuffer 7"):with_silent(),
    ["n|<C-8>"] = map_cr("BufferLineGoToBuffer 8"):with_silent(),
    ["n|<C-9>"] = map_cr("BufferLineGoToBuffer 9"):with_silent(),
    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"] = map_cr("LspInfo"):with_silent():with_nowait(),
    ["n|<leader>lr"] = map_cr("LspRestart"):with_silent():with_nowait(),
    ["n|go"] = map_cr("Lspsaga outline"):with_silent(),
    ["n|g["] = map_cr("Lspsaga diagnostic_jump_prev"):with_silent(),
    ["n|g]"] = map_cr("Lspsaga diagnostic_jump_next"):with_silent(),
    ["n|gs"] = map_cr("lua vim.lsp.buf.signature_help()"):with_silent(),
    ["n|gr"] = map_cr("Lspsaga rename"):with_silent(),
    ["n|K"] = map_cr("Lspsaga hover_doc"):with_silent(),
    ["n|ca"] = map_cr("Lspsaga code_action"):with_silent(),
    ["v|ca"] = map_cu("Lspsaga code_action"):with_silent(),
    ["n|gd"] = map_cr("Lspsaga peek_definition"):with_silent(),
    ["n|gD"] = map_cr("lua vim.lsp.buf.definition()"):with_silent(),
    -- hop.nvim
    ["n|<leader>w"] = map_cu("HopWord"),
    ["n|<leader>l"] = map_cu("HopLineStart"),
    ["n|<leader>/"] = map_cu("HopPattern"),
    ["n|<leader>c"] = map_cu("HopChar1"),
    ["n|<leader>cc"] = map_cu("HopChar2"),
    ["n|<leader>C"] = map_cu("HopChar1BC"),
    ["n|<leader>CC"] = map_cu("HopChar2BC"),
    -- open-browser
    ["n|<leader>bo"] = map_cr("OpenBrowserSmartSearch"),
    ["n|<leader>bs"] = map_cmd("OpenBrowserSearch"),
    -- todo-comments.nvim
    ["n|]t"] = map_cr("lua require('todo-comments').jump_next()"),
    ["n|[t"] = map_cr("lua require('todo-comments').jump_prev()"),
    -- vim-easy-align
    ["n|ga"] = map_cmd("<Plug>(EasyAlign)"):with_silent(),
    ["x|ga"] = map_cmd("<Plug>(EasyAlign)"):with_silent(),
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
    ["n|<leader>gD"] = map_cr("GDelete!"),
    -- nvim-comment
    ["n|gcc"] = map_cr("CommentToggle"),
    -- neo-tree
    ["n|<leader>e"] = map_cr("NeoTreeShowToggle"):with_silent(),
    -- undo-tree
    ["n|<leader>ud"] = map_cr("UndotreeToggle"),
    -- toggleterm.nvim
    ["n|<leader><cr>"] = map_cr("ToggleTerm direction=horizontal"),
    ["n|<leader><S-cr>"] = map_cr("ToggleTerm direction=vertical"),
    ["n|<leader><C-cr>"] = map_cr("ToggleTerm direction=tab"),
    ["n|<leader><A-cr>"] = map_cr("ToggleTerm direction=float"),
    ["t|<C-q>"] = map_cmd("<C-\\><C-n>"),
    --telescope.nvim
    ["n|<leader>fn"] = map_cu(":enew"):with_silent(),
    ["n|<leader>fb"] = map_cu("Telescope buffers"):with_silent(),
    ["n|<leader>fc"] = map_cu("Telescope colorscheme"):with_silent(),
    ["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_silent(),
    ["n|<leader>ff"] = map_cu("Telescope find_files"):with_silent(),
    ["n|<leader>fg"] = map_cu("Telescope live_grep"):with_silent(),
    ["n|<leader>fh"] = map_cu("Telescope help_tag"):with_silent(),
    ["n|<leader>fz"] = map_cu("Telescope zoxide list"):with_silent(),
    --nvim-treehopper
    ["o|m"] = map_cu("lua require('tsht').nodes()"),
    ["x|m"] = map_cr("lua require('tsht').nodes()"),
    -- Plugin trouble
    ["n|<leader>tt"] = map_cr("TroubleToggle"):with_silent(),
    ["n|<leader>tR"] = map_cr("TroubleToggle lsp_references"):with_silent(),
    ["n|<leader>td"] = map_cr("TroubleToggle document_diagnostics"):with_silent(),
    ["n|<leader>tw"] = map_cr("TroubleToggle workspace_diagnostics"):with_silent(),
    ["n|<leader>tq"] = map_cr("TroubleToggle quickfix"):with_silent(),
    ["n|<leader>tl"] = map_cr("TroubleToggle loclist"):with_silent(),
    -- Sniprun
    ["v|<leader>r"] = map_cr("SnipRun"):with_silent(),
    ["c|Q"] = map_cu([[%SnipRun]]):with_silent(),
    -- Plugin dap
    ["n|<F6>"] = map_cr("lua require('dap').continue()"):with_silent(),
    ["n|<leader>dr"] = map_cr("lua require('dap').continue()"):with_silent(),
    ["n|<leader>dd"] = map_cr("lua require('dap').terminate() require('dapui').close()"):with_silent(),
    ["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint()"):with_silent(),
    ["n|<leader>dB"] = map_cr("lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))"):with_silent(),
    ["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_silent(),
    ["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_silent(),
    ["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_silent(),
    ["n|<F9>"] = map_cr("lua require('dap').step_over()"):with_silent(),
    ["n|<leader>dv"] = map_cr("lua require('dap').step_over()"):with_silent(),
    ["n|<F10>"] = map_cr("lua require('dap').step_into()"):with_silent(),
    ["n|<leader>di"] = map_cr("lua require('dap').step_into()"):with_silent(),
    ["n|<F11>"] = map_cr("lua require('dap').step_out()"):with_silent(),
    ["n|<leader>do"] = map_cr("lua require('dap').step_out()"):with_silent(),
    ["n|<leader>dl"] = map_cr("lua require('dap').repl.open()"):with_silent(),
    -- Plugin Tabout
    ["i|<A-l>"] = map_cmd([[<Plug>(TaboutMulti)]]):with_silent(),
    ["i|<A-h>"] = map_cmd([[<Plug>(TaboutBackMulti)]]):with_silent(),
    -- Plugin Diffview
    ["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent(),
    ["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent(),
    -- Plugin Legendary
    ["n|<leader>p"] = map_cr("Legendary"):with_silent(),   ["n|gh"] = map_cr("Lspsaga lsp_finder"):with_silent(),
}

bind.nvim_load_mapping(plug_keymap)

return plug_keymap
