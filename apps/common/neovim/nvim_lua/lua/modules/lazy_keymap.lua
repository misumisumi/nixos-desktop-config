local bind = require("keymap.bind")
local map_cr, map_cu, map_cmd = bind.map_cr, bind.map_cu, bind.map_cmd

local lazy_keymap = {}


-- ui
function lazy_keymap.gitsigns(bufnr)
    local gs = package.loaded.gitsigns

    local keymap = {
        ["n|]c"] = map_cmd(
            function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end
        ):with_expr(),
        ["n|[c"] = map_cmd(
            function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end
        ):with_expr(),
        -- Actions
        ["n,v|<leader>hs"] = map_cr(":Gitsigns stage_hunk"),
        ["n,v|<leader>hr"] = map_cr(":Gitsigns reset_hunk"),
        ["n|<leader>hS"] = map_cmd(gs.stage_buffer),
        ["n|<leader>hu"] = map_cmd(gs.undo_stage_hunk),
        ["n|<leader>hR"] = map_cmd(gs.reset_buffer),
        ["n|<leader>hp"] = map_cmd(gs.preview_hunk),
        ["n|<leader>hb"] = map_cmd(function() gs.blame_line{ full=true } end),
        ["n|<leader>tb"] = map_cmd(gs.toggle_current_line_blame),
        ["n|<leader>hd"] = map_cmd(gs.diffthis),
        ["n|<leader>hD"] = map_cmd(function() gs.diffthis("~") end),
        ["n|<leader>td"] = map_cmd(gs.toggle_deleted),
        ["o,x|ih"] = map_cr(":Gitsigns select_hunk"),
    }
    bind.nvim_load_mapping(keymap)
end

-- tools
function lazy_keymap.neo_tree()
    local keymap = {
        window = {
            ["<space><space>"] = { 
                "toggle_node", 
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
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
            ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
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


function lazy_keymap.neo_tree()
    local keymap = {
        default = {
            ["<space>"] = { 
                "toggle_node", 
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = { 
              "add",
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        },
        filesystem = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
        },
        buffers = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
        },
        git_status = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
        }
    }
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
    local keymap = {

    }
end

return lazy_keymap
