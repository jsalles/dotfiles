local packer = require("util.packer")

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
	use({ "wbthomason/packer.nvim", opt = true })
	use({ "nvim-lua/plenary.nvim", module = "plenary" })
	use({ "nvim-lua/popup.nvim", module = "popup" })

	-- LSP
	use({ "ray-x/lsp_signature.nvim" })
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		wants = {
			-- "workspace.nvim",
			"nvim-lsp-ts-utils",
			"null-ls.nvim",
			"lua-dev.nvim",
			"cmp-nvim-lsp",
			"nvim-lsp-installer",
		},
		config = function()
			require("config.lsp")
		end,
		requires = {
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"jose-elias-alvarez/null-ls.nvim",
			"folke/lua-dev.nvim",
			"williamboman/nvim-lsp-installer",
		},
	})

	-- Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = {
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				},
				formatting = {
					format = require("config.lsp.kind").cmp_format(),
				},
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
			})
		end,
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-path",
			"hrsh7th/vim-vsnip",
			{
				"windwp/nvim-autopairs",
				config = function()
					require("config.autopairs")
				end,
			},
		},
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

	-- Explorer
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config.tree")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		opt = true,
		config = function()
			require("config.telescope")
		end,
		cmd = { "Telescope" },
		wants = { "plenary.nvim", "popup.nvim", "telescope-fzy-native.nvim" },
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
	})

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
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
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
	use({
		"rcarriga/vim-ultest",
		requires = { "vim-test/vim-test" },
		wants = "which-key",
		run = ":UpdateRemotePlugins",
		config = function()
			require("config.test")
		end,
	})
	use({
		"ahmedkhalf/lsp-rooter.nvim",
		config = function()
			require("lsp-rooter").setup({})
		end,
	})
	use("tpope/vim-surround")
	use("b3nj5m1n/kommentary")
	use("kazhala/close-buffers.nvim")
	use({
		"ggandor/lightspeed.nvim",
		event = "BufReadPost",
		config = function()
			require("config.lightspeed")
		end,
	})
end

return packer.setup(config, plugins)
