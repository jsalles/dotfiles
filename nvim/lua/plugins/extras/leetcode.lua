local arg = "leetcode"

return {
  "kawre/leetcode.nvim",
  lazy = vim.fn.argv()[1] ~= arg,
  cmd = "Leet",
  keys = {
    { "<leader>lp", "<cmd>Leet list<CR>", desc = "List problems" },
    { "<leader>ll", "<cmd>Leet lang<CR>", desc = "Select language" },
    { "<leader>lt", "<cmd>Leet test<CR>", desc = "Test Solution" },
    { "<leader>ls", "<cmd>Leet submit<CR>", desc = "Submit Solution" },
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
    arg = arg,
  },
}
