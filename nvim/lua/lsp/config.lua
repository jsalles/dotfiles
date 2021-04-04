-- vim.fn.sign_define("LspDiagnosticsSignError", { text = " 🞮", numhl = "LspDiagnosticsDefaultError" })
-- vim.fn.sign_define("LspDiagnosticsSignWarning", { text = " ▲", numhl = "LspDiagnosticsDefaultWarning" })
-- vim.fn.sign_define("LspDiagnosticsSignInformation", { text = " ⁈", numhl = "LspDiagnosticsDefaultInformation" })
-- vim.fn.sign_define("LspDiagnosticsSignHint", { text = " ⯁", numhl = "LspDiagnosticsDefaultHint" })
-- Diagnostic text colors
-- Errors in Red
vim.cmd [[ hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red ]]
-- Warnings in Yellow
vim.cmd [[ hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow ]]
-- Info and Hints in White
vim.cmd [[ hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White ]]
vim.cmd [[ hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White ]]
-- Underline the offending code
vim.cmd [[ hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline ]]
vim.cmd [[ hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline ]]
vim.cmd [[ hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline ]]
vim.cmd [[ hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline ]]
