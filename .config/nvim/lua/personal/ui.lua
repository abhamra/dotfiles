-- show matching brackets/parenthesis
vim.opt.showmatch = true

-- disable startup message
vim.opt.shortmess:append("sI")

-- cmd display (set to zero to autohide)
vim.opt.cmdheight = 1

-- gutter sizing
vim.opt.signcolumn = "auto:2"

-- syntax highlighting
-- vim.opt.termguicolors = true
vim.opt.synmaxcol = 512

-- show line numbers
vim.opt.number = true

-- show tab line
vim.opt.showtabline = 2

-- default no line wrapping
vim.opt.wrap = true

-- set indents when wrapped
vim.opt.breakindent = true

-- Set folding options
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4

-- highlight cursor
vim.opt.cursorline = true
-- set cursorcolumn = true

-- show invisibles
vim.opt.listchars = { tab = "  ", trail = "·", extends = "»", precedes = "«", nbsp = "░" }
vim.opt.list = true

-- split style
vim.opt.splitbelow = true
vim.opt.splitright = true
