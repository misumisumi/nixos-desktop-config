function set_filetype(ext, filetype)
    vim.fn.autocmd(string.format("BufRead,BufNewFile %s setfiletype %s", ext, filetype))
end

set_filetype("*.md", "markdown")
set_filetype("*.ipynb", "jupyternotebook")

-- Terminal buffer options for fzf
-- autocmd! FileType fzf
-- autocmd  FileType fzf set noshowmode noruler nonu
