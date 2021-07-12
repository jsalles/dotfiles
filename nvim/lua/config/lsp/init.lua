local lspconfig = require("lspconfig")

if vim.lsp.setup then
    vim.lsp.setup({
        floating_preview = {
            border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
        },
        diagnostics = {
            signs = {
                error = " ",
                warning = " ",
                hint = " ",
                information = " "
            },
            display = {
                underline = true,
                update_in_insert = false,
                virtual_text = {spacing = 4, prefix = "●"},
                severity_sort = true
            }
        },
        completion = {
            kind = {
                Class = " ",
                Color = " ",
                Constant = " ",
                Constructor = " ",
                Enum = "了 ",
                EnumMember = " ",
                Field = " ",
                File = " ",
                Folder = " ",
                Function = " ",
                Interface = "ﰮ ",
                Keyword = " ",
                Method = "ƒ ",
                Module = " ",
                Property = " ",
                Snippet = "﬌ ",
                Struct = " ",
                Text = " ",
                Unit = " ",
                Value = " ",
                Variable = " "
            }
        }
    })
else
    -- require("lsp.saga")
    require("config.lsp.diagnostics")
    require("config.lsp.kind").setup()
end

local function on_attach(client, bufnr)
    require("config.lsp.formatting").setup(client, bufnr)
    require("config.lsp.keys").setup(client, bufnr)
    require("config.lsp.completion").setup(client, bufnr)
    require("config.lsp.highlighting").setup(client)

    -- TypeScript specific stuff
    if client.name == "typescript" or client.name == "tsserver" then
        require("config.lsp.ts-utils").setup(client)
    end
end

-- local lua_cmd = {
-- "/Users/joao.salles/Projects/personal/lua-language-server/bin/macOS/lua-language-server",
-- "-E",
-- "-e",
-- "LANG=en",
-- "/Users/joao.salles/Projects/personal/lua-language-server/main.lua"
-- }
-- lua_cmd = { "lua-language-server" }

-- local servers = {
-- tsserver = {},
-- cssls = {},
-- jsonls = {},
-- html = {},
-- clangd = {},
-- efm = require("lsp.efm").config,
-- lua = require("lua-dev").setup({
-- library = { plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" } },
-- }),
-- }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

require("null-ls").setup({on_attach = on_attach, capabilities = capabilities})
-- require("nvim-lsp-json").setup()
local installer = require("lspinstall")
installer.setup()

local servers = installer.installed_servers()
for _, server in pairs(servers) do
    local config = {}
    if server == "lua" then
        config = require("lua-dev").setup({
            library = {types = true, plugins = true}
        })
    elseif server == "efm" then
        config = require("config.lsp.efm").config
    end
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities
    }, config))
end
