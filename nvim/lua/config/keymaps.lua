local map = vim.keymap.set

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- theprimeagen sessionizer
map("n", "<C-f>", function()
  os.execute("tmux neww tmux-sessionizer")
end)

map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

map("n", "H", "^")
map("n", "L", "$")

-- Resize window using <ctrl> arrow keys
map("n", "<Up>", ":resize +2<CR>")
map("n", "<Down>", ":resize -2<CR>")
map("n", "<Left>", ":vertical resize -2<CR>")
map("n", "<Right>", ":vertical resize +2<CR>")

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Quicklist
map("n", "[q", ":cprev<CR>")
map("n", "]q", ":cnext<CR>")

-- Theprimagen remaps
-- Standard behavior
map("n", "Y", "y$")

-- Keeping it centered
map("n", "J", "mzJ`z")

-- Undo break points
map("i", ",", "',<C-g>u'", { expr = true })
map("i", ".", "'.<C-g>u'", { expr = true })

-- Switch buffers with tab
map("n", "<tab>", ":bnext<cr>")
map("n", "<S-tab>", ":bprevious<cr>")

-- Clear search with <esc>
map({ "n" }, "<esc>", ":noh<cr><esc>")
map("n", "gw", "*N")
map("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true })
map("x", "n", "'Nn'[v:searchforward]", { expr = true })
map("o", "n", "'Nn'[v:searchforward]", { expr = true })
map("n", "N", "'nN'[v:searchforward]", { expr = true })
map("x", "N", "'nN'[v:searchforward]", { expr = true })
map("o", "N", "'nN'[v:searchforward]", { expr = true })

map("n", "<leader>gl", function()
  require("lazy.util").float_term("lazygit")
end)

-- window management
map("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
map("n", "<leader>w-", "<C-W>s", { desc = "split-window-below" })
map("n", "<leader>w|", "<C-W>v", { desc = "split-window-right" })
map("n", "<leader>w2", "<C-W>v", { desc = "layout-double-columns" })
map("n", "<leader>w=", "<C-W>=", { desc = "balance-window" })
map("n", "<leader>wo", "<cmd>:only<CR>", { desc = "Close other windows" })
