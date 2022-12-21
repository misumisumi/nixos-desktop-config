" 自動ファイル種類付
autocmd BufRead,BufNewFile *.md  setfiletype markdown
autocmd BufRead,BufNewFile *.ipynb  setfiletype jupyternotebook

" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu
