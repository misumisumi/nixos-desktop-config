local autocmd = {}


function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end


function autocmd.load_autocmds()
    local definitions = {
        packer = {},
        bufs = {
            { "BufWritePre", "/tmp/*", "setlocal noundofile" },
            { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
            { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
            { "BufWritePre", "*.tmp", "setlocal noundofile" },
            { "BufWritePre", "*.bak", "setlocal noundofile" },
            { "BufWritePost", "$MYVIMRC", "luafile $MYVIMRC" },

            -- Auto toggle fcitx5
            { "InsertLeave", "* :silent", "!fcitx5-remote -c" },
            { "BufCreate", "*", ":silent !fcitx5-remote -c" },
            { "BufEnter", "*", ":silent !fcitx5-remote -c " },
            { "BufLeave", "*", ":silent !fcitx5-remote -c " },
        },

        wins = {
            -- -- tmuxとneovimのfocus・unfocusを視覚的にわかりやすくする
            -- { "WinEnter", "*", ("highlight Normal guibg=%06x"):format(vim.api.nvim_get_hl_by_name("Normal", true).background) },
            -- { "WinEnter", "*", ("highlight NormalNc guibg=%06x"):format(vim.api.nvim_get_color_by_name("Black")) },
            -- { "FocusGained", "*", ("highlight Normal guibg=%06x"):format(vim.api.nvim_get_hl_by_name("Normal", true).background) },
            -- { "FocusLost", "*", ("highlight Normal guibg=%06x"):format(vim.api.nvim_get_color_by_name("Black")) },
            -- -- nvimを開いているウィンドウの大きさが変更されたとき各ウィンドウの大きさを均等にする
            -- { "VimResized", "*", [[tabdo wincmd =]] },
        },

        ft = {
        }
    }
end

autocmd.load_autocmds()
