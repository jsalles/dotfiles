require("config.mason").setup()
require("config.lsp.diagnostics").setup()
require("config.lsp.kind").setup()

local function on_attach(client, bufnr)
	require("config.lsp.formatting").setup(client, bufnr)
	require("config.lsp.keys").setup(client, bufnr)
	require("config.lsp.highlighting").setup(client)

	-- TypeScript specific stuff
	if client.name == "typescript" or client.name == "tsserver" then
		-- require("config.lsp.typescript").setup(client)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

local servers = {
	bashls = {},
	clangd = {},
	cssls = {},
	jsonls = {},
	html = {},
	sumneko_lua = {},
	eslint = {},
	tsserver = {
		enable_import_on_completion = false,
		import_on_completion_timeout = 5000,
		eslint_bin = "eslint_d", -- use eslint_d if possible!
		eslint_enable_diagnostics = true,
		eslint_enable_disable_comments = true,
		auto_inlay_hints = false,
	},
	-- graphql = {},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require("workspace").setup()
require("lua-dev").setup()

local options = {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}
require("config.lsp.null-ls").setup(options)
-- require("config.lsp.install").setup(servers, options)
require("lsp_signature").setup()

for server, opts in pairs(servers) do
	opts = vim.tbl_deep_extend("force", {}, options, opts or {})
	if server == "tsserver" then
		require("typescript").setup({ server = opts })
	else
		require("lspconfig")[server].setup(opts)
	end
end
