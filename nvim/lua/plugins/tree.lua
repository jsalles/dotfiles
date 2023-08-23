return {
  -- {
  --   "kyazdani42/nvim-tree.lua",
  --   config = function()
  --     require("config.tree")
  --   end,
  -- },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Neotree",
    branch = "v3.x",
    keys = {
      {
        "<leader>ft",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["<tab>"] = { "toggle_preview", config = { use_float = false } },
          ["l"] = { "open" },
          ["h"] = { "close_node" }
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
      source_selector = {
        -- sources = {
        --   { source = "filesystem" },
        --   { source = "git_status" },
        --   { source = "document_symbols" }
        -- },
        winbar = true,
        -- statusline = true
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
