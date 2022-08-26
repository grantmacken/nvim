-- vim:sw=2 fdm=marker
-- {{{ [ disable builtin plugins ]
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

-- }}}
-- Leader key -> space
local opts = { noremap = true, silent = true }
local km = vim.api.nvim_set_keymap
--Remap space as leader key
km('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Install packer
--
-- {{{ [ packer install
local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]
-- vim.api.nvim_exec(
--   [[
--   augroup Packer
--     autocmd!
--     autocmd BufWritePost init.lua PackerCompile
--   augroup end
-- ]],
--   false
-- )
--}}}
local use = require('packer').use
require('packer').startup {
  function()
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
    use { 'sainnhe/everforest' }
    use 'savq/melange'
    use 'EdenEast/nightfox.nvim'
    use 'joshdick/onedark.vim'
    use 'rebelot/kanagawa.nvim'
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup {}
      end,
    }
    -- STATUSLINE
    use 'nvim-lualine/lualine.nvim'
    use {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup {}
      end,
    }
    --[[ use { --TODO ]]
    --[[   'akinsho/bufferline.nvim', ]]
    --[[   tag = 'v2.*', ]]
    --[[   requires = 'kyazdani42/nvim-web-devicons', ]]
    --[[   config = function() ]]
    --[[     require('bufferline').setup {} ]]
    --[[   end, ]]
    --[[ } ]]

  use {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = function()
      require("marks").setup {}
    end,
  }
    -- tabs
    -- use {
    --   'jose-elias-alvarez/buftabline.nvim',
    --   config = function()
    --     require('buftabline').setup {}
    --   end,
    -- }
    --
    use {
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup {}
      end,
    }
    use 'lewis6991/gitsigns.nvim'
    use 'numToStr/Comment.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use {'akinsho/toggleterm.nvim', tag = 'v2.*'}
    -- TELESCOPE
    use 'nvim-telescope/telescope.nvim'
    -- use("cljoly/teles-cope-repo.nvim")
    use {
      'AckslD/nvim-neoclip.lua',
      config = function()
        require('neoclip').setup()
      end,
    }
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    }

    use { --TODO
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('diffview').setup {}
      end,
    }

    -- use { --TODO
    --   'pwntester/octo.nvim',
    --   requires = {
    --     'nvim-lua/plenary.nvim',
    --     'nvim-telescope/telescope.nvim',
    --     'kyazdani42/nvim-web-devicons',
    --   },
    --   config = function()
    --     require('octo').setup()
    --   end,
    -- }

    use 'folke/which-key.nvim'
    use {
      'lambdalisue/suda.vim',
      cmd = { 'SudaRead', 'SudaWrite' },
      startup = function()
        vim.g.suda_smart_edit = true
      end,
    }
    use { 'tpope/vim-eunuch', cmd = { 'Delete', 'Remove', 'Move', 'Chmod', 'Wall', 'Rename' } }
    use { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } }
    use { -- todo
      'phaazon/hop.nvim',
      setup = function()
        --  local opts = { noremap = true, silent = true }
        --vim.api.nvim_set_keymap('', ',', '<cmd>HopChar-1<CR>', opts)
        --vim.api.nvim_set_keymap('', ',,', '<cmd>HopPattern<CR>', opts)
      end,
    }
    use 'romainl/vim-cool'
    use 'ThePrimeagen/harpoon'
    --  TREESITTER
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        'David-Kunz/treesitter-unit', --test
        'JoosepAlviste/nvim-ts-context-commentstring',
        'andymass/vim-matchup',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context', -- TODO
        'nvim-treesitter/playground',
        'p00f/nvim-ts-rainbow',
      },
    }

    -- LSP AND COMPLETIONS PLUGINS
    use { 'neovim/nvim-lspconfig' } -- Collection of configurations for built-in LSP client
    use {
      'hrsh7th/nvim-cmp', -- Autocompletion plugin
      requires = {
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }, -- LSP source for nvim-cmp
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }, -- Snippets source for nvim-cmp
        { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' }, -- Snippets plugin
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
        { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'ray-x/cmp-treesitter', after = 'nvim-cmp' },
        { 'delphinus/cmp-ctags', after = 'nvim-cmp' },
        { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      },
    }

    --[[     use 'onsails/lspkind-nvim' ]]
    use 'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight

    -- use {
    --   'vigoux/complementree.nvim',
    --   requires = {
    --     'L3MON4D3/LuaSnip',
    --     'nvim-treesitter/nvim-treesitter',
    --   },
    --   config = function()
    --     local s = require 'complementree.defaults'
    --     local lsp_completion = {
    --      : default = s.lsp,
    --       string = s.ins_completion 'C-F',
    --       comment = s.dummy,
    --     }
    --     require('complementree').setup {
    --       default = s.ins_completion 'C-N',
    --       lua = lsp_completion,
    --     }
    --   end,
    -- }

    -- lINTERS AND FORMATTERS
    use 'mfussenegger/nvim-lint' -- uses the vim.diagnostic module to present diagnostics in the same way the language client
    use 'mhartington/formatter.nvim' -- ./configs/.config/nvim/after/plugin/format.lua
    -- MARKDOWN
    -- use 'ellisonleao/glow.nvim'
    --TEST
    use 'rcarriga/nvim-notify'
    --https://github.com/stevearc/dressing.nvim
    -- use {
    --   's1n7ax/nvim-window-picker',
    --   tag = 'v1.*',
    --   config = function()
    --     require('window-picker').setup {
    --       autoselect_one = true,
    --       include_current = false,
    --       filter_rules = {
    --         -- filter using buffer options
    --         bo = {
    --           -- if the file type is one of following, the window will be ignored
    --           filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'quickfix' },
    --           -- if the buffer type is one of following, the window will be ignored
    --           buftype = { 'terminal' },
    --         },
    --       },
    --       other_win_hl_color = '#e35e4f',
    --     }
    --   end,
    -- }
    --
    use {
      "mrbjarksen/neo-tree-diagnostics.nvim",
      requires = "nvim-neo-tree/neo-tree.nvim",
    }

    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
      },


    }
    use {
      'rmagatti/auto-session',
      config = function()
        require("auto-session").setup {
          log_level = "error",
          auto_session_allowed_dirs = {
            "~/projects/grantmacken/gmack.nz",
            "~/projects/grantmacken/podx",
            "~/projects/grantmacken/dots",
            "~/projects/grantmacken/xqerl",
            "~/projects/grantmacken/glider"},
        }
      end
    }

    --[[ use {'edluffy/hologram.nvim', ]]
    --[[   config = function() ]]
    --[[     require('hologram').setup{ ]]
    --[[       auto_display = true -- WIP automatic markdown image display, may be prone to breaking ]]
    --[[     } ]]
    --[[   end ]]
    --[[ } ]]

  end,
  -- {{{ packer config
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  }, -- }}}
}

