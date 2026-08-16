-- lua/plugins/rose-pine.lua
return {
  -- {
  --    "rose-pine/neovim",
  --    name = "rose-pine",
  --    config = function()
  --       vim.cmd("colorscheme rose-pine")
  --    end
  -- },
  {
    "akinsho/horizon.nvim",
    version = "*",
    config = function()
      vim.cmd("colorscheme horizon")

      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, '@markup.link.label', { fg = '#fab795', underline = true }) -- warm orange, link text
          vim.api.nvim_set_hl(0, '@markup.link.url', { fg = '#e8a37c', italic = true })      -- softer peach, italic+underline for the url
        end,
      })

      -- Also apply immediately, since the autocmd only fires on *future* colorscheme changes
      vim.api.nvim_set_hl(0, '@markup.link.label', { fg = '#fab795', underline = true }) -- warm orange, link text
      vim.api.nvim_set_hl(0, '@markup.link.url', { fg = '#e8a37c', italic = true })      -- softer peach, italic+underline for the url
    end
  },

}
