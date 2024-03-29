local wk = require("which-key")
local util = require("util")

vim.o.timeoutlen = 300

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil
wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

-- theprimeagen sessionizer
util.nnoremap("<C-f>", function()
  os.execute("tmux neww tmux-sessionizer")
end)

util.nnoremap("<leader>d", '"_d')
util.vnoremap("<leader>d", '"_d')

util.nnoremap("H", "^")
util.nnoremap("L", "$")

-- Resize window using <ctrl> arrow keys
util.nnoremap("<Up>", ":resize +2<CR>")
util.nnoremap("<Down>", ":resize -2<CR>")
util.nnoremap("<Left>", ":vertical resize -2<CR>")
util.nnoremap("<Right>", ":vertical resize +2<CR>")

-- Move Lines
util.nnoremap("<A-j>", ":m .+1<CR>==")
util.vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
util.inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
util.nnoremap("<A-k>", ":m .-2<CR>==")
util.vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
util.inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- Quicklist
util.nnoremap("[q", ":cprev<CR>")
util.nnoremap("]q", ":cnext<CR>")

-- Theprimagen remaps
-- Standard behavior
util.nnoremap("Y", "y$")

-- Keeping it centered
util.nnoremap("J", "mzJ`z")

-- Undo break points
util.inoremap(",", "',<C-g>u'", { expr = true })
util.inoremap(".", "'.<C-g>u'", { expr = true })

-- Switch buffers with tab
util.nnoremap("<tab>", ":bnext<cr>")
util.nnoremap("<S-tab>", ":bprevious<cr>")

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.onoremap("N", "'nN'[v:searchforward]", { expr = true })

-- telescope <ctrl-r> in command line
-- vim.cmd([[cmap <C-R> <Plug>(TelescopeFuzzyCommandSearch)]])

-- markdown
util.nnoremap("=t", "<cmd>TableFormat<cr>")
vim.cmd([[autocmd FileType markdown nnoremap gO <cmd>Toc<cr>]])
vim.cmd([[autocmd FileType markdown setlocal spell]])

-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

local leader = {
  ["w"] = {
    name = "+windows",
    ["d"] = { "<C-W>c", "delete-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
    ["o"] = { "<cmd>:only<CR>", "Close other windows" }
  },
  --[[ c = {
		v = { "<cmd>Vista!!<CR>", "Vista" },
		o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
	}, ]]
  b = {
    name = "+buffer",
    ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
    ["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
    ["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
    ["g"] = { "<cmd>:BufferLinePick<CR>", "Goto Buffer" },
    -- ["d"] = { "<cmd>:bd<CR>", "Delete Buffer" },
    ["d"] = {
      name = "delete",
      ["h"] = { "<cmd>:BDelete hidden<CR>", "Delete Hidden" },
      ["a"] = { "<cmd>:BDelete all<CR>", "Delete all" },
      ["d"] = { "<cmd>:BDelete this<CR>", "Delete this" },
    },
  },
  g = {
    name = "+git",
    g = { "<cmd>Neogit<CR>", "Neogit" },
    l = {
      function()
        require("util").float_terminal("lazygit")
      end,
      "LazyGit",
    },
    c = { "<Cmd>Telescope git_commits<CR>", "commits" },
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    s = { "<Cmd>Telescope git_status<CR>", "status" },
    d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
    D = { "<cmd>DiffviewOpen origin/mainline..HEAD<cr>", "DiffView to origin/mainline" },
    h = { name = "+hunk" },
    w = {
      name = "+Worktree",
      l = {
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        "list",
      },
      c = {
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        "create",
      },
    },
  },
  ["h"] = {
    name = "+help",
    t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>:Telescope commands<cr>", "Commands" },
    h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
    l = {
      [[<cmd>TSHighlightCapturesUnderCursor<cr>]],
      "Highlight Groups at cursor",
    },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
    p = {
      name = "+packer",
      p = { "<cmd>PackerSync<cr>", "Sync" },
      s = { "<cmd>PackerStatus<cr>", "Status" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      c = { "<cmd>PackerCompile<cr>", "Compile" },
    },
  },
  -- u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
  s = {
    name = "+search",
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Goto Symbol" },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" }
  },
  f = {
    name = "+file",
    -- t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
    m = { "<cmd>Telescope harpoon marks<CR>", "Marks" }
    -- d = "Dot Files"
  },
  o = {
    name = "+alternates",
    o = { "<cmd>Other<cr>", "List" },
    i = { "<cmd>Other implementation<cr>", "Implementation" },
    t = { "<cmd>Other tests<cr>", "Tests" },
    s = { "<cmd>Other styles<cr>", "Styles" },
  },
  t = {
    name = "toggle",
    f = { require("config.lsp.formatting").toggle, "Format on Save" },
    s = {
      function()
        util.toggle("spell")
      end,
      "Spelling",
    },
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
    n = {
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      "Line Numbers",
    },
    r = {
      function()
        util.toggle("relativenumber")
      end,
      "Relative Numbers",
    },
  },
  ["<tab>"] = {
    name = "workspace",
    ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

    n = { "<cmd>tabnext<CR>", "Next" },
    d = { "<cmd>tabclose<CR>", "Close" },
    p = { "<cmd>tabprevious<CR>", "Previous" },
    ["]"] = { "<cmd>tabnext<CR>", "Next" },
    ["["] = { "<cmd>tabprevious<CR>", "Previous" },
    f = { "<cmd>tabfirst<CR>", "First" },
    l = { "<cmd>tablast<CR>", "Last" },
  },
  ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
  -- [" "] = "Find File",
  ["."] = { ":Telescope file_browser<CR>", "Browse Files" },
  [","] = {
    "<cmd>Telescope buffers show_all_buffers=true<cr>",
    "Switch Buffer",
  },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  l = {
    name = "Harpoon",
    l = { function() require("harpoon.ui").toggle_quick_menu() end, "List marks" },
    a = { function() require("harpoon.mark").add_file() end, "Add mark" },
    n = { function() require("harpoon.ui").nav_next() end, "Next" },
    p = { function() require("harpoon.ui").nav_prev() end, "Previous" }
  },
  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    w = { "<cmd>TroubleWorkspaceToggle<cr>", "Workspace Trouble" },
    d = { "<cmd>TroubleDocumentToggle<cr>", "Document Trouble" },
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
  },
  q = {
    name = "+sessions",
    s = { require("persistence").load, "Restore" },
    l = {
      function()
        require("persistence").load({ last = true })
      end,
      "Last",
    },
    d = { require("persistence").stop, "Stop" },
  },
  y = {
    name = "+yank",
    p = { ":let @+ = expand('%:p')<CR>", "Path" },
    f = { ":let @+ = expand('%')<CR>", "File Location" },
  }
  -- Z = {[[<cmd>lua require("zen-mode").reset()<cr>]], "Zen Mode"},
  -- z = {[[<cmd>ZenMode<cr>]], "Zen Mode"},
  -- T = {[[<Plug>PlenaryTestFile]], "Plenary Test"}
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto", h = "Hop Word" }, s = "Hop Word1" })

-- windows to close with "q"
vim.cmd([[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]])
vim.cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])
