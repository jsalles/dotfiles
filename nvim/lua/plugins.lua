local config = {
    profile = {
        enable = true,
        threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    }
}

return require("packer").startup({
    function(use)
        -- Packer can manage itself as an optional plugin
        use({"wbthomason/packer.nvim", opt = true})

        -- LSP
        -- use({
        --     "neovim/nvim-lspconfig",
        --     opt = true,
        --     event = "BufReadPre",
        --     -- wants = {"null-ls.nvim"},
        --     config = function() require("config.lsp") end,
        --     requires = {
        --         -- "jose-elias-alvarez/nvim-lsp-ts-utils"
        --         -- "jose-elias-alvarez/null-ls.nvim"
        --     }
        -- })

        use({
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            opt = true,
            config = function() require("config.compe") end,
            requires = {
                {
                    "windwp/nvim-autopairs",
                    config = function()
                        require("config.autopairs")
                    end
                }
            }
        })

        use({"simrat39/symbols-outline.nvim", cmd = {"SymbolsOutline"}})

        use({
            "b3nj5m1n/kommentary",
            opt = true,
            wants = "nvim-ts-context-commentstring",
            keys = {"gc", "gcc"},
            config = function() require("config.comments") end,
            requires = "JoosepAlviste/nvim-ts-context-commentstring"
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
                "nvim-treesitter/playground",
                "nvim-treesitter/nvim-treesitter-textobjects"
            },
            config = [[require('config.treesitter')]]
        })

        -- Theme: color schemes
        use({
            "shaunsingh/nord.nvim", "shaunsingh/moonlight.nvim",
            "joshdick/onedark.vim", {"marko-cerovac/material.nvim"},
            "sainnhe/sonokai", "morhetz/gruvbox", "folke/tokyonight.nvim",
            "Mofiqul/dracula.nvim"
        })

        -- Theme: icons
        use({
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup({default = true})
            end
        })

        -- Dashboard
        use({"glepnir/dashboard-nvim", config = [[require('config.dashboard')]]})

        use({
            "norcalli/nvim-terminal.lua",
            config = function() require("terminal").setup() end
        })
        use({"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"})

        use({
            "windwp/nvim-spectre",
            opt = true,
            module = "spectre",
            wants = {"plenary.nvim", "popup.nvim"},
            requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
        })

        use({
            "kyazdani42/nvim-tree.lua",
            cmd = {"NvimTreeToggle", "NvimTreeClose"},
            config = function() require("config.tree") end
        })

        -- Fuzzy finder
        use({
            "nvim-telescope/telescope.nvim",
            opt = true,
            config = function() require("config.telescope") end,
            cmd = {"Telescope"},
            keys = {"<leader><space>", "<leader>fz", "<leader>pp"},
            wants = {
                "plenary.nvim", "popup.nvim", "telescope-z.nvim",
                "telescope-fzy-native.nvim", "telescope-project.nvim",
                "trouble.nvim", "telescope-symbols.nvim"
            },
            requires = {
                "nvim-telescope/telescope-z.nvim",
                "nvim-telescope/telescope-project.nvim", "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-symbols.nvim",
                "nvim-telescope/telescope-fzy-native.nvim"
            }
        })

        -- Indent Guides and rainbow brackets
        use({
            "lukas-reineke/indent-blankline.nvim",
            event = "BufReadPre",
            branch = "lua",
            config = function() require("config.blankline") end
        })

        -- Tabs
        use({
            "akinsho/nvim-bufferline.lua",
            event = "BufReadPre",
            requires = "kyazdani42/nvim-web-devicons",
            config = function() require("config.bufferline") end
        })

        -- -- Terminal
        -- use({
        --     "akinsho/nvim-toggleterm.lua",
        --     keys = "<M-`>",
        --     module = "folke.util",
        --     config = function() require("config.terminal") end
        -- })
        use 'voldikss/vim-floaterm'

        -- Smooth Scrolling
        use({
            "karb94/neoscroll.nvim",
            config = function() require("config.scroll") end
        })
        use({
            "edluffy/specs.nvim",
            config = function() require("config.specs") end
        })

        -- Git Gutter
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            wants = "plenary.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function() require("config.gitsigns") end
        })
        -- use {
        --   "kdheepak/lazygit.nvim",
        --   cmd = "LazyGit",
        --   config = function() vim.g.lazygit_floating_window_use_plenary = 0 end
        -- }
        use({
            "TimUntersberger/neogit",
            cmd = "Neogit",
            config = function() require("config.neogit") end
        })

        -- Statusline
        use({
            "hoob3rt/lualine.nvim",
            event = "VimEnter",
            config = [[require('config.lualine')]],
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        })

        use({
            "norcalli/nvim-colorizer.lua",
            event = "BufReadPre",
            config = function() require("config.colorizer") end
        })

        use({
            "phaazon/hop.nvim",
            keys = {"gh", "s"},
            cmd = {"HopWord", "HopChar1"},
            config = function()
                require("util").nmap("gh", "<cmd>HopWord<CR>")
                -- require("util").nmap("s", "<cmd>HopChar1<CR>")
                -- you can configure Hop the way you like here; see :h hop-config
                require("hop").setup({})
            end
        })

        use({
            "folke/trouble.nvim",
            event = "BufReadPre",
            requires = "kyazdani42/nvim-web-devicons",
            cmd = {"TroubleToggle", "Trouble"},
            config = function()
                require("trouble").setup({auto_open = false})
            end
        })

        -- use { "mg979/vim-visual-multi", keys = "<C-n>" }

        use({"folke/lsp-colors.nvim"})
        use({
            "folke/zen-mode.nvim",
            cmd = "ZenMode",
            config = function()
                require("zen-mode").setup({
                    plugins = {
                        gitsigns = true,
                        tmux = true,
                        kitty = {enabled = false, font = "+2"}
                    }
                })
            end
        })
        use({
            "folke/which-key.nvim",
            event = "VimEnter",
            config = function() require("config.keys") end
        })
        use({
            "sindrets/diffview.nvim",
            cmd = {
                "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
                "DiffviewFocusFiles"
            },
            config = function() require("config.diffview") end
        })

        use({
            "RRethy/vim-illuminate",
            event = "BufReadPre",
            config = function() vim.g.Illuminate_delay = 1000 end
        })

        use("wellle/targets.vim")

        use("tpope/vim-unimpaired")
    end,
    config = config
})
