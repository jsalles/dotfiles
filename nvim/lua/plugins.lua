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
		wants = { "nvim-lsp-ts-utils", "null-ls.nvim", "lua-dev.nvim", "nvim-lspinstall" },
		config = function()
			require("lsp")
		end,
		requires = {
			"kabouzeid/nvim-lspinstall",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"jose-elias-alvarez/null-ls.nvim",
			"folke/lua-dev.nvim",
			-- {'glepnir/lspsaga.nvim', event = "BufReadPre"}
		},
	})

	-- Autocomplete
	use({
		"hrsh7th/nvim-compe",
		event = "Insertenter",
		opt = true,
		config = function()
			require("nv-compe")
		end,
		requires = {
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nv-autopairs")
				end,
			},
		},
	})
	use({
		"mattn/emmet-vim",
		opt = true,
		config = function()
			require("nv-emmet")
		end,
	})
	use("hrsh7th/vim-vsnip")
	use("xabikos/vscode-javascript")
	use("dsznajder/vscode-es7-javascript-react-snippets")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nv-treesitter")
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
			require("nv-tree")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		opt = true,
		config = function()
			require("nv-telescope")
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
			require("nv-gitsigns")
		end,
	})
	use("sindrets/diffview.nvim")

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
	use("norcalli/nvim-colorizer.lua")
	use({
		"lukas-reineke/indent-blankline.nvim",
		branch = "lua",
		config = function()
			require("nv-indent")
		end,
	})
	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nv-bufferline")
		end,
	})
	use("folke/lsp-trouble.nvim")
	use({
		"hoob3rt/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("nv-statusline")
		end,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
	use("vim-test/vim-test")
	use({
		"ahmedkhalf/lsp-rooter.nvim",
		config = function()
			require("lsp-rooter").setup({})
		end,
	})
	use("tpope/vim-surround")
end)
