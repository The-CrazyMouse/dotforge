return {
  {
    "neanias/everforest-nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("everforest").setup({
        -- your options
      })

      -- Force the colorscheme
      vim.cmd("colorscheme everforest")

      -- Make only main window transparent
      vim.api.nvim_set_hl(0, "Normal",  { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end,
  }
}

