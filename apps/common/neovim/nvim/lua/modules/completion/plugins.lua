local cmp = {}
local conf = require("modules.completion.config")


cmp["zbirenbaum/copilot.lua"] = {
    event = "VimEnter",
    config = conf.copilot,
}

cmp["zbirenbaum/copilot-cmp"] = {
    after = "copilot.lua",
    config = function()
        require("copilot_cmp").setup()
    end,
}

cmp["creativenull/efmls-configs-nvim"] = {
    opt = false,
    requires = "neovim/nvim-lspconfig",
}

cmp["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    config = conf.luasnip,
    requires = "rafamadriz/friendly-snippets",
}

cmp["glepnir/lspsaga.nvim"] = {
    opt = true,
    event = "LspAttach",
    config = conf.lspsaga,
}

cmp["ray-x/lsp_signature.nvim"] = {
    opt = true,
    after = "nvim-lspconfig"
}

cmp["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = conf.autopairs,
}

cmp["hrsh7th/nvim-cmp"] = {
    event = "InsertEnter",
    requires = {
        { "onsails/lspkind.nvim" },
        { "lukas-reineke/cmp-under-comparator" },
        { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
        { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
        { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-cmdline", after = "cmp-buffer" },
        { "kdheepak/cmp-latex-symbols", after = "cmp-cmdline" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "cmp-latex-symbols" },
        { "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
        { "f3fora/cmp-spell", after = "cmp-path" },
        { "andersevenrud/cmp-tmux", after = "cmp-spell" },
    },
    config = conf.cmp,
}

cmp["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
    config = conf.nvim_lsp,
}

cmp["williamboman/mason.nvim"] = {
    opt = false,
    requires = {
        {
            "williamboman/mason-lspconfig.nvim",
        },
        { "WhoIsSethDaniel/mason-tool-installer.nvim", config = conf.mason_install },
    },
}

return cmp
