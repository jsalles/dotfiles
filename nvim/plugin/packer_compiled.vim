" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/joao.salles/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/joao.salles/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/joao.salles/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/joao.salles/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/joao.salles/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["fern-git-status.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fern-git-status.vim"
  },
  ["fern-hijack.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fern-hijack.vim"
  },
  ["fern-mapping-fzf.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fern-mapping-fzf.vim"
  },
  ["fern-renderer-nerdfont.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fern-renderer-nerdfont.vim"
  },
  ["fern.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fern.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["nerdfont.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nerdfont.vim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/vim-which-key"
  },
  ["vscode-es7-javascript-react-snippets"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/vscode-es7-javascript-react-snippets"
  },
  ["vscode-javascript"] = {
    loaded = true,
    path = "/Users/joao.salles/.local/share/nvim/site/pack/packer/start/vscode-javascript"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
