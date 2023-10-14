local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  spec = {
    -- I don't know why this is necessary to make the colorschemes work, and at this point I'm too afraid to ask
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins.colorscheme",
    },
    { import = "plugins" },
    -- {
    -- 	"LazyVim/LazyVim",
    -- 	import = "lazyvim.plugins",
    -- },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.formatting.conform" },
    -- { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- { import = "lazyvim.plugins.extras.linting.eslint" },
  },
  defaults = { lazy = false },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        -- "rplugin", -- need it for python-semshi
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
require("lazy").setup(opts)
