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

  local keymap_goto = {
    name = "+goto",
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    dv = {
      "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
      "Goto Definition",
    },
    ds = {
      "<Cmd>split | lua vim.lsp.buf.definition()<CR>",
      "Goto Definition",
    },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    -- I = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
    t = {
      "<cmd>lua vim.lsp.buf.type_definition()<CR>",
      "Goto Type Definition",
    },
  }

  util.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  util.nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  util.nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    keymap.c.f = {
      -- "<cmd>lua vim.lsp.buf.formatting()<CR>",
      -- "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
      "<cmd>lua require('config.lsp.formatting').format()<CR>",
      "Format Document",
    }
  elseif client.server_capabilities.documentRangeFormattingProvider then
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
