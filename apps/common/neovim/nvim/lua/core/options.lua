local uv, opt = vim.loop, vim.opt
local o = vim.o
local global = require("core.global")
local utils = require("utils")

local search_ignore = {
    ".git",
    "*.zip",
    "*.pyc",
    "*.o",
    "*.out",
    "**/tmp/**",
    "*.DS_Store",
    "__pycache__",
    -- for Unity
    "[Ll]ibrary",
    "[Tt]emp",
    "[Oo]bj",
    "[Bb]uild",
    "[Bb]uilds",
    "[Ll]ogs",
    "[Uu]ser[Ss]ettings",
    "*.pidb.meta",
    "*.pdb.meta",
    "*.mdb.meta",
    "**/[Aa]ssets/[Aa]ddressable[Aa]ssets[Dd]ata",
    "**/[Aa]ssets/[Ss]treamingAssets",
}

local function load_options()
    local global_opts = {
        backup = false,
        cursorcolumn = true,
        cursorline = true,
        foldenable = true,
        magic = true,
        relativenumber = true,
        ruler = true,
        smarttab = true,
        startofline = false,
        writebackup = false,
        autoindent = true,
        autoread = true,
        autowrite = true,
        errorbells = true,
        expandtab = true,
        hidden = true, -- bufの移動時に警告が出なくなる
        ignorecase = true, -- 検索時に大文字小文字の違いを無視する
        incsearch = true,
        infercase = true, -- 補完で大文字小文字を区別しない
        linebreak = true, -- 単語で折り返す (wrapがONのとき)
        list = true, -- タブ文字などの可視化
        number = true,
        shiftround = true,
        smartcase = true,
        smartindent = true,
        splitbelow = true,
        splitright = true,
        swapfile = false,
        termguicolors = true,
        timeout = true,
        title = true,
        ttimeout = true,
        visualbell = true,
        wildignorecase = true,
        wrap = false,
        wrapscan = true,

        cmdheight = 2,
        history = 2000,
        pumblend = 10, -- ポップアップメニューの透過率(%)
        scrolloff = 3,
        shiftwidth = 4,
        tabstop = 4,
        timeoutlen = 200, -- You will feel delay when you input <Space> at lazygit interface if you set it a positive value like 300(ms).
        ttimeoutlen = 200, -- You will feel delay when you input <Space> at lazygit interface if you set it a positive value like 300(ms).
        winblend = 10, -- ウィンドウの透過率(%)
        winwidth = 30,
        winminwidth = 10,
        cmdwinheight = 5,

        -- backupdir = utils.joinpath(global.cache_dir, "backup"),
        -- directory = utils.joinpath(global.cache_dir, "swap"),
        -- spellfile = utils.joinpath(global.cache_dir, "spell", "en.utf-8.add"),
        -- viewdir = utils.joinpath(global.cache_dir, "view"),
        undodir = utils.joinpath(global.state_dir, "undo"),

        ambiwidth = "single", -- 全角は半角2文字分
        breakindentopt = { "shift:2", "min:20" }, -- 折り返された行を同じインデントにする (wrapが音のとき),
        clipboard = "unnamedplus",
        colorcolumn = { 80, 100 },
        complete = { ".", "w", "b", "k" }, -- 補完の検索は"現在のバッファ,別ウィンドウのバッファ,読み込まれてる別のバッファ,英語単語辞書"
        display = "lastline", -- 行が折り返されてかつ行が折り返されているときに表示させる
        encoding = "utf-8",
        fileencodings = { "utf-8", "iso-2202-jp", "euc-jp", "sjis" },
        fileformats = { "unix", "mac", "dos"},
        helplang = { "ja", "en" },
        mouse = "a",
        nrformats = "",
        sessionoptions = { "curdir", "help", "tabpages", "winsize" },
        showbreak = "> ", -- インデントかつ折返しのとき行の先頭に識別子をつける
        switchbuf = "useopen",
        wildignore = search_ignore,
        wildmode = { "longest", "full" },

        inccommand = "nosplit",
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --hidden --vimgrep --smart-case --",
        breakat = [[\ \ ;:,!?]],
        whichwrap = "h,l,<,>,[,],~",
        backspace = "indent,eol,start",
        diffopt = "filler,iwhite,internal,algorithm:patience",
        completeopt = "menuone,noselect",
        jumpoptions = "stack",
        shortmess = "aoOTIcF",
        mousescroll = "ver:3,hor:6",
        listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
        signcolumn = "yes",
        formatoptions = "1jcroql",
    }

    for name,value in pairs(global_opts) do
        opt[name] = value
        if string.find(name, "dir") ~= nil then
            uv.fs_mkdir(value, 511)
        end
        -- if string.find(name, "spellfile") ~= nil then
        --     uv.fs_mkdir(vim.fn.fnamemodify(value, ":t"), 511)
        -- end
    end

    -- opt.iskeyword.remove("_")
    -- opt.matchpairs.append("<:>")
end

load_options()

