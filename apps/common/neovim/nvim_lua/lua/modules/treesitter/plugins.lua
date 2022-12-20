local ts = {}
local conf = require("modules.treesitter.config")

ts["RRethy/vim-illuminate"] = {
    opt = true,
    after = { "nvim-treesitter" },
    config = conf.vim_illuminate
}

ts["zbirenbaum/neodim"] = {
    opt = true,
    after = { "nvim-treesitter" },
    event = "LspAttach",
    config = conf.neodim
}

ts["mfussenegger/nvim-treehopper"] = {
    opt = true,
    after = { "nvim-treesitter" },
}

ts["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = "BufReadPost",
    config = conf.nvim_treesitter
}

ts["windwp/nvim-ts-autotag"] = {
    opt = true,
    after = { "nvim-treesitter" },
}

ts["JoosepAlviste/nvim-ts-context-commentstring"] = {
    opt = true,
    after = { "nvim-treesitter" },
}

ts["p00f/nvim-ts-rainbow"] = {
    opt = true,
    after = { "nvim-treesitter" },
}

ts["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
    after = { "nvim-treesitter" },
}

ts["andymass/vim-matchup"] = {
    opt = true,
    after = { "nvim-treesitter" },
}


return ts

