return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  -- General Plugins
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {},
    },
    config = function()
      require("mappings")
    end,
  },
  "voldikss/vim-floaterm",
  "kazhala/close-buffers.nvim",
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },
}
