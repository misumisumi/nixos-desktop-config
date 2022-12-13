local config = {}
local g = vim.g


function config.edge()
    g.edge_style = "aura"
    g.edge_enable_italic = 1
    g.edge_disable_italic_comment = 1
    g.edge_show_eob = 1
    g.edge_better_performance = 1
    g.edge_transparent_background = 1
end


function config.nord()
    g.nord_contrast = true
    g.nord_borders = true
    g.nord_disable_background = false
    g.cursorline_transparent = true
    g.nord_enable_sidebar_background = false
    g.nord_italic = true
    g.nord_uniform_diff_background = true
    g.nord_bold = true
end


function config.notify()
    local notify = require("notify")
    -- local icons = 

end


function config.alpha()
end


function config.bufferline_nvim()
end


function config.fidget()
end


function config.gitsigns()
end


function config.lualine()
end


function config.neodim()
end


function config.nvim_hlslens()
end


function config.nvim_scrollbar()
end


function config.undotree()
end
