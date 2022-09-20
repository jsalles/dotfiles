return {
	setup = function()
		local ts = require("typescript")
		ts.setup({
			disable_commands = false,
			server = {
				enable_import_on_completion = false,
				import_on_completion_timeout = 5000,
				eslint_bin = "eslint_d", -- use eslint_d if possible!
				eslint_enable_diagnostics = true,
				eslint_enable_disable_comments = true,
				auto_inlay_hints = false,
				on_attach = function(client)
					client.resolved_capabilities.document_formatting = false
					client.resolved_capabilities.document_range_formatting = false
				end,
			},
		})
	end,
}
