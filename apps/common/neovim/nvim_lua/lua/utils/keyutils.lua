local vim = vim


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end


local utils = {}


utils.enhance_jk_move = function(key)
    local map = key == "j" and "<Plug>(accelerated_jk_gj)" or "<Plug>(accelerated_jk_gk)"

    return t(map)
end


utils.enhance_ft_move = function(key)
    local map = key == ";" and "<Plug>(clever-f-repeat-forward)" or "<Plug>(clever-f-repeat-forward)"

    return t(map)
end
