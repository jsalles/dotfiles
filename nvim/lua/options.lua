local indent = 2

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.o.termguicolors = true

vim.o.confirm = true
vim.o.cursorline = true
vim.o.guifont = "FireCode Nerd Font:h12"

-- vim.o.expandtab = true -- Tabs are spaces
vim.o.tabstop = indent
vim.o.softtabstop = indent
-- vim.o.smartindent = false
vim.o.shiftwidth = indent

vim.o.number = true
vim.o.relativenumber = true

vim.o.hidden = true
-- set noerrorbells

vim.o.wrap = false

vim.o.ignorecase = true -- Ignore case on search
vim.o.smartcase = true
vim.o.incsearch = true -- Turn on incremental searching
vim.o.hlsearch = true -- Highlight search results

vim.o.undofile = true
vim.o.undolevels = 10000

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.showmode = false
vim.o.wildmode = "longest:full,full"
vim.o.signcolumn = "yes"

-- syntax
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- Turn off Cursorline in insert mode
vim.cmd([[
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
  ]])

vim.cmd("au TextYankPost * lua vim.highlight.on_yank {}")
