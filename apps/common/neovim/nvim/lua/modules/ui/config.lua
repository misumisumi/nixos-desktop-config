local config = {}


function config.catppuccin()
    local opts = {
        flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
        background = { light = "latte", dark = "mocha" },
        dim_inactive = {
            enabled = false,
            -- Dim inactive splits/windows/buffers.
            -- NOT recommended if you use old palette (a.k.a., mocha).
            shade = "dark",
            percentage = 0.15,
        },
        transparent_background = false,
        term_colors = true,
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        styles = {
            comments = { "italic" },
            properties = { "italic" },
            functions = { "italic", "bold" },
            keywords = { "bold" },
            operators = { "bold" },
            conditionals = { "bold" },
            loops = { "bold" },
            booleans = {},
            numbers = {},
            types = {},
            strings = {},
            variables = {},
        },
        integrations = {
            treesitter = true,
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
            aerial = false,
            barbar = false,
            beacon = false,
            cmp = true,
            coc_nvim = false,
            dap = { enabled = true, enable_ui = true },
            dashboard = true,
            fern = false,
            fidget = true,
            gitgutter = false,
            gitsigns = true,
            hop = true,
            illuminate = true,
            leap = false,
            lightspeed = false,
            lsp_saga = true,
            lsp_trouble = true,
            markdown = true,
            mason = true,
            mini = false,
            navic = { enabled = false },
            neogit = false,
            neotest = false,
            noice = false,
            notify = true,
            nvimtree = true,
            overseer = false,
            symbols_outline = false,
            telekasten = false,
            telescope = true,
            ts_rainbow = true,
            vim_sneak = false,
            vimwiki = true,
            which_key = true,
        },
        color_overrides = {
            mocha = {
                rosewater = "#F5E0DC",
                flamingo = "#F2CDCD",
                mauve = "#DDB6F2",
                pink = "#F5C2E7",
                red = "#F28FAD",
                maroon = "#E8A2AF",
                peach = "#F8BD96",
                yellow = "#FAE3B0",
                green = "#ABE9B3",
                blue = "#96CDFB",
                sky = "#89DCEB",
                teal = "#B5E8E0",
                lavender = "#C9CBFF",

                text = "#D9E0EE",
                subtext1 = "#BAC2DE",
                subtext0 = "#A6ADC8",
                overlay2 = "#C3BAC6",
                overlay1 = "#988BA2",
                overlay0 = "#6E6C7E",
                surface2 = "#6E6C7E",
                surface1 = "#575268",
                surface0 = "#302D41",

                base = "#1E1E2E",
                mantle = "#1A1826",
                crust = "#161320",
            },
        },
        highlight_overrides = {
            mocha = function(cp)
                return {
                    -- For base configs.
                    CursorLineNr = { fg = cp.green },
                    Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
                    IncSearch = { bg = cp.pink, fg = cp.surface1 },
                    Keyword = { fg = cp.pink },
                    Type = { fg = cp.blue },
                    Typedef = { fg = cp.yellow },
                    StorageClass = { fg = cp.red, style = { "italic" } },

                    -- For native lsp configs.
                    DiagnosticVirtualTextError = { bg = cp.none },
                    DiagnosticVirtualTextWarn = { bg = cp.none },
                    DiagnosticVirtualTextInfo = { bg = cp.none },
                    DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

                    DiagnosticHint = { fg = cp.rosewater },
                    LspDiagnosticsDefaultHint = { fg = cp.rosewater },
                    LspDiagnosticsHint = { fg = cp.rosewater },
                    LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
                    LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

                    -- For fidget.
                    FidgetTask = { bg = cp.none, fg = cp.surface2 },
                    FidgetTitle = { fg = cp.blue, style = { "bold" } },

                    -- For treesitter.
                    ["@field"] = { fg = cp.rosewater },
                    ["@property"] = { fg = cp.yellow },

                    ["@include"] = { fg = cp.teal },
                    -- ["@operator"] = { fg = cp.sky },
                    ["@keyword.operator"] = { fg = cp.sky },
                    ["@punctuation.special"] = { fg = cp.maroon },

                    -- ["@float"] = { fg = cp.peach },
                    -- ["@number"] = { fg = cp.peach },
                    -- ["@boolean"] = { fg = cp.peach },

                    ["@constructor"] = { fg = cp.lavender },
                    -- ["@constant"] = { fg = cp.peach },
                    -- ["@conditional"] = { fg = cp.mauve },
                    -- ["@repeat"] = { fg = cp.mauve },
                    ["@exception"] = { fg = cp.peach },

                    ["@constant.builtin"] = { fg = cp.lavender },
                    -- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
                    -- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
                    ["@type.qualifier"] = { link = "@keyword" },
                    ["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

                    -- ["@function"] = { fg = cp.blue },
                    ["@function.macro"] = { fg = cp.red, style = {} },
                    ["@parameter"] = { fg = cp.rosewater },
                    ["@keyword"] = { fg = cp.red, style = { "italic" } },
                    ["@keyword.function"] = { fg = cp.maroon },
                    ["@keyword.return"] = { fg = cp.pink, style = {} },

                    -- ["@text.note"] = { fg = cp.base, bg = cp.blue },
                    -- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
                    -- ["@text.danger"] = { fg = cp.base, bg = cp.red },
                    -- ["@constant.macro"] = { fg = cp.mauve },

                    -- ["@label"] = { fg = cp.blue },
                    ["@method"] = { style = { "italic" } },
                    ["@namespace"] = { fg = cp.rosewater, style = {} },

                    ["@punctuation.delimiter"] = { fg = cp.teal },
                    ["@punctuation.bracket"] = { fg = cp.overlay2 },
                    -- ["@string"] = { fg = cp.green },
                    -- ["@string.regex"] = { fg = cp.peach },
                    ["@type"] = { fg = cp.yellow },
                    ["@variable"] = { fg = cp.text },
                    ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
                    ["@tag"] = { fg = cp.peach },
                    ["@tag.delimiter"] = { fg = cp.maroon },
                    ["@text"] = { fg = cp.text },

                    -- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
                    -- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
                    -- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
                    -- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
                    -- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
                    -- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
                    -- ["@string.escape"] = { fg = cp.pink },

                    -- ["@property.toml"] = { fg = cp.blue },
                    -- ["@field.yaml"] = { fg = cp.blue },

                    -- ["@label.json"] = { fg = cp.blue },

                    ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
                    ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

                    ["@field.lua"] = { fg = cp.lavender },
                    ["@constructor.lua"] = { fg = cp.flamingo },

                    ["@constant.java"] = { fg = cp.teal },

                    ["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
                    -- ["@constructor.typescript"] = { fg = cp.lavender },

                    -- ["@constructor.tsx"] = { fg = cp.lavender },
                    -- ["@tag.attribute.tsx"] = { fg = cp.mauve },

                    ["@type.css"] = { fg = cp.lavender },
                    ["@property.css"] = { fg = cp.yellow, style = { "italic" } },

                    ["@property.cpp"] = { fg = cp.text },

                    -- ["@symbol"] = { fg = cp.flamingo },
                }
            end,
        },
    }

    require("catppuccin").setup(opts)
end


function config.onedark()
    local opts = {
        style = "darker",
        transparent = false,
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

    require('onedark').setup(opts)
end


function config.alpha()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣔⡿⡟⣧⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢼⣿⣿⣾⣿⣿⣷⠀⣠⣄⣀⡀⠀⠀⠀⠀⠀⣰⣿⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣇⠀⣰⣾⣶⣶⣿⣿⡄⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⣀⣄⡀⠀⣀⡀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⡆⠀⠀⠀ ]],
        [[⢀⣤⣶⣿⣿⣿⣷⣿⣿⡿⢀⣴⣿⡿⢻⣿⣿⡿⣿⣿⣿⣿⠛⢱⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⠀⠀⠀ ]],
        [[⣿⣦⣽⣿⡉⢹⣿⣿⣧⣶⣿⡿⠋⠀⣼⣿⣿⣿⣿⣿⠟⠁⠂⣿⡿⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀ ]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣤⣶⣿⣿⣿⣿⣿⡟⣡⣿⣿⡄⣿⠁⠠⣿⣿⠏⣿⡿⣿⣿⣿⣿⣿⣄⡀⠀⠀ ]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠘⢹⣿⣿⣷⣷⣶⣾⣦⣿⣀⠀⣿⡿⡀⣿⣇⣹⣿⣹⡇⠘⣿⡇⠀⠀ ]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⣿⠟⠛⠛⠿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣽⣿⣿⣷⡀⠉⠁⠀⠀ ]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢁⡶⠀⠀⠄⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀ ]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⠁⠀⠀⢀⣿⣇⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀ ]],
        [[⣿⠿⠿⠿⠛⠛⠋⠁⠀⠘⣿⠀⠀⠀⠀⢻⣿⣶⣤⣶⣿⣿⣿⣿⣿⣿⣿⠟⠋⠉⠉⠛⠿⠏⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠀⠀⠀⢰⣦⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⠄⠀⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡄⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⠛⠛⠻⠿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⢀⡀⢴ ]],
        [[⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣦⠀⠀⠀⠈⠙⠛⠛⢿⣿⣿⣦⣤⣀⣴⣿⣿⣿⣿⣿⡿⠀⠀⣀⣤⣤⣾⠿⣿⠷ ]],
        [[⠀⠀⠀⢀⣴⣿⣿⡿⠿⣿⣿⣷⠀⣀⠀⠀⣴⠋⢰⣿⣿⣿⣿⡿⢿⡟⢛⣿⣿⣿⠃⠀⣀⡈⠀⠁⠀⠛⠛⠛ ]],
        [[⠀⠀⠀⠁⠀⠀⠀⠀⣼⣿⣿⣿⣷⡸⣷⣮⣿⣴⣿⣿⣿⣿⣿⣧⣠⣷⣿⣿⣿⠋⡀⣰⣿⡧⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠿⠹⠿⠿⠛⣿⣿⣟⣥⡞⣴⣿⣿⣿⣶⠀⠀⠀⠀⠀ ]],
    }

    dashboard.section.header.opts.hl = "Type"

    local function button(sc, txt, leader_txt, keybind, keybind_opts)
        local sc_after = sc:gsub("%s", ""):gsub(leader_txt, "<leader>")

        local opts = {
            position = "center",
            shortcut = sc,
            cursor = 5,
            width = 50,
            align_shortcut = "right",
            hl_shortcut = "Keyword",
        }

        if nil == keybind then
            keybind = sc_after
        end
        keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_after, keybind, keybind_opts }

        local function on_press()
            -- local key = vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
            local key = vim.api.nvim_replace_termcodes(sc_after .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
        end

        return {
            type = "button",
            val = txt,
            on_press = on_press,
            opts = opts,
        }
    end

    local leader = " "
    dashboard.section.buttons.val = {
        button("space f n", " File new", leader, "<cmd>enew<cr>"),
        button("space f f", " File find", leader, "<cmd>Telescope find_files<cr>"),
        button("space f r", " File frecency", leader, "<cmd>Telescope frecency<cr>"),
        button("space f e", " File history", leader, "<cmd>Telescope oldfiles<cr>"),
        button("space f p", " Project find", leader, "<cmd>Telescope project<cr>"),
        button("space f w", " Word find", leader, "<cmd>Telescope live_grep<cr>"),
        button("space f c", " Scheme change", leader, "<cmd>Telescope colorscheme<cr>"),
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
    local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
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

    if vim.g.colors_name == "catppuccin" then
        local cp = require("catppuccin.palettes").get_palette() -- Get the palette.
        cp.none = "NONE" -- Special setting for complete transparent fg/bg.

        local catppuccin_hl_overwrite = {
            highlights = require("catppuccin.groups.integrations.bufferline").get({
                styles = { "italic", "bold" },
                custom = {
                    mocha = {
                        -- Hint
                        hint = { fg = cp.rosewater },
                        hint_visible = { fg = cp.rosewater },
                        hint_selected = { fg = cp.rosewater },
                        hint_diagnostic = { fg = cp.rosewater },
                        hint_diagnostic_visible = { fg = cp.rosewater },
                        hint_diagnostic_selected = { fg = cp.rosewater },
                    },
                },
            }),
        }

        opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)
    end

    require("bufferline").setup(opts)
end


function config.fidget()
    local opts = {
        window = {
            blend = 0
        }
    }
    require("fidget").setup(opts)
end


function config.gitsigns()
    local km = { gitsigns = require("modules.lazy_keymap").gitsigns }

    local opts = {
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "│",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "_",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "~",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        on_attach = function()
            local gs = package.loaded.gitsigns
            km.gitsigns(gs)
        end
    }

    require("gitsigns").setup(opts)
    require("scrollbar.handlers.gitsigns").setup()
end


function config.indent_blankline()
    local opts = {
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

    require("indent_blankline").setup(opts)
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
        local cwd = vim.fn.getcwd()
        local home = require("core.global").home
        if cwd:find(home, 1, true) == 1 then
            cwd = "~" .. cwd:sub(#home + 1)
        end

        return icons.ui.RootFolderOpened .. cwd
    end

    local function nix_env()
        local env = os.getenv("NIX_ENV")
        if env ~= nil then
            return ("%s"):format(env)
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
            -- section_separators = { left = "", right = ""},
            disabled_filetypes = {
            },
          },
        sections = {
            lualine_a = { { "mode" }},
            lualine_b = { { "branch" }, { "diff" }},
            lualine_c = { { get_cmd }},
            lualine_x = {
                { escape_status },
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warning,
                        info = icons.diagnostics.Information,
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

    require("lualine").setup(opts)
end


function config.nvim_hlslens()
    local opts = {
        auto_enable = true,
        float_shadow_blend = 60
    }
    require("scrollbar.handlers.search").setup(opts)
end


function config.nvim_scrollbar()
    local text = { "-", "=" }
    local function get_color(name)
        local rgb
        rgb = vim.api.nvim_get_color_by_name(name)

        return string.format("#%06x", rgb)
    end

    local function get_hl(name)
        local rgb
        rgb = vim.api.nvim_get_hl_by_name(name, true).foreground

        return string.format("#%06x", rgb)
    end

    local opts = {
        handle = {
            color = get_hl("Comment"),
            text = " ",
        },
        marks = {
            Cursor = { color = get_color("white"), text = " " },
            Search = { color = get_color("lightgreen"), text = text },
            Error = { color = get_color("magenta"), text = text },
            Warn = { color = get_color("yellow"), text = text },
            Info = { color = get_color("blue2"), text = text },
            Hint = { color = get_color("teal"), text = text },
            Misc = { color = get_color("purple"), text = text },
        }
    }
    require("scrollbar").setup(opts)
end


function config.notify()
    local icons = {
        diagnostics = require("modules.ui.icons").get("diagnostics"),
        ui = require("modules.ui.icons").get("ui")
    }

    local opts = {
        stages = "fade",
        timeout = 2500,
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
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
end



return config

