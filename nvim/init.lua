require("util")
require("options")
require("commands")

vim.defer_fn(function()
	require("plugins")
end, 0)

