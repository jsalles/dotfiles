local M = {}

local stylua = { formatCommand = "stylua -", formatStdin = true }
local selene = {
	lintCommand = "selene --display-style quiet -",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %tarning%m", "%f:%l:%c: %tarning%m" },
}

local prettier = {
	formatCommand = "./node_modules/.bin/prettier --stdin --stdin-filepath ${INPUT}",
	formatStdin = true,
}

local eslint = {
	lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %trror %m" },
}

local markdownlint = {
	lintCommand = "markdownlint -s",
	lintStdin = true,
	lintFormats = { "%f:%l:%c %m" },
}

local eslintPrettier = { prettier, eslint }

M.config = {
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { "package.json", ".git" },
		languages = {
			--[[ lua = { stylua, selene },
			typescript = eslintPrettier,
			javascript = eslintPrettier,
			typescriptreact = eslintPrettier,
			javascriptreact = eslintPrettier,
			["typescript.tsx"] = eslintPrettier,
			["javascript.tsx"] = eslintPrettier,
			yaml = { prettier },
			json = { prettier },
			html = { prettier },
			less = { prettier },
			scss = { prettier },
			css = { prettier },
			markdown = { prettier, markdownlint }, ]]
		},
	},
}

M.config.filetypes = {}
for ft, _ in pairs(M.config.settings.languages) do
	table.insert(M.config.filetypes, ft)
end

M.formatted_languages = {}

for lang, tools in pairs(M.config.settings.languages) do
	for _, tool in pairs(tools) do
		if tool.formatCommand then
			M.formatted_languages[lang] = true
		end
	end
end

return M
