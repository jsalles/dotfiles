local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		wants = {
			"nvim-lsp-ts-utils",
			"null-ls.nvim",
			"nvim-lsp-installer",
		},
		config = function()
			require("config.lsp")
		end,
		requires = {
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/nvim-lsp-installer",
			"hrsh7th/nvim-cmp",
			-- {'glepnir/lspsaga.nvim', event = "BufReadPre"}
		},
	})

	use({
		"thibthib18/ros-nvim",
		config = function()
			require("ros-nvim").setup({
				catkin_ws_path = "~/catkin_ws",
			})
		end,
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
					{ name = "buffer" },
					{ name = "vsnip" },
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
	--[[ use({
		"hrsh7th/nvim-compe",
		event = "Insertenter",
		opt = true,
		config = function()
			require("config.compe")
		end,
		requires = {
			{
				"windwp/nvim-autopairs",
				config = function()
					require("config.autopairs")
				end,
			},
		},
	}) ]]
	--[[ use({
		"mattn/emmet-vim",
		opt = true,
		config = function()
			require("config.emmet")
		end,
	})
	use("hrsh7th/vim-vsnip")
	use("xabikos/vscode-javascript")
	use("dsznajder/vscode-es7-javascript-react-snippets")
 ]]

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	})
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("nvim-treesitter/playground")

	-- Typescript
	use("p00f/nvim-ts-rainbow")
	use("windwp/nvim-ts-autotag")

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
	use("sindrets/diffview.nvim")
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
	use("folke/tokyonight.nvim")
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
		"hoob3rt/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("config.statusline")
		end,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Terminal
	use({
		"akinsho/nvim-toggleterm.lua",
		keys = "<M-`>",
		config = function()
			require("config.terminal")
		end,
	})

	-- General Plugins
	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("mappings")
		end,
	})
	use("voldikss/vim-floaterm")
	--[[ use({
		"rcarriga/vim-ultest",
		requires = { "vim-test/vim-test" },
		run = ":UpdateRemotePlugins",
		config = function()
			require("config.test")
		end,
	}) ]]
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
end)
