local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 10
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
	open_mapping = [[<c-\>]],
	hide_numbers = false,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	-- shell = vim.o.shell,
--[[
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	}, --]]
})
  -- config = function()
  --   require("toggleterm").setup({
  --     -- size can be a number or function which is passed the current terminal
  --     size = function(term)
  --       if term.direction == "horizontal" then
  --         return 10
  --       elseif term.direction == "vertical" then
  --         return vim.o.columns * 0.4
  --       end
  --     end,
  --     open_mapping = [[<c-\>]],
  --     hide_numbers = true, -- hide the number column in toggleterm buffers
  --     shade_filetypes = {},
  --     shade_terminals = true,
  --     shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  --     start_in_insert = true,
  --     persist_size = true,
  --     direction = 'horizontal',
  --     close_on_exit = true, -- close the terminal window when the process exits
  --     --shell = vim.o.shell, -- change the default shell
  --   })
  -- end


local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end