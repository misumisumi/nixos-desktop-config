local ui = {}
local conf = require("modules.ui.config")

-- ColorScheme
ui["sainnhe/edge"] = {
    opt = false,
    config=conf.edge
}

ui["shaunsingh/nord.nvim"] = {
    opt = false,
    config=conf.nord
}

ui["rcarriga/nvim-notify"] = {
    opt = false,
    config = conf.nvim_notify
}

-- Start Menu
ui["goolord/alpha-nvim"] = { 
    opt = true,
    envent = "BufWinEnter",
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

ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = { "BufReadPost", "BufNewFile" },
    config = conf.gitsigns
}

ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = { "BufReadPost" }
}

ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    after = "nvim-lspconfig",
    config = conf.lualine
}

ui["zbirenbaum/neodim"] = {
    opt = true,
    event = "LspAttach",
    config = conf.neodim
}

ui["kevinhwang91/nvim-hlslens"] = {
    opt = true,
    after = "nvim-scrollbar",
    config = conf.nvim_hlslens
}

ui["petertriho/nvim-scrollbar"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.nvim_scrollbar
}

ui["mbill/undotree"] = {
    opt = true,
    cmd = "UndotreeToggle"
}
