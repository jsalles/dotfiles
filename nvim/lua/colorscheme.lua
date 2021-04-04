vim.cmd('colorscheme onedark')
vim.cmd('let g:nvcode_termcolors=256')
-- Errors in Red
vim.cmd('hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red')
-- Warnings in Yellow
vim.cmd('hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow')
-- Info and Hints in White
vim.cmd('hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White')
vim.cmd('hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White')
