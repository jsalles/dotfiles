local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
	view = {
		mappings = {
			list = {
				{ key = { "<CR>", "l", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
				{ key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
				{ key = "<C-v>", cb = tree_cb("vsplit") },
				{ key = "<C-x>", cb = tree_cb("split") },
				{ key = "<C-t>", cb = tree_cb("tabnew") },
				{ key = { "h", "<BS>", "<S-CR>" }, cb = tree_cb("close_node") },
				{ key = "<Tab>", cb = tree_cb("preview") },
				{ key = "I", cb = tree_cb("toggle_ignored") },
				{ key = "H", cb = tree_cb("toggle_dotfiles") },
				{ key = "R", cb = tree_cb("refresh") },
				{ key = "a", cb = tree_cb("create") },
				{ key = "d", cb = tree_cb("remove") },
				{ key = "r", cb = tree_cb("rename") },
				{ key = "<C-r>", cb = tree_cb("full_rename") },
				{ key = "x", cb = tree_cb("cut") },
				{ key = "c", cb = tree_cb("copy") },
				{ key = "yy", cb = tree_cb("copy") },
				{ key = "p", cb = tree_cb("paste") },
				{ key = "[c", cb = tree_cb("prev_git_item") },
				{ key = "]c", cb = tree_cb("next_git_item") },
				{ key = "-", cb = tree_cb("dir_up") },
				{ key = "q", cb = tree_cb("close") },
			},
		},
		-- auto_resize = true,
	},
	update_focused_file = {
		enable = true,
	},
	open_on_setup = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = true,
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
