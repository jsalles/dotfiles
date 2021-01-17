call plug#begin('~/.config/nvim/plugged')
    " COLORS, PRETTY & FUN
    Plug 'sheerun/vim-polyglot'
    Plug 'itchyny/lightline.vim'
    Plug 'pineapplegiant/spaceduck'
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim'
    Plug 'herringtondarkholme/yats.vim'
    Plug 'jelera/vim-javascript-syntax'
    "" MOVING AROUND
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'lambdalisue/nerdfont.vim'
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-hijack.vim'
    Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'LumaKernel/fern-mapping-fzf.vim/'
    Plug 'easymotion/vim-easymotion'
    "" ESSENTIAL
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdcommenter'
    "" Git 
    Plug 'itchyny/vim-gitbranch'
    "" NEXT LEVEL SHIT
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    Plug 'liuchengxu/vista.vim'
    Plug 'janko-m/vim-test'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'terryma/vim-expand-region'
    Plug 'christoomey/vim-tmux-navigator'
    " Javascript
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'mattn/emmet-vim'
    " Plug 'peitalin/vim-jsx-typescript'
    " Elixir
    Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
    Plug 'elixir-editors/vim-elixir'
call plug#end()

"----------------------------------------------------------------------
"                       FERN
"----------------------------------------------------------------------

" Custom settings and mappings.
  let g:fern#disable_default_mappings = 1

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-action-open-or-enter)
  nmap <buffer> <BS> <Plug>(fern-action-leave)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-file)
  nmap <buffer> N <Plug>(fern-action-new-dir)
  nmap <buffer> x <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> V <Plug>(fern-action-mark:toggle)
  nmap <buffer> o <Plug>(fern-action-open:system)
  nmap <buffer> l <Plug>(fern-action-expand)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> fd <Plug>(fern-action-fzf-dirs)
  nmap <buffer> ff <Plug>(fern-action-fzf-both)
  nmap <buffer> fg <Plug>(fern-action-grep)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

    let g:fern#renderer = "nerdfont"

    nmap <C-m> :Fern .<CR>
    nmap <C-n> :Fern . -drawer -toggle -reveal=%<CR>

"----------------------------------------------------------------------
"                       FZF
"----------------------------------------------------------------------

    let $FZF_DEFAULT_OPTS = '--layout=reverse'

    let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

    function! OpenFloatingWin()
      let height = &lines - 3
      let width = float2nr(&columns - (&columns * 2 / 10))
      let col = float2nr((&columns - width) / 2)

      let opts = {
            \ 'relative': 'editor',
            \ 'row': height * 0.3,
            \ 'col': col + 30,
            \ 'width': width * 2 / 3,
            \ 'height': height / 2
            \ }

      let buf = nvim_create_buf(v:false, v:true)
      let win = nvim_open_win(buf, v:true, opts)

      call setwinvar(win, '&winhl', 'Normal:Pmenu')

      setlocal
            \ buftype=nofile
            \ nobuflisted
            \ bufhidden=hide
            \ nonumber
            \ norelativenumber
            \ signcolumn=no
    endfunction

    nmap <C-b> :Buffers<CR>
    nmap <C-f> :Rg<CR>
    nmap <C-p> :GFiles<CR>
    nmap <C-c> :History<CR>


"----------------------------------------------------------------------
"                       VistaVim
"----------------------------------------------------------------------
   function! NearestMethodOrFunction() abort
     return get(b:, 'vista_nearest_method_or_function', '')
   endfunction

" How each level is indented and what to prepend.
   let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
   let g:vista#renderer#icons = {
   \   "function": "\uf794",
   \   "variable": "\uf71b",
   \  }

"Let Vista run explicitly
   autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"----------------------------------------------------------------------
"                       Lightline
"----------------------------------------------------------------------
   function! CocCurrentFunction()
       return get(b:, 'coc_current_function', '')
   endfunction

   let g:lightline = {
         \ 'colorscheme': 'gruvbox',
         \ 'active': {
         \   'left': [ [ 'mode', 'paste' ],
         \             [ 'cocstatus', 'readonly', 'relativepath', 'modified', 'method'] ],
         \ 'right': [ [ 'lineinfo' ],
         \            [ 'percent' ],
         \            [ 'fileformat', 'fileencoding', 'filetype' ] ] 
         \ },
         \ 'component_function': {
         \   'method': 'NearestMethodOrFunction',
         \   'cocstatus': 'coc#status',
         \ }
         \ }

   " set showtabline=2 "Always show tabline for bufferline on top

"----------------------------------------------------------------------
"                       CocNVIM
"----------------------------------------------------------------------
let g:coc_global_extensions = [
      \ 'coc-tsserver'
      \ ]

" Remap Format prettier file to
  nnoremap ,f :CocCommand prettier.formatFile<CR>

"Format Prettier coc-extension -> :Prettier on current buffer
    command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Better display for messages
    set cmdheight=1
" Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=1500
" don't give |ins-completion-menu| messages.
    set shortmess+=c
" always show signcolumns
    set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

" Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
" Use <c-.> to trigger code actions
    nnoremap <silent> <c-space> <Plug>(coc-codeaction)
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
    nnoremap <silent> ,K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

" Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
    vmap <leader>F  <Plug>(coc-format-selected)
    nmap <leader>F  <Plug>(coc-format-selected)
" Show all diagnostics
    nnoremap <silent> ,a  :<C-u>CocList diagnostics<cr>
" Manage extensions
    nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
" Show commands
    nnoremap <silent> ,c  :<C-u>CocList commands<cr>
" Find symbol of current document
    nnoremap <silent> ,o  :<C-u>CocList outline<cr>
" Search workspace symbols
    nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
    nnoremap <silent> ,j  :<C-u>CocNext<CR>
" Do default action for previous item.
    nnoremap <silent> ,k  :<C-u>CocPrev<CR>
" Resume latest coc list
    nnoremap <silent> ,p  :<C-u>CocListResume<CR>

" Turn off COC IN MARKDOWN
    "autocmd BufNew,BufEnter *.md,*.markdown,*.wiki execute "silent! CocDisable"

" Float preview scroll for diagnostics and documentation
  if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif

" Disable during easymotion navigation
  autocmd User EasyMotionPromptBegin silent! CocDisable
  autocmd User EasyMotionPromptEnd silent! CocEnable
"----------------------------------------------------------------------
"                       VIM TEST
"----------------------------------------------------------------------
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
