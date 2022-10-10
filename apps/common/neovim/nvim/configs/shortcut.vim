" カスタムショートカット
" リーダーをspaceに
let mapleader = "\<Space>"

nmap <Leader>n :Fern . -reveal=% -drawer -toggle<CR>
nmap <Leader>ss :source "~/.config/nvim/init.vim"<CR>
nmap <Leader><Enter> :15Term<CR>
au FileType quickrun,fzf nmap <silent><buffer>q :q<CR>
au FileType fern nmap <silent><buffer>E <Plug>(fern-action-open:vsplit)
imap <silent> jj <C-\><C-n>

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" pydoqstring
nmap <silent> ca <Plug>(coc-codeaction-line)
xmap <silent> ca <Plug>(coc-codeaction-selected)
nmap <silent> cA <Plug>(coc-codeaction)

nmap <Leader>qq :q<CR>
nmap <Leader>wq :wq<CR>

" For Buffer
nmap <silent> [b :bnext
nmap <silent> ]b :bprevious

" For easymotion
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Move to line
nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to word
nmap <Leader>w <Plug>(easymotion-overwin-w)

" For Tab
nmap <Tab> gt
nmap <S-Tab> gT
nmap <Leader><Tab> :tabnew<CR>

" For fzf.vim
nmap <Leader>f :<C-u>Files<CR>
nmap <Leader>b :<C-u>Buffers<CR>
nmap <Leader>w :<C-u>Windows<CR>
nmap <Leader>m :<C-u>Marks<CR>
nmap <Leader>h :<C-u>History<CR>
nmap <Leader>a :<C-u>Ag<CR>
nmap <Leader>r :<C-u>Rg<CR>
nmap <Leader>cm :<C-u>Command<CR>
nmap <Leader>gf :<C-u>GFiles<CR>

" For coc-fzf
nmap <Leader><space> :<C-u>CocFzfList<CR>
nmap <Leader>cda :<C-u>CocFzfList diagnostics<CR>
nmap <Leader>cdc :<C-u>CocFzfList diagnostics --current-buf<CR>
nmap <Leader>cc :<C-u>CocFzfList commands<CR>
nmap <Leader>cl :<C-u>CocFzfList location<CR>
nmap <Leader>co :<C-u>CocFzfList outline<CR>
nmap <Leader>cs :<C-u>CocFzfList symbols<CR>
nmap <Leader>cr :<C-u>CocFzfListResume<CR>

tmap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
tmap <expr> jj (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" command History
nmap <Leader>ch :<C-u>History:<CR>
" Search History
nmap <Leader>sh :<C-u>History/<CR>
nmap <Leader>map :<C-u>Maps<CR>
nmap <Leader>com :<C-u>Commit<CR>

" For quickrun
let g:quickrun_no_default_key_mappings = 1
au FileType python,sh nmap <Leader>p :write<CR>:QuickRun -mode n<CR>      
" au FileType tex vmap <Leader>p :QuickRun -mode v -type tmptex<CR>
au FileType nmap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

" For Markdown Preview
au FileType markdown nmap <Leader>p <Plug>MarkdownPreviewToggle
au FileType markdown nmap <Leader>ms <Plug>:MarpStart
au FileType markdown nmap <Leader>mq <Plug>:MarpStop

" when terminal
" Terminal起動時ESC or jjでcmd modeに戻れるようにする
tmap <silent> <Esc> <C-\><C-n>
tmap <silent> jj <C-\><C-n>

" Airline
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

" For fugitive
nmap <Leader>ga :Gwrite<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gs :Git<CR>
nmap <Leader>gd :Gdiffsplit<CR>
nmap <Leader>gp :Git push<CR>

" For vim-gitgutter
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterRevertHunk

" For open-browser
nmap <Leader>o <Plug>(openbrowser-smart-search)

