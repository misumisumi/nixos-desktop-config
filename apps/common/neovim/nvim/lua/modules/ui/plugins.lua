local ui = {}
local conf = require("modules.ui.config")


-- ColorScheme
ui["catppuccin/nvim"] = {
    opt = false,
    as = "catppuccin",
    config = conf.catppuccin
}

ui["navarasu/onedark.nvim"] = {
    opt = false,
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
    after = "nvim-scrollbar",
    -- after = "nvim-scrollview",
    config = conf.gitsigns
}

ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.indent_blankline
}

ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    requires = {
        { "kyazdani42/nvim-web-devicons", opt = true },
    },
    after = "nvim-lspconfig",
    config = conf.lualine
}

ui["kevinhwang91/nvim-hlslens"] = {
    opt = true,
    after = "gitsigns.nvim",
    config = conf.nvim_hlslens
}

ui["rcarriga/nvim-notify"] = {
    opt = false,
    config = conf.notify
}

-- ui["dstein64/nvim-scrollview"] = {
--     opt = true,
--     event = { "BufReadPost" },
--     config = conf.scrollview,
-- }

ui["petertriho/nvim-scrollbar"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.nvim_scrollbar
}


return ui

