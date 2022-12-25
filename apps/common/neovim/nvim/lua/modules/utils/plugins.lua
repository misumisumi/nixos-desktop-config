local utils = {}
local conf = require("modules.utils.config")


utils["rainbowhxch/accelerated-jk.nvim"] = {
    opt = true,
    event = "BufWinEnter",
    config = conf.accelerated_jk
}

utils["max397574/better-escape.nvim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.better_escape
}

utils["famiu/bufdelete.nvim"] = {
    opt = true,
    cmd = {
        "Bdelete",
        "Bwipeout",
        "Bdelete!",
        "Bwipeout!",
    },
    config = conf.bufdelete
}

utils["rhysd/clever-f.vim"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.clever_f
}

utils["sindrets/diffview.nvim"] = {
    opt = true,
    cmd = { "DiffviewOpen", "DiffviewClose" },
}

utils["phaazon/hop.nvim"] = {
    opt = true,
    branch = "v2",
    event = "BufReadPost",
    config = conf.hop
}

-- utils["karb94/neoscroll.nvim"] = {
--     opt = true,
--     event = "BufReadPost",
--     config = conf.neoscroll
-- }

utils["terrortylor/nvim-comment"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.nvim_comment
}

utils["tyru/open-browser.vim"] = {
    opt = true,
    requires = {
        { "Shougo/vimproc.vim", opt = true, run = "make" }
    },
    cmd = {
        "OpenBrowser",
        "OpenBrowserSearch"
    },
    config = conf.open_browser
}

utils["folke/todo-comments.nvim"] = {
    opt = true,
    requires = "nvim-lua/plenary.nvim",
    wants = { "plenary.nvim" },
    event = "BufReadPost",
    config = conf.todo_comments
}

-- utils["ahmedkhalf/project.nvim"] = {
--     opt = true,
--     after = "telescope",
--     conf = config.project
-- }

utils["ntpeters/vim-better-whitespace"] = {
    opt = true,
    event = "BufWritePre",
    config = conf.better_whitespace
}

utils["romainl/vim-cool"] = {
    opt = true,
    event = { "CursorMoved", "InsertEnter" },
}

utils["junegunn/vim-easy-align"] = {
    opt = true,
    cmd = "EasyAlign",
}

utils["tpope/vim-fugitive"] = {
    opt = true,
    cmd = {
        "Git",
        "G",
        "Gwrite",
    }
}

utils["tpope/vim-repeat"] = {
    opt = true,
    event = "BufReadPost"
}

-- utils["tpope/vim-surround"] = {
--     opt = true,
--     event = "BufReadPost"
-- }

utils["kylechui/nvim-surround"] = {
    opt = true,
    event = "BufReadPost",
    config = conf.surround
}

utils["vim-jp/vimdoc-ja"] = {
    opt = false,
}


return utils

