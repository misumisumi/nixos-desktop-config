local bind = require("utils.keybind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd

local lazy_keymap = {}


-- ui
function lazy_keymap.gitsigns(gs)
    local keymap = {
        ["n|]c"] = map_cmd(
            function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end
        ):with_expr():with_buffer():with_desc("Gitsigns prev hunk"),
        ["n|[c"] = map_cmd(
            function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.prev_hunk() end)
                return "<Ignore>"
            end
        ):with_expr():with_buffer():with_desc("Gitsigns prev hunk"),
        -- Actions
        ["n,v|<leader>hs"] = map_cr("Gitsigns stage_hunk"):with_buffer(),
        ["n,v|<leader>hr"] = map_cr("Gitsigns reset_hunk"):with_buffer(),
        ["n|<leader>hS"] = map_cmd(gs.stage_buffer):with_buffer():with_desc("Gitsigns stage buffer"),
        ["n|<leader>hu"] = map_cmd(gs.undo_stage_hunk):with_buffer():with_desc("Gitsigns undo stage hunk"),
        ["n|<leader>hR"] = map_cmd(gs.reset_buffer):with_buffer():with_desc("Gitsigns reset buffer"),
        ["n|<leader>hp"] = map_cmd(gs.preview_hunk):with_buffer():with_desc("Gitsigns preview hunk"),
        ["n|<leader>hb"] = map_cmd(function() gs.blame_line{ full=true } end):with_buffer():with_desc("Gitsigns blame line"),
        ["n|<leader>tb"] = map_cmd(gs.toggle_current_line_blame):with_buffer():with_desc("Gitsigns blame current line"),
        ["n|<leader>hd"] = map_cmd(gs.diffthis):with_desc("Gitsigns diffthis"),
        ["n|<leader>hD"] = map_cmd(function() gs.diffthis("~") end):with_buffer():with_desc("Gitsigns diffthis ~"),
        ["n|<leader>sgd"] = map_cmd(gs.toggle_deleted):with_buffer():with_desc("Gitsigns toggle delete"),
        ["o,x|ih"] = map_cr(":Gitsigns select_hunk"),
    }
    bind.nvim_load_mapping(keymap)
end

-- tools
function lazy_keymap.neo_tree()
    local keymap = {
        window = {
            ["<space>"] = false,
            ["<space><space>"] = {
                "toggle_node",
                nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open_drop",
            ["<cr>"] = "open_drop",
            ["o"] = "open_drop",
            ["O"] = "open_with_window_picker",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["s"] = "open_split",
            ["S"] = "split_with_window_picker",
            ["v"] = "open_vsplit",
            ["V"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            -- ["Z"] = "expand_all_nodes",
            ["n"] = {
              "add",
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "relative"
              }
            },
            ["N"] = {
                "add_directory",
                config = {
                    show_path = "relative"
                }
            },
            ["dd"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            -- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["c"] = {
                "copy",
                config = {
                    show_path = "relative"
                }
            },
            ["m"] = {
                "move",
                config = {
                    show_path = "relative"
                }
            },
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        },
        fs = {
            ["<bs>"] = "navigate_up",
            ["H"] = "navigate_up",
            ["."] = "set_root",
            ["<c-h>"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
        },
        buf = {
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["H"] = "navigate_up",
            ["."] = "set_root",
        },
        git = {
            ["gA"]  = "git_add_all",
            ["ga"] = "git_add_file",
            ["gc"] = "git_commit",
            ["gg"] = "git_commit_and_push",
            ["gp"] = "git_push",
            ["gr"] = "git_revert_file",
            ["gu"] = "git_unstage_file",
        }
    }

    return keymap
end


function lazy_keymap.trouble()
    local keymap = {
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = { "<esc>", "jj" }, -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "R", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-s>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j" -- next item
    }

    return keymap
end


function lazy_keymap.legendary()
    local keymap = {
        ["<leader>"] = {
            b = {
                name = "Bufferline commands",
                d = "buffer: Sort by directory",
                e = "buffer: Sort by extension",
            },
            d = {
                name = "Dap commands",
                b = "debug: Toggle breakpoint",
                d = "debug: Terminate debug session",
                r = "debug: Continue",
                l = "debug: Open repl",
                i = "debug: Step in",
                o = "debug: Step out",
                v = "debug: Step over",
            },
            f = {
                name = "Telescope commands",
                p = "find: Project",
                w = "find: Word",
                r = "find: File by frecency",
                e = "find: File by history",
                c = "ui: Change color scheme",
                z = "edit: Change current directory by zoxide",
                f = "find: File under current work directory",
                g = "find: File under current git directory",
                n = "edit: New file",
            },
            h = {
                name = "Gitsigns commands",
                b = "git: Blame line",
                p = "git: Preview hunk",
                s = "git: Stage hunk",
                u = "git: Undo stage hunk",
                r = "git: Reset hunk",
                R = "git: Reset buffer",
            },
            l = {
                name = "LSP commands",
                i = "lsp: LSP Info",
                r = "lsp: LSP Restart",
            },
            n = {
                name = "NvimTree commands",
                f = "filetree: NvimTree find file",
                r = "filetree: NvimTree refresh",
            },
            p = {
                name = "Packer commands",
                s = "packer: PackerSync",
                i = "packer: PackerInstall",
                c = "packer: PackerClean",
                u = "packer: PackerUpdate",
            },
            s = {
                name = "Session commands",
                s = "sesson: Save session",
                r = "sesson: Restore session",
                d = "sesson: Delete session",
            },
            t = {
                name = "Trouble commands",
                d = "lsp: show document diagnostics",
                w = "lsp: show workspace diagnostics",
                q = "lsp: show quickfix list",
                l = "lsp: show loclist",
            },
        },
        ["g"] = {
            a = "lsp: Code action",
            d = "lsp: Preview definition",
            D = "lsp: Goto definition",
            h = "lsp: Show reference",
            o = "lsp: Toggle outline",
            r = "lsp: Rename",
            s = "lsp: Signature help",
            t = "lsp: Toggle trouble list",
            b = "buffer: Buffer pick",
            p = {
                name = "git commands",
                s = "git: push",
                l = "git: pull",
            },
        },
        ["<leader>G"] = "git: Show fugitive",
        ["<leader>g"] = "git: Show lazygit",
        ["<leader>D"] = "git: Show diff",
        ["<leader><leader>D"] = "git: Close diff",
        ["g["] = "lsp: Goto prev diagnostic",
        ["g]"] = "lsp: Goto next diagnostic",
        ["<leader>w"] = "jump: Goto word",
        ["<leader>j"] = "jump: Goto line",
        ["<leader>k"] = "jump: Goto line",
        ["<leader>c"] = "jump: Goto one char",
        ["<leader>cc"] = "jump: Goto two chars",
        ["<leader>o"] = "edit: Check spell",
    }

    return keymap
end


function lazy_keymap.live_grep_args(lga_actions)
    local keymap = {
        i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
    }

    return keymap
end

function lazy_keymap.textobject()
    local keymap = {
        select = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
        },
        move = {
            goto_next_start = {
                ["]["] = "@function.outer",
                ["]m"] = "@class.outer",
            },
            goto_next_end = {
                ["]]"] = "@function.outer",
                ["]M"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[m"] = "@class.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[M"] = "@class.outer",
            },
        }
    }

    return keymap
end

function lazy_keymap.nvim_cmp(cmp)
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local keymap = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
            else
                fallback()
            end
        end, { "i", "s" }),
    }

    return keymap
end

return lazy_keymap
