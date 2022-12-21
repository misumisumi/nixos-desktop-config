" LaTeX Quickrun
"let g:quickrun_config['tex'] = {
"\ 'command' : 'latexmk',
"\ 'outputter' : 'error',
"\ 'outputter/error/success' : 'null',
"\ 'outputter/error/error' : 'quickfix',
"\ 'exec': '%c, -gg -pdfxe %s',
"\}

"let g:quickrun_config = {
"\   'tex': {
"\       'runner' : 'vimproc',
"\       'runner/vimproc/updatetime' : 30,
"\       'outputter/error/success': 'buffer',
"\       'outputter/error/error': 'quickfix',
"\       'outputter/buffer/opener': '20new',
"\       'outputter/buffer/close_on_empty': 1,
"\       'command': 'latexmk',
"\       'exec': ['%c -gg -pdfxe %s']
"\   },
"\}

" 部分的に選択してコンパイル
" http://auewe.hatenablog.com/entry/2013/12/25/033416 を参考に
let g:quickrun_config.tmptex = {
\   'exec': [
\           'mv %s %a/tmptex.latex',
\           'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
\           ],
\   'args' : expand("%:p:h:gs?\\\\?/?"),
\   'outputter' : 'error',
\   'outputter/error/error' : 'quickfix',
\
\   'hook/eval/enable' : 1,
\   'hook/eval/cd' : "%s:r",
\
\   'hook/eval/template' : '\documentclass{jsarticle}'
\                         .'\usepackage[dvipdfmx]{graphicx, hyperref}'
\                         .'\usepackage{float}'
\                         .'\usepackage{amsmath,amssymb,amsthm,ascmac,mathrsfs}'
\                         .'\allowdisplaybreaks[1]'
\                         .'\theoremstyle{definition}'
\                         .'\newtheorem{theorem}{定理}'
\                         .'\newtheorem*{theorem*}{定理}'
\                         .'\newtheorem{definition}[theorem]{定義}'
\                         .'\newtheorem*{definition*}{定義}'
\                         .'\renewcommand\vector[1]{\mbox{\boldmath{\(#1\)}} }'
\                         .'\begin{document}'
\                         .'%s'
\                         .'\end{document}',
\
\   'hook/sweep/files' : [
\                        '%a/tmptex.aux',
\                        '%a/tmptex.dvi',
\                        '%a/tmptex.fdb_latexmk',
\                        '%a/tmptex.fls',
\                        '%a/tmptex.latex',
\                        '%a/tmptex.log',
\                        '%a/tmptex.out',
\                        ],
\}
