local config = {}
local use_ssh = require("pack_utils.settings").use_ssh


function config.vim_illuminate()
    local opts = {
        providers = {
            'lsp',
            'treesitter',
            'regex',
        },
        delay = 100,
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
            "alpha",
            "dashboard",
            "fugitive",
            "help",
            "norg",
            "NvimTree",
            "NeoTree",
            "Outline",
            "packer",
            "toggleterm"
        },
        under_cursor = false,
        }

    require("illuminate").configure(opts)
end


function config.neodim()
    local normal_background = vim.api.nvim_get_hl_by_name("Normal", true).background
    local opts = {
        alpha = 0.5,
        blend_color = normal_background ~= nil and ("#%06x").format(normal_background) or "#000000",
        update_in_insert = {
            enable = true,
            delay = 100,
        },
        hide = {
            virtual_text = true,
            signs = false,
            underline = false,
        }
    }

    require("neodim").setup(opts)
end


function config.nvim_colorizer()
    require("colorizer").setup()
end


function config.nvim_treesitter()
    local km = { textobject = require("modules.lazy_keymap").textobject() }
    local opts = {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "dart",
            "diff",
            "dockerfile",
            "go",
            "gomod",
            "html",
            "javascript",
            "json",
            "latex",
            "latex",
            "lua",
            "make",
            "markdown",
            "nix",
            "perl",
            "python",
            "rust",
            "toml",
            "typescript",
            "vue",
            "yaml",
        },
        autotag = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = true
        },
        highlight = {
            enable = true,
            disable = {
                "vim"
            },
            additional_vim_regex_highlighting = false,
        },
        textobject = {
            select = {
                enable = true,
                keymaps = km.textobject.select
            },
            move = {
                enable = true,
                set_jumpse = true,
                goto_next_start = km.textobject.move.goto_next_start,
                goto_next_end = km.textobject.move.goto_next_end,
                goto_previous_start = km.textobject.move.goto_previous_start,
                goto_previous_end = km.textobject.move.goto_previous_end,
            }
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 2000,
        },
        matchup = {
            enable = true
        }
    }

    require("nvim-treesitter.configs").setup(opts)
    require("nvim-treesitter.install").prefer_git = true
        if use_ssh then
            local parsers = require("nvim-treesitter.parsers").get_parser_configs()
            for _, p in pairs(parsers) do
                p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
            end
        end
    end


return config

