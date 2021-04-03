require('plugins')
vim.cmd(' source~/.config/nvim/lua/mappings.vim')
vim.cmd('source ~/.config/nvim/general.vim')
require('colorscheme')

-- Plugins
require('nv-compe')
require('nv-emmet')
require('nv-quickscope')
require('nv-telescope')
require('nv-tree')
require('nv-treesitter')

-- Whickey
vim.cmd('source ~/.config/nvim/vimscript/nv-whichkey/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

-- LSP
require('lsp/config')
require('lsp/efm')
require('lsp/tsserver')
require('lsp/graphql')
require('lsp/html')
