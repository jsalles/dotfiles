local packer = require("util.packer")
local util = require("util")

local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugin load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
}

local function plugins(use)
  -- use({ "wbthomason/packer.nvim", opt = true })
  use({ "EdenEast/packer.nvim", branch = "feat/lockfile", opt = true })
  use({ "nvim-lua/plenary.nvim", module = "plenary" })
  use({ "nvim-lua/popup.nvim", module = "popup" })

  -- LSP
  use({ "ray-x/lsp_signature.nvim" })
  use({ "b0o/SchemaStore.nvim", module = "schemastore" })
  use({ "jose-elias-alvarez/typescript.nvim", module = "typescript" })
  use({
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    wants = {
      -- "workspace.nvim",
      -- "nvim-lsp-ts-utils",
      "null-ls.nvim",
      "neodev.nvim",
      "cmp-nvim-lsp",
    },
    config = function()
      require("config.lsp")
    end,
    requires = {
      -- "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/neodev.nvim",
    },
  })
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })
  use({
    "williamboman/mason.nvim",
    module = "mason",
    -- opt = true,
  })
  use({
    "williamboman/mason-lspconfig.nvim",
    module = "mason-lspconfig",
    -- opt = true,
  })

  -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("config/cmp")
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
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
  })
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
    requires = {
      { "p00f/nvim-ts-rainbow" },
      { "windwp/nvim-ts-autotag" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/playground" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  })

  -- Smooth Scrolling
  -- use({
  -- 	"karb94/neoscroll.nvim",
  -- 	keys = { "<C-u>", "<C-d>", "gg", "G" },
  -- 	config = function()
  -- 		require("config.scroll")
  -- 	end,
  -- })

  use({
    "windwp/nvim-spectre",
    module = "spectre",
  })


  -- Explorer
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("config.tree")
    end,
  })
  use({
    "nvim-telescope/telescope.nvim",
    -- opt = true,
    config = function()
      require("config.telescope")
    end,
    -- cmd = { "Telescope" },
    wants = { "plenary.nvim", "popup.nvim", "telescope-fzy-native.nvim", "telescope-file-browser.nvim" },
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
  })
  use({ "kevinhwang91/nvim-bqf", ft = "qf" })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup({})
    end,
  })
  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim" },
    wants = "plenary.nvim",
    cmd = "Neogit",
    config = function()
      require("config.neogit")
    end,
  })
  use("ThePrimeagen/git-worktree.nvim")
  use("ThePrimeagen/harpoon")
  use("tpope/vim-fugitive")

  -- Look and feel
  use({
    "RRethy/vim-illuminate",
    event = "BufReadPre",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  })
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("config.theme")
    end,
  })
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
      })
    end,
  })
  use("christianchiarulli/nvcode-color-schemes.vim")
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indent")
    end,
  })
  use({
    "akinsho/nvim-bufferline.lua",
    -- tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("config.bufferline")
    end,
  })
  use("folke/lsp-trouble.nvim")
  use({
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = function()
      require("config.todo")
    end,
  })
  use({
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.statusline")
    end,
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  })

  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    -- tag = "v2.*",
    keys = [[<c-\>]],
    config = function()
      require("config.terminal")
    end,
  })

  -- General Plugins
  use({
    "folke/which-key.nvim",
    -- event = "VimEnter",
    config = function()
      require("mappings")
    end,
  })
  use("voldikss/vim-floaterm")
  -- use("tpope/vim-surround")
  use({
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
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use({
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
  })
  use("kazhala/close-buffers.nvim")
  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("config.lightspeed")
    end,
  })
  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })
end

return packer.setup(config, plugins)
