-- vim.notify( ' mini.clue setup ' )
-- @see nvim/plugin/2_mappings.lua

local leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  -- { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  -- { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  -- { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  -- { mode = 'n', keys = '<Leader>L', desc = '+Lua' },
  -- { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  -- { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  -- { mode = 'n', keys = '<Leader>r', desc = '+R' },
  -- { mode = 'n', keys = '<Leader>t', desc = '+Terminal/Minitest' },
  -- { mode = 'n', keys = '<Leader>T', desc = '+Test' },
  -- { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
  --
  -- { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
  -- { mode = 'x', keys = '<Leader>r', desc = '+R' },
}

-- Delay before showing clue window
local clue_delay = 1000
local clue_window = {
  config = { width = "auto" },
  delay = clue_delay,
  -- Keys to scroll inside the clue window
  scroll_down = '<C-d>',
  scroll_up = '<C-u>',
}

local clue_triggers = {
  -- Leader triggers
  { mode = "n", keys = "<Leader>" },
  { mode = "x", keys = "<Leader>" },
  -- Built-in completion
  { mode = "i", keys = "<C-x>" },
  -- `g` key
  { mode = "n", keys = "g" },
  { mode = "x", keys = "g" },
  -- Marks
  { mode = "n", keys = "'" },
  { mode = "n", keys = "`" },
  { mode = "x", keys = "'" },
  { mode = "x", keys = "`" },
  -- Registers
  { mode = "n", keys = '"' },
  { mode = "x", keys = '"' },
  { mode = "i", keys = "<C-r>" },
  { mode = "c", keys = "<C-r>" },
  -- Window commands
  { mode = "n", keys = "<C-w>" },
  -- `z` key
  { mode = "n", keys = "z" },
  { mode = "x", keys = "z" },
}

local miniclue = require('mini.clue')
miniclue.setup({
  window = clue_window,
  triggers = clue_triggers,
  clues = {
    leader_group_clues,
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})




