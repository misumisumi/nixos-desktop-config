local tools = {}
local conf = require("modules.tools.config")

-- CodePallet
tools["mrjones2014/legendary.nvim"] = {
    opt = true,
    requires = {
        { "stevearc/dressing.nvim", opt = true, config = conf.dressing },
        { "kkharji/sqlite.lua", opt = true },
        { "folke/which-key.nvim", opt = true }
    },
    wants = {
        "dressing.nvim",
        "sqlite.lua",
        "which-key.nvim"
    },
    cmd = "Legendary",
    config = conf.legendary()
}

tools["nvim-neo-tree/neo-tree.nvim"] = {
    opt = true,
    branch = "v2.x",
    requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "nvim-tree/nvim-web-devicons", opt = true },
        { "MunifTanjim/nui.nvim", opt = true },
        { "s1n7ax/nvim-window-picker", opt = true }  -- Optional independent
    },
    cmd = {
        "Neotree"
    },
    config = conf.neo_tree
}

-- Codeの部分実行
tools["michaelb/sniprun"] = {
    opt = true,
    run = "bash ./install.sh",
    cmd = {
        "SnipRun",
        "SnipInfo"
    },
    config = conf.sniprun
}

-- Show trouble
tools["folke/trouble.nvim"] = {
    opt = true,
}

tools["thinca/vim-quickrun"] = {
    opt = true,
    requires = {
        { "vimproc.vim", opt = true, run = make }
    },
    wants = "vimproc.vim",
    cmd = "QuickRun",
    config = conf.vimproc
}

tools["dstein64/vim-startuptime"] = {
    opt = true,
    cmd = "StartupTime" 
}

tools["folke/which-key.nvim"] = {
    opt = true
}

tools["mbill/undotree"] = {
    opt = true,
    cmd = "UndotreeToggle",
    config = conf.undotree
}

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    cmd = "ToggleTerm",
    config = conf.toggleterm
}

tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    tag = "0.1.0",
    requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "nvim-lua/plenary.nvim", opt = true },
    },
    wants = {
        "plenary",
        "popup",
        "telescope-bookmarks.nvim",
        "cheatsheet.nvim",
        "telescope-fzf-native.nvim",
        "telescope-live-grep-args.nvim",
        "telescope-media-files.nvim",
        "telescope-http.nvim",
        "telescope-project.nvim",
        "telescope-tabs",
        "telescope-software-licenses.nvim"
    },
    config = conf.telescope
}

tools["dhruvmanila/telescope-bookmarks.nvim"] = {
    opt = true,
}

tools["sudormrfbin/cheatsheet.nvim"] = {
    opt = true,
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    requires = {
        { "kkharji/sqlite.lua", opt = true },
        { "nvim-tree/nvim-web-devicons", opt = true }
    },
    wants = { "sqlite.lua", "nvim-web-devicons" },
}

tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
}

tools["nvim-telescope/telescope-live-grep-args.nvim"] = {
    opt = true,
}

tools["nvim-telescope/telescope-media-files.nvim"] = {
    opt = true,
}

tools["barrett-ruth/telescope-http.nvim"] = {
    opt = true,
}

tools["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
}

tools["LukasPietzschmann/telescope-tabs"] = {
    opt = true,
}

tools["chip/telescope-software-licenses.nvim"] = {
    opt = true,
}

