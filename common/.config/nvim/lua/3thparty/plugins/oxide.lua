-- lua/plugins/oxide.lua
return {
  {
    dir = vim.fn.stdpath("config"),
    name = "oxide",
    lazy = false,
    priority = 1000,

    config = function()
      vim.cmd("hi clear")
      vim.g.colors_name = "oxide"

      local c = {
        bg = "#231D1B",
        fg = "#E6DBD3",

        primary = "#B85A30",
        secondary = "#8B9A5A",
        tertiary = "#D8A657",
        error = "#C25D4E",

        surface = "#2E2623",
        surface2 = "#3E3532",

        comment = "#B8ACA2",

        black = "#1D1816",
        bright_black = "#463B38",

        selection = "#B8ACA2",
      }

      local hl = function(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
      end

      -- =====================
      -- CORE UI
      -- =====================
      hl("Normal", { fg = c.fg, bg = c.bg })
      hl("NormalFloat", { fg = c.fg, bg = c.surface })
      hl("FloatBorder", { fg = c.surface2, bg = c.surface })

      hl("CursorLine", { bg = c.surface })
      hl("CursorLineNr", { fg = c.primary })
      hl("LineNr", { fg = c.comment })

      hl("Visual", { bg = c.selection })

      hl("Pmenu", { fg = c.fg, bg = c.surface })
      hl("PmenuSel", { fg = c.black, bg = c.primary })

      hl("Search", { fg = c.black, bg = c.tertiary })
      hl("IncSearch", { fg = c.black, bg = c.primary })

      hl("VertSplit", { fg = c.surface2 })

      -- =====================
      -- SYNTAX
      -- =====================
      hl("Comment", { fg = c.comment, italic = true })
      hl("String", { fg = c.secondary })
      hl("Keyword", { fg = c.primary })
      hl("Function", { fg = c.tertiary })
      hl("Identifier", { fg = c.fg })
      hl("Type", { fg = c.secondary })
      hl("Constant", { fg = c.tertiary })
      hl("Statement", { fg = c.primary })

      hl("Error", { fg = c.error })

      -- =====================
      -- DIAGNOSTICS (LSP)
      -- =====================
      hl("DiagnosticError", { fg = c.error })
      hl("DiagnosticWarn", { fg = c.tertiary })
      hl("DiagnosticInfo", { fg = c.secondary })
      hl("DiagnosticHint", { fg = c.comment })

      hl("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
      hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.tertiary })

      -- =====================
      -- LSP SEMANTIC TOKENS
      -- =====================
      hl("@lsp.type.function", { fg = c.tertiary })
      hl("@lsp.type.method", { fg = c.tertiary })
      hl("@lsp.type.variable", { fg = c.fg })
      hl("@lsp.type.parameter", { fg = c.comment })
      hl("@lsp.type.keyword", { fg = c.primary })

      hl("@lsp.mod.readonly", { italic = true })
      hl("@lsp.mod.globalScope", { fg = c.secondary })

      -- =====================
      -- TREESITTER
      -- =====================
      hl("@function", { fg = c.tertiary })
      hl("@variable", { fg = c.fg })
      hl("@keyword", { fg = c.primary })
      hl("@string", { fg = c.secondary })
      hl("@comment", { fg = c.comment, italic = true })
      hl("@type", { fg = c.secondary })

      -- =====================
      -- GITSIGNS (optional but useful)
      -- =====================
      hl("GitSignsAdd", { fg = c.secondary })
      hl("GitSignsChange", { fg = c.tertiary })
      hl("GitSignsDelete", { fg = c.error })

      -- =====================
      -- MISC
      -- =====================
      hl("MatchParen", { fg = c.primary, bold = true })
      hl("Whitespace", { fg = c.surface2 })
    end,
  },
}
