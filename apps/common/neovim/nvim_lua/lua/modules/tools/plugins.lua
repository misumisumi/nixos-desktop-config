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

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    config = conf.toggleterm
}

tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    tag = "0.1.0",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim"
    }
    config = conf.telescope
}

tools["dhruvmanila/telescope-bookmarks.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["sudormrfbin/cheatsheet.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim"
}

tools["nvim-telescope/telescope-live-grep-args.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["nvim-telescope/telescope-media-files.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["barrett-ruth/telescope-http.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["LukasPietzschmann/telescope-tabs"] = {
    opt = true,
    after = "telescope.nvim"
}

tools["chip/telescope-software-licenses.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}

