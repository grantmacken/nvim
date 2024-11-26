
-- Helper function
local keymap = function(mode, keys, cmd, desc, opts)
  opts = opts or {}
  opts.desc = desc
  if opts.silent == nil then opts.silent = true end
  vim.keymap.set(mode, keys, cmd, opts)
end


local nMap = function( keys, rhs, desc, opts)
  keymap('n', keys, rhs, desc, opts)
end

local nxoMap = function( keys, rhs, desc, opts)
  keymap({ "n", "x", "o" }, keys, rhs, desc, opts)
end

--
-- local iMap = function( keys, rhs, opts)
--   keymap('i', keys, rhs, 'insert', opts)
-- end

-- Create `<Leader>` mappings
local leader = function(mode, suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, '<Leader>' .. suffix, rhs, opts)
end

local nLeader = function(suffix, rhs, desc, opts)
  leader ('n',suffix, rhs, desc, opts)
end

-- local xLeader = function(suffix, rhs, desc, opts)
--   leader('x', suffix, rhs, desc, opts)
-- end
--
--- NOTE
-- ## defaults ##
-- BRACKETS => DIAGNOSTICS
-- ]d-default| and |[d-default| accept a count.
-- [D-default| and |]D-default| jump to the first and last diagnostic in the current buffer

--quicker
nLeader('q',function() require("quicker").toggle() end,                'Toggle quickfix')
nLeader('l',function() require("quicker").toggle({loclist = true}) end,'Toggle loclist')

--ressession
--nLeader('ss',function() require("resession").save() end ,'Session Save')
--nLeader('sl',function() require("resession").load() end,'Session Load')
--nLeader('sd',function() require("resession").delete() end,'Session Delete')
--
--oil
nMap('-',function() vim.cmd.Oil() end,'[oil] open parent directory' )
nLeader( 'ff',require("fzf-lua").files,"[FZF] Find Files " )
nLeader( 'bf',require("fzf-lua").buffers,"[FZF] buffers" )

-- flash
nxoMap('s', function() require("flash").jump() end,  "Flash")
nxoMap('S', function() require("flash").jump() end,  "Flash Treesitter ")

-- b is for 'buffer'
-- nLeader('ba', 'Alternate')
nLeader('bd', function() require("mini.buffer").delete() end,       'Delete')
--nLeader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>', 'Delete!')
--nLeader('bs', require('mod.buffers').new_scratch_buffer,    'Scratch')
--nLeader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',       'Wipeout')
--nLeader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>','Wipeout!')


-- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-completion.txt
--To get more consistent behavior of `<CR>`, you can use this template in your 'init.lua' to make customized mapping
-- local keys = {
  --     ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  --     ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  --     ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
  -- }

