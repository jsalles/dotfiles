return {
  {
    -- highlights ( { [ when hovering
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  {
    -- highlights other occurrences of hovered work
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    -- highlights patterns like hex color in the text
    "echasnovski/mini.hipatterns",
    event = "LazyFile",
    opts = function()
      local hipatterns = require("mini.hipatterns")

      return {
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color({ priority = 2000 }),
        }
      }
    end,
  },

}
