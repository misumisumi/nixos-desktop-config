local cmp = {}
local conf = require("modules.utils.config")


cmp["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
    config = conf.nvim_lsp
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

completion["creativenull/efmls-configs-nvim"] = {
    opt = false,
    requires = "neovim/nvim-lspconfig",

}

-- Commandlineの補完サポート
cmp["gelguy/wilder.nvim"] = {

}


