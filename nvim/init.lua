require("options")
require("util.lazy")
require("commands")

vim.defer_fn(function()
  require("plugins")
end, 0)
