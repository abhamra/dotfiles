return {
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.maplocalleader = ","
      vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull' }
    end
  },
  {
    "abhamra/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require 'luasnip-latex-snippets'.setup({ use_treesitter = true })
      require("luasnip").config.setup { enable_autosnippets = true, filetype = { "tex" } }
    end,
  }
}
