-- [[ Basic Keymaps ]]
local opts = { noremap = true, silent = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Fast saving
vim.keymap.set("n", "<Leader>q", ":q!<CR>", opts)
vim.keymap.set({ "" }, '<c-s>', ':w!<CR>', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for tabby.nvim
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tt", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>th", ":tabp<CR>", { noremap = true })

-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
-- move current tab to next position
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "P", '"_dp')

-- Exit on jk
vim.keymap.set("i", "jk", "<ESC>", opts)

-- Exit visual on jk
vim.keymap.set("v", "jk", "<ESC>", opts)

-- Map enter to ciw in normal mode
vim.keymap.set("n", "<CR>", "ciw", opts)

-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-w><Left>", opts)
vim.keymap.set("n", "<C-l>", "<C-w><Right>", opts)
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", opts)
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", opts)
-- vim: ts=2 sts=2 sw=2 et
