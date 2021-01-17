" General settings
set nocompatible " Disable vim compatible mode
syntax on " Turn on syntax highlight
set number " Enable line numbers
set ignorecase " Ignore case on search
set cursorline " Enable cursorline
set expandtab " Tabs are spaces
set tabstop=2 " Tab becomes 2 spaces"
set softtabstop=2 " Also use tab as 2 spaces for vim operations"
set shiftwidth=2 " Use 2 spaces on identation"
set numberwidth=5 " Number column width"
set hlsearch                   " Highlight search results "
set incsearch                  " Turn on incremental searching
set showcmd                    " Turn on Cmd as typed on the bottom-bar
set backspace=indent,eol,start " Allow backspace in insert mode
set scrolloff=2                " When scrolling, keep cursor 2 lines away from screen border
set nowrap                     " Wrap lines when they are too long
set title                      " Update the title of the window or the terminal
set wildmode=longest,list,full " List as much as possible
set wildmenu                   " Visual autocomplete for command menu
set splitbelow                 " Splits open at the bottom, unlike vim defaults.
set splitright                 " Splits open at the right, unlike vim defaults.
set wildignorecase
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
set noswapfile                 " NO SWAP FILES
set wildcharm=<C-z>            " Juggling with buffers
"set list                       " Be aware of trailing spaces
"set listchars=tab:>-

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Turn off Cursorline in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

