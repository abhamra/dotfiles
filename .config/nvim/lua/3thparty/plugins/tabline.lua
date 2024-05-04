return {
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- configs...
      local theme = {
        current = { fg = "#504945", bg = "transparent", style = "bold" },
        not_current = { fg = "#504945", bg = "transparent" },

        fill = { bg = "transparent" },
      }
      require("tabby.tabline").set(function(line)
        return {
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current or theme.not_current
            return {
              line.sep(" ", hl, theme.fill),
              tab.name(),
              line.sep(" ", hl, theme.fill),
              hl = hl,
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            local hl = win.is_current() and theme.current or theme.not_current

            return {
              line.sep(" ", hl, theme.fill),
              win.buf_name(),
              line.sep(" ", hl, theme.fill),
              hl = hl,
            }
          end),
          hl = theme.fill,
        }
      end)
    end
  }
}
