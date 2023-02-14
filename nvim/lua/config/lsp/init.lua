require("config.mason").setup()
require("config.lsp.diagnostics").setup()
require("config.lsp.kind").setup()

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client)
end

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
  return string.match(value.targetUri, "%.d.ts") == nil
end

local servers = {
    yamlls = {},
    bashls = {},
    clangd = {},
    cssls = {},
    jsonls = {
        settings = {
            json = {
                format = {
                    enable = false,
                },
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
    html = {},
    lua_ls = {
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    workspaceWord = true,
                },
                misc = {
                    parameters = {
                        "--log-level=trace",
                    },
                },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "2",
                        continuation_indent_size = "2",
                    },
                },
            },
        },
    },
    eslint = {
        enable = true,
        format = { enable = true },
        lintTask = { enable = true },
        autoFixOnSave = true,
        codeActionsOnSave = {
            mode = "all",
        },
        root_dir = require("lspconfig").util.root_pattern(".git", "yarn.lock", "package.json"),
    },
    tsserver = {
        enable_import_on_completion = false,
        import_on_completion_timeout = 5000,
        eslint_bin = "eslint_d", -- use eslint_d if possible!
        eslint_enable_diagnostics = true,
        eslint_enable_disable_comments = true,
        auto_inlay_hints = false,
        handlers = {
            ['textDocument/definition'] = function(err, result, method, ...)
              if vim.tbl_islist(result) and #result > 1 then
                local filtered_result = filter(result, filterReactDTS)
                return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
              end

              vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
            end
        }
    },
    rust_analyzer = {},
    -- graphql = {},
    smithy_ls = {},
    gopls = {},
}


-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- require(".neoconf.json").setup()
-- require("neodev").setup()

local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}
-- require("config.lsp.install").setup(servers, options)

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})
  if server == "tsserver" then
    require("typescript").setup({ server = opts })
  else
    require("lspconfig")[server].setup(opts)
  end

  require("config.lsp.null-ls").setup(options)
end
