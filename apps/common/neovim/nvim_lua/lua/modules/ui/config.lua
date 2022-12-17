local config = {}
local g, fn, api = vim.g, vim.fn, vim.api


function config.catppuccin()
    local opt = {
        flavor = "mocha",
        transparent_background = true,
        term_color = true,
        styles = {
            comments = { "italic" },
            properties = { "italic" },
            functions = { "italic", "bold" },
            keywords = { "bold" },
            operators = { "bold" },
            conditionals = { "bold" },
            loops = { "bold" },
        },
        integrations = {
            cmp = true,
            dashboard = true,
            fidget = true,
            gitsigns = true,
            hop = true,
            illuminate = true,
            lsp_saga = true,
            lsp_trouble = true,
            markdown = true,
            mason = true,
            notify = true,
            telescope = true,
            treesitter = true,
            ts_rainbow = true,
            vimwiki = true,
            which_key = true,
            dap = {
                enabled = true,
                enable_ui = true
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic", "bold" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            neotree = { 
                enabled = true, 
                show_root = true,
                transparent_panel = false 
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false
            },
        }

    }
    require("catppuccin").setup(opt)
end


function config.onedark()
    local opt = {
        style = "darker",
        transparent = true,
        term_colors = true,
        ending_tildes = true,
        code_style = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
            strings = "none",
            variables = "none",
        },
        lualine = {
            transparent = true,
        },
        -- colors = {
        --     comment_grey = "#696969",
        --     special_grey = "#696969"
        -- },
        diagnostics = {
            darker = true,
            undercurl = true,
            background = true
        }
    }

    require('onedark').setup(opt)
    require('onedark').load()
end


