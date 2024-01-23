return {
  {
    "nvim-telescope/telescope.nvim",
    -- config = function()
    --   require("config.telescope")
    -- end,
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-fzy-native.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local actions = require('telescope.actions')
      require("telescope").setup({
        defaults = {
          prompt_prefix = " 🔍 ",
          layout_config = { prompt_position = "top" },

          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["Q"] = actions.smart_add_to_qflist + actions.open_qflist,
              ["q"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
              ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
              ["v"] = actions.file_vsplit,
              ["s"] = actions.file_split,
              ["<cr>"] = actions.file_edit,
            },
          },
        },
      })
      require("telescope").load_extension("file_browser")
    end,
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  -- {
  --   "jsalles/monorepo.nvim",
  --   config = function()
  --     require("monorepo").setup({
  --       -- Your config here!
  --     })
  --   end,
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  -- },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("telescope").load_extension("harpoon")
    end
  },
}
