"----------------------------------------------------------------------
"                   General Re-mappings
"----------------------------------------------------------------------
" Source init.vim and install plugins
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" Change panel width
map + :vertical resize +5<CR>
map - :vertical resize -5<CR>

" Expand regions
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" Set U as Ctrl R which means Redo
nnoremap U <C-R>

" Use B to move to beginning of line
map B ^

" Use E to move to end of line in
map E $

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" List all recently opened files and open a new buffer
nnoremap gs :browse oldfiles<CR>

" Set terminal stuff
if exists(':terminal')
    tnoremap hh <C-\><C-n>
endif

" Shift Tab to cyle tabs
nnoremap <S-Tab> :bn<CR>
nnoremap <Tab> :bp<CR>

"----------------------------------------------------------------------
"               Map Leader to '<space>' 
"               Map Llocalleader to \\
"----------------------------------------------------------------------

let mapleader=' '

" Turn off search highlight bullshit to Comma + Leader/space
nnoremap ,<leader> :nohlsearch<CR>

" Run Last command in tmux window
nnoremap ,gcc :!tmux send-keys -t1 "\!! " ENTER <CR><CR>

" Mac open dictionary under word cursor
nnoremap <silent> <leader>? :!open dict://<cword><cr><cr>

" Open URL or thing in default browser or whatever
nnoremap <silent> <leader>@ :!open <cfile><cr><cr>

" Delete Buffer, but keep the window open
nnoremap <leader>d :bp\|bd! #<CR>

" Jumplist stuff -> Backward and forward in vim jumps 
" -> C-i && C-o aint that hard
"nnoremap <leader>i <C-i>
"nnoremap <leader>o <C-o>

" Fixing vim because I break it Later -> Move between blocks 'better'
nnoremap <leader>j J

" Preview Marks!
"nnoremap  <leader>m :marks<CR>

" Copy & Paste into vim in normal mode
map<leader>p  "+p
map<leader>y  "+y

" Split window
nnoremap <leader>vs :split<Return>
nnoremap <leader>vv :vsplit<Return>

" Increment Decrement Numbers
"nnoremap + <C-a>
"nnoremap - <C-x>

" Change directory to current directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Show syntax color highlighting groups for word under cursor
nnoremap <c-a> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" leader+r to search and replace in file
nnoremap <leader>r :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

"----------------------------------------------------------------------
"               Terminal -> z
"----------------------------------------------------------------------
" Terminal Mappings
function! TerminalCreate()
    let time_now = strftime("%T")
    let terminal_name = "terminal_" . time_now
    execute "terminal"
    execute "set nonumber"
    execute "file " . terminal_name
    normal A
endfunction

" Leader+z = create new terminal buffer BELOW
nnoremap <leader>zb :new<CR>:resize 10<CR>:call TerminalCreate()<CR>

" Leader+zb = new terminal in a new window completely by itself
nnoremap <leader>zz :call TerminalCreate()<CR>

" Leader+zv = new terminal in a new vertical split
nnoremap <leader>zv :vsplit<CR>:call TerminalCreate()<CR>

" visual multi
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
