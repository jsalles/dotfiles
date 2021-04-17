" General settings
set termguicolors
syntax on

set expandtab " Tabs are spaces
set tabstop=2
set softtabstop=2 
set smartindent
set shiftwidth=2

set relativenumber
set nu

set hidden
set noerrorbells

set nowrap

set ignorecase " Ignore case on search
set smartcase
set incsearch                  " Turn on incremental searching
set hlsearch                   " Highlight search results "

set noswapfile                 " NO SWAP FILES
set nobackup
set undodir=~/.vim/undodir
set undofile

set scrolloff=8

set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes

set cmdheight=2

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Turn off Cursorline in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

if exists("current_compiler")
  finish
endif
let current_compiler = "tsc_lint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=tsc\ --noEmit\ --skipLibCheck\ $*\ -p\ .
CompilerSet errorformat=%A%f(%l\\,%c):\ %trror\ TS%n:\ %m,%C%m

