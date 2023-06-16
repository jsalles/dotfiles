return {
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
  "windwp/nvim-spectre",
  {
    "RRethy/vim-illuminate",
    event = "BufReadPre",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
      },
      char = "│",
      use_treesitter = true,
      show_trailing_blankline_indent = false,
      show_current_context = true,
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
    },
  },
  -- {
  --   "akinsho/nvim-bufferline.lua",
  --   -- tag = "v2.*",
  --   dependencies = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("config.bufferline")
  --   end,
  -- },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        show_close_icon = true,
        -- diagnostics = "nvim_diagnostic",
        diagnostics = "nvim_lsp",
        -- always_show_bufferline = false,
        numbers = "ordinal",
        -- mappings = true,
        offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "center" } },
        show_buffer_icons = true, -- disable filetype icons for bufers
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
      },
    },
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
    "rcarriga/nvim-notify",
    lazy = false,
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
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
    end,
    opts = function()
      local icons = require("config.icons")
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = icons.kinds,
      }
    end,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    -- tag = "v2.*",
    keys = [[<c-\>]],
    opts = {
      size = 20,
      hide_numbers = true,
      open_mapping = [[<c-\>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      persist_size = true,
      direction = "float",
    },
    init = function()
      vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])
    end
  },
}
