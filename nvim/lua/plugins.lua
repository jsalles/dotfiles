return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  {
    'alexghergh/nvim-tmux-navigation',
    event = "VeryLazy",
    config = function()
      require('nvim-tmux-navigation').setup({
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          next = "<C-Space>",
        }
      })
    end
  },
  -- LSP
  "ray-x/lsp_signature.nvim",
  "b0o/SchemaStore.nvim",
  "jose-elias-alvarez/typescript.nvim",
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "jose-elias-alvarez/null-ls.nvim",
    },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  -- Autocomplete
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  { 'rgroli/other.nvim',
    config = function()
      require("other-nvim").setup({
        rememberBuffers = false,
        mappings = {
          {
            pattern = "src/(.*)/(%a*).test.tsx",
            target = {
              {
                target = "src/%1/%2.tsx",
                context = "implementation"
              },
              {
                target = "src/%1/%2.module.css",
                context = "styles"
              }
            }
          },
          {
            pattern = "src/(.*)/(%a*).tsx",
            target = {
              {
                target = "src/%1/%2.test.tsx",
                context = "tests"
              },
              {
                target = "src/%1/%2.module.css",
                context = "styles"
              }
            }
          },
          {
            pattern = "src/(.*)/(%a*).module.css",
            target = {
              {
                target = "src/%1/%2.tsx",
                context = "implementation"
              },
              {
                target = "src/%1/%2.test.tsx",
                context = "tests"
              }
            }
          },
          {
            pattern = "(.*).cpp",
            target = {
              {
                target = "%1_test.cpp",
                context = "tests",
              },
              {
                target = "%1.h",
                context = "definitions",
              }
            }
          },
          {
            pattern = "(.*)_test.cpp",
            target = {
              {
                target = "%1.cpp",
                context = "implementation",
              },
              {
                target = "%1.h",
                context = "definitions",
              }
            }
          },
          {
            pattern = "(.*).h",
            target = {
              {
                target = "%1_test.cpp",
                context = "tests",
              },
              {
                target = "%1.cpp",
                context = "implementation",
              }
            }
          }
        }
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    config = function()
      require("config/cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      -- {
      --   "L3MON4D3/LuaSnip",
      --   dependencies = "rafamadriz/friendly-snippets",
      --   config = function()
      --     require("config.snippets")
      --   end,
      -- },
      -- "rafamadriz/friendly-snippets",
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
    event = "BufReadPost",
    config = function()
      require("config.treesitter")
    end,
    dependencies = {
      "p00f/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
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

  "windwp/nvim-spectre",
  -- "Exafunction/codeium.vim",
  -- Explorer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("config.tree")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-fzy-native.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
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
    -- event = "VeryLazy",
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
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
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all notifications",
      },
      opts = {
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end
      }
    }
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
  {
    "echasnovski/mini.surround",
    keys = { "gz" },
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
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
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
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
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { { "ggandor/flit.nvim", config = { labeled_modes = "nv" } } },
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },
}
