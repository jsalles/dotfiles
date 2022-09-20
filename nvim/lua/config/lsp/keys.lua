local wk = require("which-key")
local util = require("util")

local M = {}

function M.setup(client, bufnr)
	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local keymap = {
		c = {
			name = "+code",
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = {
				"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
				"Line Diagnostics",
			},
			l = {
				name = "+lsp",
				i = { "<cmd>LspInfo<cr>", "Lsp Info" },
				a = {
					"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
					"Add Folder",
				},
				r = {
					"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
					"Remove Folder",
				},
				l = {
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					"List Folders",
				},
			},
		},
		x = {
			s = {
				"<cmd>Telescope lsp_document_diagnostics<cr>",
				"Search Document Diagnostics",
			},
			w = {
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				"Workspace Diagnostics",
			},
		},
	}

	if client.name == "typescript" then
		keymap.c.o = { "<cmd>:TSLspOrganize<CR>", "Organize Imports" }
		keymap.c.R = { "<cmd>:TSLspRenameFile<CR>", "Rename File" }
	end

	local keymap_visual = {
		c = {
			name = "+code",
			a = { ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
		},
	}

	local function filter(arr, fn)
		if type(arr) ~= "table" then
			return arr
		end

		local filtered = {}
		for k, v in pairs(arr) do
			if fn(v, k, arr) then
				table.insert(filtered, v)
			end
		end

		return filtered
	end

	local function filterReactDTS(value)
		return string.match(value.filename, "react/index.d.ts") == nil
	end

	local function on_list(options)
		-- https://github.com/typescript-language-server/typescript-language-server/issues/216
		local items = options.items
		if #items > 1 then
			items = filter(items, filterReactDTS)
		end

		vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
		vim.api.nvim_command("cfirst")
	end

	local keymap_goto = {
		name = "+goto",
		r = { "<cmd>Telescope lsp_references<cr>", "References" },
		R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
		d = { "<Cmd>lua vim.lsp.buf.definition({on_list=on_list})<CR>", "Goto Definition" },
		dv = {
			"<Cmd>vsplit | lua vim.lsp.buf.definition({on_list=on_list})<CR>",
			"Goto Definition",
		},
		ds = {
			"<Cmd>split | lua vim.lsp.buf.definition({on_list=on_list})<CR>",
			"Goto Definition",
		},
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
		-- I = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
		t = {
			"<cmd>lua vim.lsp.buf.type_definition({on_list=on_list})<CR>",
			"Goto Type Definition",
		},
	}

	util.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	util.nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	util.nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		keymap.c.f = {
			"<cmd>lua vim.lsp.buf.formatting()<CR>",
			"Format Document",
		}
	elseif client.resolved_capabilities.document_range_formatting then
		keymap_visual.c.f = {
			"<cmd>lua vim.lsp.buf.range_formatting()<CR>",
			"Format Range",
		}
	end

	wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
	wk.register(keymap_visual, { buffer = bufnr, prefix = "<leader>", mode = "v" })
	wk.register(keymap_goto, { buffer = bufnr, prefix = "g" })
end

return M
