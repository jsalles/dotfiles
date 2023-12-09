require("config.mason").setup()
require("config.lsp.diagnostics").setup()
require("config.lsp.kind").setup()

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  -- require("config.lsp.highlighting").setup(client)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  if client.name == "clangd" then
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  end
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
  clangd = {
    keys = {
      { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
        fname
      ) or require("lspconfig.util").find_git_ancestor(fname)
    end,
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    cmd = {
      "/usr/bin/clangd", -- hack to force apple's clang to be used. later I need to detach this from mason-lspconfig
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
      "--query-driver=/usr/bin/clang++"
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },
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
    format = { enable = false },
    lintTask = { enable = true },
    autoFixOnSave = true,
    codeActionsOnSave = {
      mode = "all",
    },
    root_dir = require("lspconfig").util.root_pattern(".git", "yarn.lock", "package.json"),
    -- let vue be formatted by volar
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx",
      "svelte", "astro" }
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
    },
  },
  rust_analyzer = {
    -- checkOnSave = {
    --   command = "clippy"
    -- }
    keys = {
      { "K",          "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
      { "<leader>cR", "<cmd>RustCodeAction<cr>",   desc = "Code Action (Rust)" },
      { "<leader>dr", "<cmd>RustDebuggables<cr>",  desc = "Run Debuggables (Rust)" },
    },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        -- Add clippy lints for Rust.
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
  },
  taplo = {
    keys = {
      {
        "K",
        function()
          if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end,
        desc = "Show Crate Documentation",
      },
    },
  },
  -- graphql = {},
  smithy_ls = {},
  gopls = {},
  pyright = {},
  ruff_lsp = {},
  volar = {},
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
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})
  if server == "tsserver" then
    require("typescript").setup({ server = opts })
  elseif server == "rust" or server == "rust_analyzer" then
    local rust_tools_opts = require("util").opts("rust-tools.nvim")
    require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
  elseif server == "clangd" then
    local clangd_ext_opts = require("util").opts("clangd_extensions.nvim")
    require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
    require("lspconfig")[server].setup(opts)
  else
    require("lspconfig")[server].setup(opts)
  end

  require("config.lsp.null-ls").setup(opts)
end
