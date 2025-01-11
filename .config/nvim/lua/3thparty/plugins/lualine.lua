return {
  'nvim-lualine/lualine.nvim',
  event = 'ColorScheme',
  config = function()
    require('lualine').setup({
      options = {
        --- @usage 'rose-pine' | 'rose-pine-alt'
        theme = 'rose-pine',
        highlight_groups = {
          StatusLine = { fg = "love", bg = "love", blend = 10 },
          StatusLineNC = { fg = "subtle", bg = "surface" },
        },
      }
    })
  end
}