-- {{{ [ diagnostic signs ]

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

--}}}
-- {{{ [ diagnostics ]
vim.diagnostic.config {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}
--}}}
-- {{{ [ commands ]
require('kanagawa').setup {
  undercurl = true,
  globalStatus = true,
  commentStyle = { italic = true },
  overrides = { TSError = { link = 'Error' } },
}
-- vim.cmd([[colorscheme melange]])
vim.cmd [[colorscheme kanagawa]]
local exec = vim.api.nvim_exec
exec(
  [[
command! FindFiles packadd telescope.nvim | lua require('telescope.builtin').find_files({ hidden = true })
command! GrepFiles packadd telescope.nvim | lua require('telescope.builtin').live_grep()
command! GitFiles packadd telescope.nvim | lua require('telescope.builtin').git_files()
command! -count=1 GitStatus  lua require('toggleterm').exec('git status --short --branch',<count>, 12)
command! -count=1 GitPush  lua require('toggleterm').exec('git push',<count>, 12)
]],
  false
)

-- }}}
-- {{{ [ keymaps ]
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   -- Get rid of annoying ex keybind
km('', 'Q', '<Nop>', { silent = true })
-- n always goes forward
-- vim.keymap.set('n', 'n', "'Nn'[v:searchforward]", { expr = true })
-- vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true })
-- vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true })
-- vim.keymap.set('n', 'N', "'nN'[v:searchforward]", { expr = true })
-- vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true })
-- vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true })
-- map :W to :w (helps which-key issue)
vim.cmd [[ command! W  execute ':w' ]]
-- Better window navigation
km('n', '<C-h>', '<C-w>h', opts)
km('n', '<C-j>', '<C-w>j', opts)
km('n', '<C-k>', '<C-w>k', opts)
km('n', '<C-l>', '<C-w>l', opts)
-- Resize with arrows
km('n', '<C-Up>', ':resize -2<CR>', opts)
km('n', '<C-Down>', ':resize +2<CR>', opts)
km('n', '<C-Left>', ':vertical resize -2<CR>', opts)
km('n', '<C-Right>', ':vertical resize +2<CR>', opts)
-- Navigate buffers
km('n', ']b', ':bnext<CR>', opts)
km('n', '[b', ':bprevious<CR>', opts)
-- Stay in indent mode
km('v', '<', '<gv', opts)
km('v', '>', '>gv', opts)

