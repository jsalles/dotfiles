-- npm install -g vscode-css-languageserver-bin
require'lspconfig'.cssls.setup({
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
})
