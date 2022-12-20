return {
  { "nvim-lua/plenary.nvim", name = "plenary" },
  { "nvim-lua/popup.nvim", name = "popup" },

  -- LSP
  { "ray-x/lsp_signature.nvim" },
  { "b0o/SchemaStore.nvim", name = "schemastore" },
  { "jose-elias-alvarez/typescript.nvim", name = "typescript" },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/neodev.nvim",
    },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  },
  {
    "williamboman/mason.nvim",
    name = "mason",
    -- opt = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    name = "mason-lspconfig",
    -- opt = true,

  },
  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("config/cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require("config.snippets")
        end,
      },
      "rafamadriz/friendly-snippets",
      {
        "windwp/nvim-autopairs",
        config = function()
          require("config.autopairs")
        end,
      },
    },
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
    dependencies = {
      { "p00f/nvim-ts-rainbow" },
      { "windwp/nvim-ts-autotag" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/playground" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  },

  -- Smooth Scrolling
  -- {
  -- 	"karb94/neoscroll.nvim",
  -- 	keys = { "<C-u>", "<C-d>", "gg", "G" },
  -- 	config = function()
  -- 		require("config.scroll")
  -- 	end,
  -- })

  {
    "windwp/nvim-spectre",
    name = "spectre",
  },


  -- Explorer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("config.tree")
    end,
  },
  "nvim-telescope/telescope-fzy-native.nvim",
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup({})
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    config = function()
      require("config.neogit")
    end,
  },
  "ThePrimeagen/git-worktree.nvim",
  "ThePrimeagen/harpoon",
  "tpope/vim-fugitive",

  -- Look and feel
  {
    "RRethy/vim-illuminate",
    event = "BufReadPre",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  },
  {
    event = "VeryLazy",
    "folke/tokyonight.nvim",
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
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indent")
    end,
  },
  {
    "akinsho/nvim-bufferline.lua",
    -- tag = "v2.*",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("config.bufferline")
    end,
  },
  "folke/lsp-trouble.nvim",
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = function()
      require("config.todo")
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.statusline")
    end,
    dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    -- tag = "v2.*",
    keys = [[<c-\>]],
    config = function()
      require("config.terminal")
    end,
  },

  -- General Plugins
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("mappings")
    end,
  },
  "voldikss/vim-floaterm",
  -- "tpope/vim-surround")
  {
    "kylechui/nvim-surround",
    -- tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "gs",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
        },
      })
    end,
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          -- Only calculate commentstring for tsx filetypes
          if vim.bo.filetype == "typescriptreact" then
            local U = require("Comment.utils")

            -- Detemine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.block then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
              key = type,
              location = location,
            })
          end
        end,
      })
    end,
  },
  "kazhala/close-buffers.nvim",
  {
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("config.lightspeed")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    name = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },
}
