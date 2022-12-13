local tex = {
    command = "latexmk"
}
local tmptex = {
    exec = {
       'mv %s %a/tmptex.latex',
       'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
    },
    args = vim.fn.expand("%:p:h:gs?\\\\?/?"),
    outputter = "error",
}

tmptex["outputter/error/error"] = "quickfix"
tmptex["hook/eval/enable"] = 1
tmptex["hook/eval/cd"] = "%s:r"
tmptex["hook/eval/template"] = '\\documentclass{jsarticle}'
            .. '\\usepackage[dvipdfmx]{graphicx, hyperref}'
            .. '\\usepackage{float}'
            .. '\\usepackage{amsmath,amssymb,amsthm,ascmac,mathrsfs}'
            .. '\\allowdisplaybreaks[1]'
            .. '\\theoremstyle{definition}'
            .. '\\newtheorem{theorem}{定理}'
            .. '\\newtheorem*{theorem*}{定理}'
            .. '\\newtheorem{definition}[theorem]{定義}'
            .. '\\newtheorem*{definition*}{定義}'
            .. '\\renewcommand\\vector[1]{\\mbox{\\boldmath{\\(#1\\)}} }'
            .. '\\begin{document}'
            .. '%s'
            .. '\\end{document}'
tmptex["hook/sweep/files"] = {
    '%a/tmptex.aux',
    '%a/tmptex.dvi',
    '%a/tmptex.fdb_latexmk',
    '%a/tmptex.fls',
    '%a/tmptex.latex',
    '%a/tmptex.log',
    '%a/tmptex.out',
}

vim.g.quickrun_config.tmptex = tmptex
