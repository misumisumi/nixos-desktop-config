local lang = {}
local conf = require("modules.treesitter.config")


lang["chrisbra/csv.vim"] = {
    opt = true,
    ft = "csv"
}

lang["akinsho/flutter-tools.nvim"] = {
    opt = true,
    requires = {
        { "nvim-lua/plenary.nvim", opt = false }
    },
    ft = "dart",
    config = conf.flutter_tools
}

lang["iamcco/markdown-preview.nvim"] = {
    opt = true,
    run = "cd app && yarn install",
    ft = "markdown",
    config = conf.md_preview
}

lang["simrat39/rust-tools.nvim"] = {
    opt = true,
    requires = {
        { "nvim-lua/plenary.nvim", opt = false }
    },
    ft = "rust",
    config = conf.rust_tools
}

lang["fatih/vim-go"] = {
    opt = true,
    ft = "go",
    -- event = "GoInstallBinaries",
    config = conf.vim_go
}

lang["lervag/vimtex"] = {
    opt = true,
    ft = "tex",
    config = conf.vimtex
}


return lang

