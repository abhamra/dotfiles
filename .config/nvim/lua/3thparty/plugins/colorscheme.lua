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
      end
   },

}
