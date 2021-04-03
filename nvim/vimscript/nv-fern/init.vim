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
