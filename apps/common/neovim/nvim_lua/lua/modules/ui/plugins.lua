local ui = {}
local conf = require("modules.ui.config")

-- ColorScheme
ui["catppuccin/nvim"] = {
    opt = true,
    as = "catppuccin",
    event = { 
        "colorscheme catppuccin",
        "colorscheme catppuccin-latte",
        "colorscheme catppuccin-frappe",
        "colorscheme catppuccin-macchiato",
        "colorscheme catppuccin-mocha",
    },
    config = conf.catppuccin
}

ui["navarasu/onedark.nvim"] = {
    opt = true,
    event = {
        "colorscheme onedark"
    },
    config = conf.onedark
}

-- Start Menu
ui["goolord/alpha-nvim"] = { 
    opt = true,
    event = "BufWinEnter",
    config = conf.alpha
}

ui["akinsho/bufferline.nvim"] = {
    opt = true,
    tag = "*",
    event = "BufReadPost",
    config = conf.bufferline_nvim
}

-- Show LSP progress
ui["j-hui/fidget.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.fidget
}

-- Gitの差分表示
ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = { "BufReadPost", "BufNewFile" },
    config = conf.gitsigns
}

ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = { "BufReadPost" },
    config = conf.indent_blankline
}

ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    requires = {
        { "kyazdani42/nvim-web-devicons", opt = true },
    },
    wants = { "nvim-web-devicons" },
    after = "nvim-lspconfig",
    config = conf.lualine
}

ui["kevinhwang91/nvim-hlslens"] = {
    opt = true,
    after = "nvim-scrollbar",
    config = conf.nvim_hlslens
}

ui["rcarriga/nvim-notify"] = {
    opt = false,
    config = conf.notify
}

ui["petertriho/nvim-scrollbar"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.nvim_scrollbar
}

