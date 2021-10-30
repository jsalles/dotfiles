require("bufferline").setup({
	options = {
		show_close_icon = true,
		diagnostics = "nvim_lsp",
		numbers = "ordinal",
		-- mappings = true,
		offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
		show_buffer_icons = true, -- disable filetype icons for bufers
		show_buffer_close_icons = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
	},
})
