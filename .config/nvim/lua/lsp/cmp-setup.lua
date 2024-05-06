-- TODO: completely redo this entire file, from scratch, see if that helps (bitch)
-- also set up UltiSnips
-- [[ Configure nvim-cmp ]]
-- See `:help cmp`

local cmp = require 'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.select_prev_item(),
    ['<CR>']  = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Insert,
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', group_index = 1 },
    { name = 'luasnip',  group_index = 1 },
    { name = 'buffer',   group_index = 2 },
    { name = 'path',     group_index = 2 },
  })
})
