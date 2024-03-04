return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html", "css" })
      end
    end,
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      -- make sure mason installs the server
      servers = {
        html = {},
        cssls = {},
      },
    },
  },

  -- formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "prettierd")
      end,
    },
  },

  -- FIXME: linting
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       css = { "stylelint" },
  --     },
  --   },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     opts = function(_, opts)
  --       opts.ensure_installed = opts.ensure_installed or {}
  --       table.insert(opts.ensure_installed, "stylelint")
  --     end,
  --   },
  -- },
}
