local cmp = {}
local conf = require("modules.utils.config")


-- コードのAI補完
cmp["zbirenbaum/copilot.lua"] = {
    opt = true,
    event = "VimEnter",
    config = conf.copilot
}

cmp["creativenull/efmls-configs-nvim"] = {
    opt = false,
    requires = { "neovim/nvim-lspconfig" },
}

cmp["L3MON4D3/LuaSnip"] = {
    opt = true,
    after = { "nvim-cmp" },
    config = conf.luasnip
}

cmp["glepnir/lspsaga.nvim"] = {
    opt = true,
    event = "LspAttach",
    config = conf.lspsaga
}

cmp["ray-x/lsp_signature.nvim"] = {
    opt = true,
}

cmp["windwp/nvim-autopairs"] = {
    opt = true,
    after = { "nvim-cmp" },
    config = conf.nvim_autopairs
}

cmp["hrsh7th/nvim-cmp"] = {
    opt = true,
    event = "InsertEnter",
    requires = {
        { "onsails/lspkind.nvim" },
        { "lukas-reineke/cmp-under-comparator" },
        { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
        { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
        { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-cmdline", after = "cmp-buffer" },
        { "kdheepak/cmp-latex-symbols", after = "cmp-cmdline" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol", watns = "cmp-latex-symbols" },
        { "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
        { "f3fora/cmp-spell", after = "cmp-spell" },
        { "andersevenrud/cmp-tmux", after = "cmp-tmux" },
        { "zbirenbaum/copilot-cmp", after = { "cmp-tmux", "copilot.lua" } },
    },
    config = conf.nvim_cmp
}

cmp["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
    after = { 
        { "ray-x/lsp_signature.nvim" },
        { "glepnir/lspsaga.nvim" },
        { "hrsh7th/cmp-nvim-lsp" }
    },
    config = conf.nvim_lspconfig
}

cmp["williamboman/mason.nvim"] = {
    opt = false,
    requires = {{
        { "williamboman/mason-lspconfig.nvim" },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            config = conf.mason_install
        }
    }}
}

