-- hi there future asb, this is for u

-- theme & transparency
vim.cmd.colorscheme("horizon")

-- Basic settings
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 4        -- Tab width
vim.opt.shiftwidth = 4     -- Indent width
vim.opt.softtabstop = 4    -- Soft tab stop
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch = false  -- Don't highlight search results
vim.opt.incsearch = true  -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                      -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                        -- Always show sign column

vim.opt.showmatch = true                          -- Highlight matching brackets
vim.opt.matchtime = 2                             -- How long to show matching bracket
vim.opt.cmdheight = 1                             -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false                          -- Don't show mode in command line
vim.opt.pumheight = 10                            -- Popup menu height
vim.opt.pumblend = 10                             -- Popup menu transparency
vim.opt.winblend = 0                              -- Floating window transparency
vim.opt.conceallevel = 0                          -- Don't hide markup
vim.opt.concealcursor = ""                        -- Don't hide cursor line markup
vim.opt.lazyredraw = true                         -- Don't redraw during macros
vim.opt.synmaxcol = 300                           -- Syntax highlighting limit

-- File handling
vim.opt.backup = false                            -- Don't create backup files
vim.opt.writebackup = false                       -- Don't create backup before writing
vim.opt.swapfile = false                          -- Don't create swap files
vim.opt.undofile = true                           -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300                          -- Faster completion
vim.opt.timeoutlen = 500                          -- Key timeout duration
vim.opt.ttimeoutlen = 0                           -- Key code timeout
vim.opt.autoread = true                           -- Auto reload files changed outside vim
vim.opt.autowrite = false                         -- Don't auto save

-- Behavior settings
vim.opt.hidden = true                   -- Allow hidden buffers
vim.opt.errorbells = false              -- No error bells
vim.opt.backspace = "indent,eol,start"  -- Better backspace behavior
vim.opt.autochdir = false               -- Don't auto change directory
vim.opt.iskeyword:append("-")           -- Treat dash as part of word
vim.opt.path:append("**")               -- include subdirectories in search
vim.opt.selection = "exclusive"         -- Selection behavior
vim.opt.mouse = "a"                     -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true               -- Allow buffer modifications
vim.opt.encoding = "UTF-8"              -- Set encoding

-- -- Folding settings
-- vim.opt.foldmethod = "expr"                        -- Use expression for folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"    -- Use treesitter for folding
-- vim.opt.foldlevel = 99                             -- Start with all folds open

-- Set folding options
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Key mappings
vim.g.mapleader = " "      -- Set leader key to space
vim.g.maplocalleader = "," -- Set local leader key (NEW)

-- Normal mode mappings
vim.keymap.set("n", "c", ":nohlsearch", { desc = "Clear search highlights" })

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
vim.keymap.set("n", "bn", ":bnext", { desc = "Next buffer" })
vim.keymap.set("n", "bp", ":bprevious", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "sv", ":vsplit", { desc = "Split window vertically" })
vim.keymap.set("n", "sh", ":split", { desc = "Split window horizontally" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent right and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick file navigation
vim.keymap.set("n", "e", ":Explore", { desc = "Open file explorer" })
vim.keymap.set("n", "ff", ":find ", { desc = "Find file" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "rc", ":e $MYVIMRC", { desc = "Edit config" })
vim.keymap.set("n", "rl", ":so $MYVIMRC", { desc = "keload config" })

-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

-- Copy Full File-Path
vim.keymap.set("n", "pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		local line = mark[1]
		local ft = vim.bo.filetype
		if line > 0 and line <= lcount
		    and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
		    and not vim.o.diff then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Set filetype-specific settings
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   pattern = { "lua", "python" },
--   callback = function()
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   pattern = { "javascript", "typescript", "json", "html", "css" },
--   callback = function()
--     vim.opt_local.tabstop = 2
--     vim.opt_local.shiftwidth = 2
--   end,
-- })

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand(':p:h')
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, 'p')
		end
	end,
})

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- ============================================================================
-- TABS
-- ============================================================================

-- Tab display settings
vim.opt.showtabline = 1 -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''    -- Use default tabline (empty string uses built-in)

-- Transparent tabline appearance
vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Function to open file in new tab
local function open_file_in_tab()
	vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
		if input and input ~= '' then
			vim.cmd('tabnew ' .. input)
		end
	end)
end

-- Function to duplicate current tab
local function duplicate_tab()
	local current_file = vim.fn.expand('%:p')
	if current_file ~= '' then
		vim.cmd('tabnew ' .. current_file)
	else
		vim.cmd('tabnew')
	end
end

