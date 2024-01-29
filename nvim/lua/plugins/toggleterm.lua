return {
  {
    "akinsho/nvim-toggleterm.lua",
    keys = [[<c-\>]],
    opts = {
      size = 20,
      hide_numbers = true,
      open_mapping = [[<c-\>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      persist_size = true,
      direction = "float",
    },
    init = function()
      vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])
    end,
  },
}
