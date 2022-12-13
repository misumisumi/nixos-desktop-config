local uv, opt = vim.loop, vim.opt
local global = require("core.global")
local utils = require("core.utils")

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
        autoindent = true,
        autoread = true,
        autowrite = true,
        errorbells = true,
        expandtab = true,
        hidden = true, -- bufの移動時に警告が出なくなる
        ignorecase = true, -- 検索時に大文字小文字の違いを無視する
        incsearch = true,
        infercase = true, -- 補完で大文字小文字を区別しない
        linebreak = true,
        list = true, -- タブ文字などの可視化
        nowrap = true,
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
        wrapscan = true,
        linebreak = true, -- 単語で折り返す (wrapがONのとき)

        cmdheight = 2,
        history = 2000,
        pumblend = 20, -- ポップアップメニューの透過率(%)
        scrolloff = 3,
        shiftwidth = 4,
        tabstop = 4,
        timeoutlen = 0, -- You will feel delay when you input <Space> at lazygit interface if you set it a positive value like 300(ms).
        ttimeoutlen = 0, -- You will feel delay when you input <Space> at lazygit interface if you set it a positive value like 300(ms).
        winblend = 20, -- ウィンドウの透過率(%)

        -- backupdir = utils.joinpath(global.cache_dir, "backup"),
        -- directory = utils.joinpath(global.cache_dir, "swap"),
        -- spellfile = utils.joinpath(global.cache_dir, "spell", "en.utf-8.add"),
        -- viewdir = utils.joinpath(global.cache_dir, "view"),
        undodir = utils.joinpath(global.state_dir, "undo"),

        ambiwidth = "single", -- 全角は半角2文字分
        breakindentopt = "shift:2,min:20", -- 折り返された行を同じインデントにする (wrapが音のとき),
        colorcolumn = { 80, 100 },
        complete = ".,w,b,k", -- 補完の検索は"現在のバッファ,別ウィンドウのバッファ,読み込まれてる別のバッファ,英語単語辞書"
        display="listline", -- 行が折り返されてかつ行が折り返されているときに表示させる
        encoding = "utf-8",
        fileencodings = "utf-8,iso-2202-jp,euc-jp,sjis",
        fileformats = { "unix", "mac", "dos"},
        helplang = { "ja", "en" },
        mouse = "a",
        nrformts = "",
        sessionoptions = "curdir,tabpages,winsize",
        showbreak = "> ", -- インデントかつ折返しのとき行の先頭に識別子をつける
        swhitchbuf = "useopen",
        wildignore = search_ignore,
        wildmode = "longerst,full",
    }

    for name,value in paris(global_opts) do 
        opt[name] = value
        if string.find(name, "dir") ~= nil then
            uv.fs_mkdir(value, 511)
        end
        if string.find(name, "file") ~= nil then
            uv.fs_mkdir(vim.fn.fnamemodify(value, ":h"), 511)
        end
    end

    opt.iskeyword.remove("_")
    opt.matchpairs.append("<:>")
end

load_options()

