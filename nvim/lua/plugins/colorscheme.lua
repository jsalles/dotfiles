return {
  {
    -- event = "VeryLazy",
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("config.theme")
    end,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
      })
    end,
  },
  "christianchiarulli/nvcode-color-schemes.vim",
}
