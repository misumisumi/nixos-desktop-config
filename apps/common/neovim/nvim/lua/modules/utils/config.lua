local config = {}


function config.better_escape()
    local opts = {
        mapping = { "jk", "jj" },
        timeout = vim.g.timeoutlen,
        keys = "<esc>"
    }

    require("better_escape").setup(opts)
end


function config.clever_f()
    vim.api.nvim_set_hl(
        0,
        "CleverChar",
        {
            underline = true,
            bold = true,
            fg = "Orange",
            bg = "NONE",
            ctermfg = "Red",
            ctermbg = "NONE"
        }
    )
    vim.g.clever_f_mark_char_color = "CleverChar"
    vim.g.clever_f_mark_direct_color = "CleverChar"
    vim.g.clever_f_mark_direct = true
    vim.g.clever_f_timeout_ms = 1500
end


function config.hop()
    require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }
end


function config.neoscroll()
    local opts = {
        mappings = {
            '<C-u>',
            '<C-d>',
            '<C-b>',
            '<C-f>',
            '<C-y>',
            '<C-e>',
            'zt',
            'zz',
            'zb'
        },
        cursor_scrolls_alone = true,
        performance_mode = true,
    }
    require("neoscroll").setup(opts)
end


function config.nvim_comment()
    local opts = {
        hook = function()
            require("ts_context_commentstring.internal").update_commentstring()
        end
    }
    require("nvim_comment").setup(opts)
end


function config.open_browser()
    vim.g.openbrowser_search_engines = {
        ["duckduckgo"] = "https://duckduckgo.com/?q={query}",
        ["fileformat"] = "https://www.fileformat.info/info/unicode/char/{query}/",
        ["github"] = "https://github.com/search?q={query}",
        ["go"] = "https://pkg.go.dev/search?q={query}",
        ["google"] = "https://google.com/search?q={query}",
        ["php"] = "https://php.net/{query}",
        ["python"] = "https://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default",
        ["twitter-search"] = "https://twitter.com/search/{query}",
        ["twitter-user"] = "https://twitter.com/{query}",
        ["vim"] = "https://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1",
        ["wikipedia"] = "https://en.wikipedia.org/wiki/{query}",
        ["wikipedia-ja"] = "https://ja.wikipedia.org/wiki/{query}",
        ["archwiki"] = "https://wiki.archlinux.jp/index.php/{query}",
        ["nixos"] = " https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={query}",
        ["nixpkgs"] = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={query}",
        ["qiita"] = "https://qiita.com/search?q={query}",
        ["reddit"] = "https://www.reddit.com/search?q={query}",
        ["startpage"] = "https://www.startpage.com/do/search?q={query}",
        ["zenn"] = "https://zenn.dev/search?q={query}",
    }
    vim.g.openbrowser_default_search = "startpage"
    vim.g.openbrowser_use_vimproc = 1
end


function config.todo_comments()
    local icons = {
        ui = require("modules.ui.icons").get("ui", true),
        diagnostics = require("modules.ui.icons").get("diagnostics", true)
    }
    local opts = {
        keywords = {
            FIX = {
              icon = icons.ui.Bug,
              color = "error",
              alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
            },
            TODO = {
                icon = icons.ui.Check,
                color = "info"
            },
            HACK = {
                icon = icons.ui.Fire,
                color = "warning"
            },
            WARN = {
                icon = icons.diagnostics.Warning,
                color = "warning",
                alt = { "WARNING", "XXX" }
            },
            PERF = {
                icon = icons.ui.Perf,
                alt = { "OPTIM",
                "PERFORMANCE",
                "OPTIMIZE" }
            },
            NOTE = {
                icon = icons.ui.Note,
                color = "hint",
                alt = { "INFO" }
            },
            TEST = {
                icon = icons.ui.CodeAction,
                color = "test",
                alt = { "TESTING", "PASSED", "FAILED" }
            },
        },
        highlight = {
            multiline = true, -- enable multine todo comments
            exclude = {},
        },
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" }
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
    }
    require("todo-comments").setup(opts)

end


function config.better_whitespace()
    vim.g.better_whitespace_enabled = 0
    vim.g.better_whitespace_on_save = 0
    vim.g.current_line_whitespace_disabled_soft = 1
    vim.g.strip_whitespace_on_save = 1
    vim.g.strip_whitespace_confirm=0
end


function config.surround()
    local opts = {
        keymaps = {
            insert = "<C-g>s",
            insert_line = "<C-g>S",
            normal = "sa",
            normal_cur = "saa",
            normal_line = "sA",
            normal_cur_line = "sAA",
            visual = "sa",
            visual_line = "sA",
            delete = "ds",
            change = "cs",
        },
    }

    require("nvim-surround").setup(opts)
end

return config

