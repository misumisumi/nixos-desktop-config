local tools = {}
local conf = require("modules.tools.config")


-- CodePallet
tools["mrjones2014/legendary.nvim"] = {
    opt = true,
    requires = {
        {
            "stevearc/dressing.nvim",
            opt = true,
            config = conf.dressing },
        { "kkharji/sqlite.lua", opt = true },
        { "folke/which-key.nvim", opt = false }
    },
    cmd = "Legendary",
    config = conf.legendary
}

tools["nvim-lua/plenary.nvim"] = { opt=false }

tools["nvim-tree/nvim-web-devicons"] = { opt=false }

tools["MunifTanjim/nui.nvim"]={ opt=false }

tools["nvim-neo-tree/neo-tree.nvim"] = {
    opt = true,
    branch = "v2.x",
    requires = {
        { "nvim-lua/plenary.nvim", opt=false },
        { "nvim-tree/nvim-web-devicons", opt=false },
        { "MunifTanjim/nui.nvim", opt=false },
    },
    cmd = {
        "Neotree",
        "NeoTreeShow",
        "NeoTreeShowToggle",
        "NeoTreeShowInSplit",
        "NeoTreeShowInSplitToggle",
    },
    config = conf.neo_tree
}

-- For neo-tree
tools["s1n7ax/nvim-window-picker"] = {
    opt=true,
    after = "neo-tree.nvim",
    config = conf.window_picker,
}


-- Codeの部分実行
tools["michaelb/sniprun"] = {
    opt = true,
    run = "bash ./install.sh",
    cmd = {
        "SnipRun",
        "<,'>SnipRun",
        "SnipInfo"
    },
    config = conf.sniprun
}

-- Show trouble
tools["folke/trouble.nvim"] = {
    opt = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = conf.trouble,
}

tools["mbbill/undotree"] = {
    opt = true,
    cmd = "UndotreeToggle",
    config = conf.undotree
}
tools["Shougo/vimproc.vim"] = {
    opt = true,
    run = "make",
    after = "vim-quickrun"
}

tools["thinca/vim-quickrun"] = {
    opt = true,
    cmd = "QuickRun",
    -- config = conf.vimproc
}

tools["dstein64/vim-startuptime"] = {
    opt = true,
    cmd = "StartupTime"
}

tools["folke/which-key.nvim"] = {
    opt = false,
    config = conf.which_key
}

tools["gelguy/wilder.nvim"] = {
    event = "CmdlineEnter",
    requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
    config = conf.wilder
}

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    cmd = "ToggleTerm",
    config = conf.toggleterm
}

tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    requires = {
        { "nvim-lua/plenary.nvim", opt = false },
        { "nvim-lua/popup.nvim", opt = true }
    },
    module = "telescope",
    cmd = {
        "Telescope"
    },
    config = conf.telescope
}

tools["dhruvmanila/telescope-bookmarks.nvim"] = {
    opt = true,
}

tools["sudormrfbin/cheatsheet.nvim"] = {
    opt = true,
    cmd = "Cheatsheet"
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    requires = {
        {
            "kkharji/sqlite.lua",
            opt = true
        },
        {
            "nvim-tree/nvim-web-devicons",
            opt = true,
        }
    }
}

tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make"
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
    after = "telescope.nvim",
    config = conf.telescope_tabs
}

tools["chip/telescope-software-licenses.nvim"] = {
    opt = true,
}

tools["jvgrootveld/telescope-zoxide"] = {
    opt = true
}

return tools

