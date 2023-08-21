-- "tpope/vim-surround")
-- {
--   "kylechui/nvim-surround",
--   -- tag = "*", -- Use for stability; omit to use `main` branch for the latest features
--   config = function()
--     require("nvim-surround").setup({
--       -- Configuration here, or leave empty to use defaults
--       keymaps = {
--         insert = "<C-g>s",
--         insert_line = "<C-g>S",
--         normal = "ys",
--         normal_cur = "yss",
--         normal_line = "yS",
--         normal_cur_line = "ySS",
--         visual = "gs",
--         visual_line = "gS",
--         delete = "ds",
--         change = "cs",
--       },
--     })
--   end,
-- },
return {
  "echasnovski/mini.surround",
  keys = { "gz" },
  opts = {
    mappings = {
      add = "gza",    -- Add surrounding in Normal and Visual modes
      delete = "gzd", -- Delete surrounding
      -- find = "gzf", -- Find surrounding (to the right)
      -- find_left = "gzF", -- Find surrounding (to the left)
      -- highlight = "gzh", -- Highlight surrounding
      replace = "gzc", -- Replace surrounding
      -- update_n_lines = "gzn", -- Update `n_lines`
    },
  },
  config = function(_, opts)
    -- use gz mappings instead of s to prevent conflict with leap
    require("mini.surround").setup(opts)
  end,
};
