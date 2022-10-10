"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif

" vimpluginの有効化
if &compatible
  set nocompatible
  filetype plugin on
  filetype plugin indent on
  runtime macros/matchit.vim
endif

if has("autocmd")
  autocmd FileType markdown setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim setlocal sw=2 sts=2 ts=2 et
  autocmd FileType nix setlocal sw=2 sts=2 ts=2 et
endif

if has("clipboard")
  set clipboard=unnamed
endif

set termguicolors
set helplang=ja,en
set pastetoggle=<f5>;
set cmdheight=2
set hidden
set number
set clipboard+=unnamedplus
set title
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set nrformats=
set splitright
set history=200
set wildmenu
set wildmode=full "exコマンドの補完キー操作をzshライクにする
set splitright "上側にsplit
set splitbelow "下側にsplit
set smartcase
set encoding=utf-8 "文字コードの自動判別
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set ambiwidth=single " 全角文字は2文字使う
set incsearch
"
set fileformats=unix,dos,mac "改行コードの自動判別
set mouse=a
set list "制御文字の表示
set splitbelow
"透過率20%
set winblend=20 
set pumblend=20 
set nowrap
set colorcolumn=80,100
"highlight ColorColumn guibg=#696969 ctermbg=41
highlight ColorColumn guibg=#3B4048 ctermbg=238


"Fern
let g:fern#default_hidden=1

"fzf
"let g:fzf_layout={'down': '40%'}
let g:fzf_action={
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }
