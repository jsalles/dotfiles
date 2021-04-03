call plug#begin('~/.config/nvim/plugged')
"Plug 'neovim/nvim-lspconfig'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'liuchengxu/vim-which-key'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'christianchiarulli/nvcode-color-schemes.vim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

Plug 'janko-m/vim-test'
call plug#end()

" NVIM COMPE
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" TELESCOPE
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NVIM TREE
nnoremap <C-n> :NvimTreeToggle<CR>

" EASYMOTION 
" Disable during easymotion navigation
autocmd User EasyMotionPromptBegin silent! vim.lsp.client.stop()
autocmd User EasyMotionPromptEnd silent! vim.lsp.start_client()

" VIM TEST
let g:test#javascript#runner = 'jest'
let test#strategy = 'neovim'
" Runs the test that is nearest to the cursor. Skips the rest
nmap <silent> t<C-n> :TestNearest<CR>
" Runs all tests in the current file
nmap <silent> t<C-f> :TestFile<CR>
" Runs all tests in the curret project    
nmap <silent> t<C-s> :TestSuite<CR>
" Runs the tests in the last visited test file. Useful for running the tests while looking at the code that is being tested.
nmap <silent> t<C-l> :TestLast<CR>
" Goes back to the last visited test file. Useful for investigation on the code and easy navigation back to the test file.
nmap <silent> t<C-g> :TestVisit<CR>