function config.alpha()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    math.randomseed(os.time())

    local function pick_color ()
        local colors = { "String", "Identifier", "Keyword", "Number" }
        return colors[math.random(#colors)]
    end

    dashboard.section.header.val = {
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⢿⣿⣿⡿⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠙⣿⠁⠀⣀⣨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⣷⣠⣾⣿⣿⣿⣿⣉⠉⠙⠻⣿⣿⣿⠟⠋⠛⢻⡿⠟⠻⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣄⣤⣄⣿⣿⣿⣿⣿⣿⡏⣁⣉⡉⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⡟⣾⣿⣿⣿⣿⣿⢏⣼⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⢋⣾⡿⣸⣿⣿⡿⠛⠟⠕⢋⡾⣿⣿⣿⣿⠟⢹⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⢇⣾⣿⢁⣿⣿⣿⠗⢛⢒⡦⠀⠈⠉⠑⠻⠋⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿]],
        [[⣿⣿⣿⣿⣿⣿⢃⣾⣿⠇⣼⡙⠻⡿⠧⠀⠀⠀⠀⠀⠀⢀⣶⣤⡈⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿]],
        [[⣿⣿⣿⣿⣿⢧⣿⣿⣿⠀⣿⣇⢠⣱⡄⠀⠀⠀⠀⠀⠀⠀⠈⢀⣽⣍⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⡟⣿⠀⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⡠⢺⠟⣤⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿]],
        [[⣿⣿⣿⡟⠉⣾⡟⣷⠀⢄⢔⣢⡀⢉⣩⡉⠀⠀⠀⠎⠩⠉⠠⠃⠰⠿⠿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿]],
        [[⣿⣿⣿⢧⣸⣿⣷⣿⡔⣴⣿⡿⣿⣿⣿⣿⣷⣶⣶⣜⢀⣁⣈⠲⣄⡀⠀⠉⠳⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿]],
        [[⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠇⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣓⣿⣿⣿⣿⣿⡿⢃⡀⠀⢳⣾⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿]],
        [[⣿⣿⠟⢷⣿⣹⣮⣿⣿⣿⣿⣿⠛⢱⣿⣿⡿⢿⣿⣿⡇⠈⠻⢶⣾⡀⠉⠳⢤⣀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉]],
        [[⣿⣿⡀⠸⣿⣼⣾⣿⣿⣿⣿⣿⣷⣿⣿⣿⢿⣿⣿⣿⡛⢶⣤⡾⠉⠛⠷⣦⠀⠈⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀]],
        [[⠀⠀⠀⠀⠙⣿⣿⣿⡿⠿⠿⠹⠘⠛⠛⠛⠋⠁⠘⠛⠃⠀⣽⠛⠶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿⣿⣿⣿]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣧⠀⠀⠀⠀⠀]],
    }

    dashboard.section.header.opts.hl = "Type"
    -- dashboard.section.header.opts.hl = pick_color()
    --
    local function buttom(sc, txt, leader_txt, keybind, keybind_opts)
        local sc_after = sc:gsub("%s", ""):gsub(leader_txt, "<leader>")
        local opts = {
            position = "center",
            shortcut = sc,
            cursor = 5,
            width = 50,
            align_shortcut = "right",
            hl_shortcut = "keyword"
        }

        if nil == keybind then
            keybind = sc_after
        end

        keybind_opts = vim.F.if_nil(keybind_opts, { 
            noremap = true,
            silent = true,
            nowait = true
        })
        opts.keymap = { "n", sc_after, keybind, keybind_opts }

        local function on_press()
            local key = api.nvim_replace_termcodes(sc_after .. "<Ignore>", true, false, true)
            api.nvim_feedkeys(key, "t", false)
        end

        return {
            type = "button",
            val = txt,
            on_press = on_press,
            opts = opts,
        }
    end

    local leader = g.mapleader
    dashboard.section.buttons.val = {
        button("SPC f n", " File new", leader, "<cmd>enew<cr>"),
        button("SPC f f", " File find", leader, "<cmd>Telescope find_files<cr>"),
        button("SPC f h", " File history", leader, "<cmd>Telescope oldfiles<cr>"),
        button("SPC f r", " File frecency", leader, "<cmd>Telescope frecency<cr>"),
        button("SPC f p", " Project find", leader, "<cmd>Telescope project<cr>"),
        button("SPC f w", " Word find", leader, "<cmd>Telescope live_grep<cr>"),
        button("SPC f c", " Scheme change", leader, "<cmd>Telescope colorscheme<cr>"),
    }
    dashboard.section.buttons.opts.hl = "String"

    local function footer()
        local total_plugins = #vim.tbl_keys(packer_plugins)
        return "   Have Fun with neovim"
            .. "   v"
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "."
            .. vim.version().patch
            .. "   "
            .. total_plugins
            .. " plugins"
    end

    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "Function"

    local head_butt_padding = 2
    local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
    local header_padding = math.max(0, math.ceil((fn.winheight("$") - occu_height) * 0.25))
    local foot_butt_padding = 1

    dashboard.config.layout = {
        { type = "padding", val = header_padding },
        dashboard.section.header,
        { type = "padding", val = head_butt_padding },
        dashboard.section.buttons,
        { type = "padding", val = foot_butt_padding },
        dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

end


function config.bufferline_nvim()
    local icons = { ui = require("modules.ui.icons").get("ui") }
    local opts = {
        options = {
            buffer_close_icon = icons.ui.Close,
            left_trunc_marker = icons.ui.Left,
            modified_icon = icons.ui.Modified,
            right_trunc_marker = icons.ui.Right,
            always_show_bufferline = true,
            persist_buffer_sort = true,
            show_buffer_close_icons = false,
            show_buffer_icons = true,
            show_close_icon = false,
            show_duplicate_prefix = true,
            show_tab_indicators = true,
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 20,
            diagnostics = "nvim_lsp",
            number = "buffer_id",
            separator_style = "thin",
            -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
            sort_by = "insert_after_current" ,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            offsets = {
                {
                    filetype = "NvimNeoTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1
                },
                {
                    filetyep = "undotree",
                    text = "Undo Tree",
                    text_align = "center",
                    highlight = "Directory",
                    separator = true
                }
            },
        },
        highlights = {}
    }

    require("bufferline").setup(opt)
end


function config.fidget()
    local opt = {
        window = {
            blend = 0
        }
    }
    require("fidget").setup(opt)
end


function config.gitsigns()
    local keymap = { gitsigns = require("modules.lazy_keymap").gitsigns }

    local opt = {
        signs = {
          add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
          change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
          delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
          topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
          untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        on_attach = keymap.gitsigns
    }

    require("gitsigns").setup(opt)
    require("scrollbar.handlers.gitsigns").setup()
end


function config.indent_blankline()
    local opt = {
        filetype_exclude = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "json",
            "txt",
            "vista",
            "help",
            "todoist",
            "NeoTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
        },
        buftype_exclude = {
            "terminal",
            "nofile"
        },
        show_trailing_blankline_indent = false,
        context_patterns = {
            "^func",
            "^if",
            "argument_list",
            "arguments",
            "class",
            "dictionary",
            "do_block",
            "element",
            "except",
            "for",
            "import",
            "method",
            "object",
            "table",
            "try",
            "tuple",
            "var",
            "while",
            "with",
        }
    }
end


function config.lualine()
    local icons = { 
        diagnostics = require("modules.ui.icons").get("diagnostics", true),
        misc = require("modules.ui.icons").get("misc", true),
        ui = require("modules.ui.icons").get("ui", true),
    }

    local function escape_status()
        local ok, m =  pcall(require, "better_escape")
        return ok and m.waiting and icons.misc.EscapeST or ""
    end

    local function get_cmd()
        local cwd = fn.getcwd()
        local home = require("core.global").home
        if cwd:find(home, 1, true) == 1 then
            cwd = "~" .. cwd:sub(#home + 1)
        end

        return icons.ui.RootFolderOpened .. cwd
    end

    local function nix_env()
        nix_env = os.getenv("NIX_ENV")
        if nix_env ~= nil then
            return ("%s"):format(nix_env)
        end

        return ""
    end

    local function python_venv()
        local function env_cleanup(venv)
            if string.find(venv, "/") then
                local final_venv = venv
                for w in venv:gmatch("([^/]+)") do
                    final_venv = w
                end
                venv = final_venv
            end
            return venv
        end

        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
            if venv then
                return ("%s"):format(env_cleanup(venv))
            end
            venv = os.getenv("VIRTUAL_ENV")
            if venv then
                return ("%s"):format(env_cleanup(venv))
            end
        end
        return ""
    end

    local mini_sections = {
        lualine_a = { "filetype" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }

    local outline = {
        section = mini_sections,
        filetypes = { "lspsagaoutline" }
    }

    local diffview = {
        sections = mini_sections,
        filetypes = { "DiffviewFiles" }
    }

    local opts = {
        options = {
            icons_enabled = true,
            theme = "nord",
            component_separators = "|",
            section_separators = { left = "", right = ""},
            disabled_filetypes = {
            },
          },
        sections = {
            lualine_a = { { "mode" }},
            lualine_b = { { "branch" }, { "diff" }},
            lualine_c = { { get_cwd }},
            lualine_x = { 
                { escape_status },
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warning,
                        info = icons.diagnostics.Infomation,
                    }
                }
            },
            lualine_y = {
                {
                    "filetype",
                    colored = true,
                    icon_only = true
                },
                { python_venv },
                { nix_env },
                { "encoding" },
                {
                    "fileformat",
                    icons_enabled = true,
                    symbols = {
                        unix = "LF",
                        dos = "CRLF",
                        mac = "CR"
                    }
                }
            },
            lualine_z = { "progress", "location" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {
            "fugitive",
            "neo-tree",
            "nvim-dap-ui",
            "quickfix",
            "toggleterm",
            outline,
            diffview
        }
    }
end


function config.nvim_hlslens()
    local opt = {
        auto_enable = true,
        float_shadow_blend = 60
    }
    require("scrollbar.handlers.search").setup(opt)
end


function config.nvim_scrollbar()
    local function get_color(name, hl)
        local hl = hl or false
        if hl then
            local rgb = api.nvim_get_hl_by_name(name).foreground
        else
            local rgb = api.nvim_get_color_by_name(name)
        end

        return ("#%06x").format(rgb)
    end

    local opt = {
        handle = {
            color = nvim_get_hl_by_name("Normal", true).background
        },
        marks = {
            Search = { color = get_color("orange") },
            Error = { color = get_color("Error", true) },
            Warn = { color = get_color("WarningMsg", true) },
            Info = { color = get_color("blue2") },
            Hint = { color = get_color("teal") },
            Misc = { color = get_color("perple") },
        }
    }
    require("scrollbar").setup(opt)
end


function config.notify()
    local notify = require("notify")
    local icons = {
        diagnostics = requiree("modules.ui.icons").get("diagnostics"),
        ui = require("modules.ui.icons").get("icons")
    }

    local opt = {
        stages = "fade",
        timeout = 2000,
        minimum_width = 50,
        level = "TRACE",
        icons = {
            ERROR = icons.diagnostics.Error,
            WARN = icons.diagnostics.Warning,
            INFO = icons.diagnostics.Infomation,
            DEBUG = icons.ui.Bug,
            TRACE = icons.ui.Pencil,
        }
    }

    notify.setup(opt)
    vim.notify = notify
end

