require('plugins')
vim.cmd(' source~/.config/nvim/lua/mappings.vim')
vim.cmd('source ~/.config/nvim/general.vim')
require('colorscheme')

-- Plugins
require('nv-autopairs')
require('nv-bufferline')
require('nv-compe')
require('nv-emmet')
require('nv-gitsigns')
require('nv-indent')
require('nv-quickscope')
require('nv-telescope')
require('nv-tree')
require('nv-treesitter')

-- Vim configs
-- vim.cmd('source ~/.config/nvim/vimscript/nv-barbar/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/nv-statusline/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/nv-whichkey/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

-- LSP
require('lsp/config')
require('lsp/cpp')
require('lsp/css')
require('lsp/efm')
require('lsp/hls')
require('lsp/tsserver')
require('lsp/graphql')
require('lsp/html')
