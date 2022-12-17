local ts = {}
local conf = require("modules.treesitter.config")

ts["RRethy/vim-illuminate"] = {
    opt = true,
    wants = { "nvim-treesitter" },
    config = conf.vim_illuminate
}

ts["zbirenbaum/neodim"] = {
    opt = true,
    wants = { "nvim-treesitter" },
    event = "LspAttach",
    config = conf.neodim
}

ts["mfussenegger/nvim-treehopper"] = {
    opt = true,
    wants = { "nvim-treesitter" },
}

ts["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = "BufReadPost",
    config = conf.nvim_treesitter
}

ts["windwp/nvim-ts-autotag"] = {
    opt = true,
    wants = { "nvim-treesitter" },
}

ts["JoosepAlviste/nvim-ts-context-commentstring"] = {
    opt = true,
    wants = { "nvim-treesitter" },
}

ts["p00f/nvim-ts-rainbow"] = {
    opt = true,
    wants = { "nvim-treesitter" },
}

ts["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
    wants = { "nvim-treesitter" },
}

ts["andymass/vim-matchup"] = {
    opt = true,
    wants = { "nvim-treesitter" },
}

