local M = {}

function M.setup(options)
  local nls = require("null-ls")
  nls.setup({
    debounce = 150,
    save_after_format = false,
    sources = {
      -- nls.builtins.formatting.prettierd,
      -- nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.eslint_d,
      nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
      -- nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.markdownlint,
      -- nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.prettierd.with({
        filetypes = { "markdown", "vue", "typescript", "typescriptreact" },
      }),
      nls.builtins.formatting.ruff,
      nls.builtins.formatting.black
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