-- Function to close tabs to the right
local function close_tabs_right()
	local current_tab = vim.fn.tabpagenr()
	local last_tab = vim.fn.tabpagenr('$')

	for i = last_tab, current_tab + 1, -1 do
		vim.cmd(i .. 'tabclose')
	end
end

-- Function to close tabs to the left
local function close_tabs_left()
	local current_tab = vim.fn.tabpagenr()

	for i = current_tab - 1, 1, -1 do
		vim.cmd('1tabclose')
	end
end

-- Alternative navigation (more intuitive)
vim.keymap.set('n', 'ta', ':tabnew', { desc = 'New tab' })
vim.keymap.set('n', 'tt', ':tabclose', { desc = 'Close tab' })
vim.api.nvim_set_keymap("n", "to", ":tabonly", { noremap = true })
vim.api.nvim_set_keymap("n", "tl", ":tabn", { noremap = true })
vim.api.nvim_set_keymap("n", "th", ":tabp", { noremap = true })

-- Tab moving
vim.keymap.set('n', 't>', ':tabmove +1', { desc = 'Move tab right' })
vim.keymap.set('n', 't<', ':tabmove -1', { desc = 'Move tab left' })

-- Enhanced keybindings
vim.keymap.set('n', 'tO', open_file_in_tab, { desc = 'Open file in new tab' })
vim.keymap.set('n', 'td', duplicate_tab, { desc = 'Duplicate current tab' })
vim.keymap.set('n', 'tr', close_tabs_right, { desc = 'Close tabs to the right' })
vim.keymap.set('n', 'tL', close_tabs_left, { desc = 'Close tabs to the left' })

-- add more custom keybinds
-- need to do stuff for comments, ciw rewrite, and ctrl + n for
-- doing Vex (limited)

local function toggle_netrw()
	-- Look for an open netrw window
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	-- Not open → open it
	vim.cmd("Vex")

	-- Force it to the far left
	vim.cmd("wincmd H")
	vim.cmd("vertical resize 30")
	vim.cmd("setlocal winfixwidth")
end

vim.keymap.set("n", "<C-n>", toggle_netrw, { noremap = true, silent = true })


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ "" }, '<c-s>', ':w!<CR>', opts)
vim.keymap.set({ 'n', 'v' }, '<leader>bb', ':buffers<CR>:buffer ')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "P", '"_dp')

-- Exit on jk
vim.keymap.set({ "i", "v" }, "jk", "<ESC>", opts)

-- Map enter to ciw in normal mode
vim.keymap.set("n", "<CR>", "ciw", opts)
vim.keymap.set("n", "g<CR>", "<CR>", opts)

-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
	local buffers_in_tab = #vim.fn.tabpagebuflist()
	if buffers_in_tab > 1 then
		vim.cmd('bdelete')
	else
		-- If it's the only buffer in tab, close the tab
		vim.cmd('tabclose')
	end
end
vim.keymap.set('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })

-- ============================================================================
-- STATUSLINE
-- ============================================================================

-- Git branch function
local function git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return "  " .. branch .. " "
	end
	return ""
end

-- File type with icon
local function file_type()
	local ft = vim.bo.filetype
	local icons = {
		lua = "[LUA]",
		python = "[PY]",
		javascript = "[JS]",
		html = "[HTML]",
		css = "[CSS]",
		json = "[JSON]",
		markdown = "[MD]",
		vim = "[VIM]",
		sh = "[SH]",
	}

	if ft == "" then
		return "  "
	end

	return (icons[ft] or ft)
end

-- Word count for text files
local function word_count()
	local ft = vim.bo.filetype
	if ft == "markdown" or ft == "text" or ft == "tex" then
		local words = vim.fn.wordcount().words
		return "  " .. words .. " words "
	end
	return ""
end

-- File size
local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand('%'))
	if size < 0 then return "" end
	if size < 1024 then
		return size .. "B "
	elseif size < 1024 * 1024 then
		return string.format("%.1fK", size / 1024)
	else
		return string.format("%.1fM", size / 1024 / 1024)
	end
end

-- Mode indicators with icons
local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK", -- Ctrl-V
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK", -- Ctrl-S
		R = "REPLACE",
		r = "REPLACE",
		["!"] = "SHELL",
		t = "TERMINAL"
	}
	return modes[mode] or "  " .. mode:upper()
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat {
				"  ",
				"%{v:lua.mode_icon()}",
				"%#StatusLine#",
				" │ %f %h%m%r",
				"%{v:lua.git_branch()}",
				" │ ",
				"%{v:lua.file_type()}",
				" | ",
				"%{v:lua.file_size()}",
				"%=", -- Right-align everything after this
				"%l:%c  %P ", -- Line:Column and Percentage
			}
		end
	})
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
		end
	})
end

setup_dynamic_statusline()
