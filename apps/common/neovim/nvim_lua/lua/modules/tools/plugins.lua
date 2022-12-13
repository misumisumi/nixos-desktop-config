local tools = {}
local conf = require("modules.tools.config")


tools["nvim-neo-tree/neo-tree.nvim"] = {
    opt = true,
    branch = "v2.x",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    cmd = {
        "Neotree"
    },
    config = conf.neo_tree
}
