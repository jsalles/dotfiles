local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    --[[ vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		file_sorter = require("telescope.sorters").get_fzy_sorter, ]]
    prompt_prefix = " 🔍 ",
    -- color_devicons = true,
    layout_config = { prompt_position = "top" },

    -- sorting_strategy = "ascending",

    --[[ file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new, ]]

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["Q"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["q"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["v"] = actions.file_vsplit,
        ["s"] = actions.file_split,
        ["<cr>"] = actions.file_edit,
      },
    },
  },
  -- extensions = {
  --   fzy_native = {
  --     override_generic_sorter = false,
  --     override_file_sorter = true,
  --   },
  -- },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("harpoon")
-- require("telescope").load_extension("telescope-alternate")

-- Implement delta as previewer for diffs

local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")
-- local conf = require("telescope.config")
local M = {}

local delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == "??" or "A " then
      return {
        "git",
        "-c",
        "core.pager=delta",
        "-c",
        "delta.side-by-side=false",
        "diff",
        entry.value,
      }
    end

    -- note we can't use pipes
    -- this command is for git_commits and git_bcommits
    return {
      "git",
      "-c",
      "core.pager=delta",
      "-c",
      "delta.side-by-side=false",
      "diff",
      entry.value .. "^!",
    }
  end,
})

M.my_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_commits(opts)
end

M.my_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_bcommits(opts)
end

M.my_git_status = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_status(opts)
end

return M
