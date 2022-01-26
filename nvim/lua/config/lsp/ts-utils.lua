return {
	setup = function(client)
		local ts = require("nvim-lsp-ts-utils")
		-- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
		ts.setup({
			disable_commands = false,
			enable_import_on_completion = false,
			import_on_completion_timeout = 5000,
			eslint_bin = "eslint_d", -- use eslint_d if possible!
			eslint_enable_diagnostics = true,
			-- eslint_fix_current = false,
			eslint_enable_disable_comments = true,
			auto_inlay_hints = false,
		})

		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		ts.setup_client(client)
	end,
}
