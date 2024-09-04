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
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require 'luasnip-latex-snippets'.setup()
      -- or setup({ use_treesitter = true })
      local ls = require("luasnip")
      ls.config.setup { enable_autosnippets = true }
      -- local utils = require("luasnip-latex-snippets.util.utils")
      --
      -- local not_math = utils.not_math() -- pass true if using Treesitter
      -- local snip = ls.parser.parse_snippet({ trig = "tbb", name = "Bold" }, "\\textbf{$1}$0")
      -- snip.condition = not_math
      -- snip.priority = 10
      --
      -- ls.add_snippets("tex", { snip }, {
      --   type = "autosnippets",
      -- })
      --
      -- local snip2 = ls.parser.parse_snippet({ trig = "tii", name = "Italics" }, "\\textit{$1}$0")
      -- snip2.condition = not_math
      -- snip2.priority = 10
      --
      -- ls.add_snippets("tex", { snip2 }, {
      --   type = "autosnippets",
      -- })
    end,
  }
}
