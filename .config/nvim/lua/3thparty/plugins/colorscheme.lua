return {
   {
      "Shatur/neovim-ayu",
      enabled = true,
      event = "VimEnter",
      opts = {},
      config = function()
         vim.cmd("colorscheme ayu-dark", opts)
      end,
   }
}
