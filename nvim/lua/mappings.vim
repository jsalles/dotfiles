let mapleader=' '
let maplocalleader=','

nnoremap U <C-R>

map B ^
map E $

nnoremap <S-Tab> :bn<CR>
nnoremap <Tab> :bp<CR>

nnoremap <leader>vs :split<Return>
nnoremap <leader>vv :vsplit<Return>

map<leader>p "+p
map<leader>y "+y

nnoremap <silent> <leader>e :NvimTreeToggle<CR>

nmap <C-b> :Buffers<CR>
nmap <C-f> :Rg<CR>
nmap <C-p> :GFiles<CR>
nmap <C-c> :History<CR>

nnoremap K :lua vim.lsp.buf.hover()<CR>