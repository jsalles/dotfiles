return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config.lsp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  "ray-x/lsp_signature.nvim",
  "b0o/SchemaStore.nvim",
  "jose-elias-alvarez/typescript.nvim",
  -- {
  --   "jsalles/tsc.nvim",
  --   config = function()
  --     require('tsc').setup()
  --   end
  -- },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {
  --     settings = {
  --       tsserver_format_options = {},
  --       tsserver_plugins = { "@typescript-eslint/parser" }
  --     }
  --   },
  -- },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = {
      tools = {
        on_initialized = function()
          vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
        end,
      },
    }
  },
  {
    "j-hui/fidget.nvim",
    -- tag = "legacy",
    config = function()
      require("fidget").setup({})
    end,
  },
  "lervag/vimtex",
}
