-- https://github.com/akinsho/toggleterm.nvim
local size = function(term)
  if term.direction == "horizontal" then
    return 15
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  end
end

require('toggleterm').setup({
  -- This field is only relevant if direction is set to 'float'
  auto_scroll = false,
  autochdir = false,
  close_on_exit = false,
  direction = 'horizontal',
  hide_numbers = true,
  insert_mappings = true,
  open_mapping = [[<c-\>]],
  persist_size = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  size = size,
  start_in_insert = true,
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
})

