return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      -- files
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                    desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                      desc = "Open Recent File" },
      -- search
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",                     desc = "Grep" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Goto Symbol" },
      { "<leader>sh", "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark" },

      -- navigation
      { "<leader>.",  "<cmd>Telescope file_browser<CR>",                  desc = "Browse Files" },
      { "<leader>,",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer", },
      { "<leader>/",  "<cmd>Telescope live_grep<cr>",                     desc = "Search" },
      { "<leader>:",  "<cmd>Telescope command_history<cr>",               desc = "Command History" },

    },
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
}