-- diagnostics

-- km("v", "p", '" dP', opts)
-- Move text up and down
-- km("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
--km("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- telescope find files
-- km('n', '-', '<cmd>FindFiles<cr>', opts)
km('n', '_', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)

km('n', 'gd', '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>', opts)


km('n', '<F5>', '<cmd>ToggleTermSendCurrentLine<cr>', opts)

-- harpoon
km('n', '<F6>', '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<cr>', opts)
km('n', '<F7>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)

--Add leader shortcuts
--km('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],opts)
km('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
km('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
km('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
km('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
km('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
km('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
km('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
km('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)



-- }}}
--{{{ [ autocomands ]
--
--- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  command = 'silent! lua vim.highlight.on_yank()',
  group = yankGrp,
})



SetTerminalKeymaps = function()
  local opt = { noremap = true }
  local bkm = vim.api.nvim_buf_set_keymap
  bkm(0, 't', '<esc>', [[<C-\><C-n>]], opt)
  bkm(0, 't', 'jk', [[<C-\><C-n>]], opt)
  bkm(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opt)
  bkm(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opt)
  bkm(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opt)
  bkm(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opt)
end

vim.api.nvim_exec(
  [[
  augroup MyAutocomands
    autocmd!
    autocmd TermOpen term://* lua SetTerminalKeymaps()
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
  augroup end
]],
  false
)

-- autocmd BufWritePost <buffer> lua require('lint').try_lint()
--}}}
require('xqerl')
require('my.buffers')

--
local neoTreeExec = require('neo-tree.command').execute
vim.keymap.set('', '<A-d>', function() neoTreeExec({
  source='diagnostics',
  reveal = true,
  position='bottom',
  toggle = true
  }) end, { noremap = true })
vim.keymap.set('n', '-', function() neoTreeExec({
  source='filesystem',
  reveal = true,
  position='float',
  toggle = true
  }) end, { noremap = true })
vim.keymap.set('n', '<A-b>', function() neoTreeExec({
  source='buffers',
  reveal = true,
  position='right',
  toggle = true
  }) end, { noremap = true })
vim.keymap.set('n', '<A-g>', function() neoTreeExec({
  source='git_status',
  reveal = true,
  position='float',
  toggle = true
  }) end, { noremap = true })


-- vim.keymap.set('n', '-', '<cmd>NeoTreeFloatToggle filesystem<cr>', opts)
--vim.keymap.set('n', '<A-b>', '<cmd>NeoTreeFloatToggle buffers<cr>', opts)
-- Diagnostics and Quickfix
vim.keymap.set('n', '<A-q>', require('my.buffers').quickfix_toggle , { noremap = true })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- Quickfix history navigation
vim.keymap.set('', ']h', '<Cmd>cnewer<CR>', { noremap = true })
vim.keymap.set('', '[h', '<Cmd>colder<CR>', { noremap = true })
--[[    require("neo-tree").reveal_current_file("filesystem", false, "<bang>" == "!") ]]
-- Diagnostic keymaps
--km('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
--km('n', '<leader>Q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

