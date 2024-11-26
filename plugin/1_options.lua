vim.cmd("colorscheme kanagawa")
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins
vim.g.mapleader = ' ' -- Use space as the one and only true Leader key

vim.o.shortmess     = 'aoOWFcSC' -- Reduce command line messages
vim.o.shada        = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file
vim.o.formatoptions  = 'qjl1'-- Don't autoformat comments
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

--opt.shortmess:append('WcC') -- Reduce command line messages
--vim.o.pumblend = 0
--vim.o.winblend = 0

local opt = vim.opt

opt.autowrite      = true -- Enable auto write
opt.backup         = false -- Don't store backup while overwriting the file
opt.breakindent    = true    -- Indent wrapped lines to match line start
opt.clipboard      = "unnamedplus" -- Sync with system clipboard
opt.cmdheight      = 0 -- hide command line unless needed
opt.completeopt    = 'menuone,noinsert,noselect' -- Customize completions
opt.completeopt:append('fuzzy') -- Use fuzzy matching for built-in completion
opt.complete:remove('t')  -- Don't use tags for completion
opt.conceallevel   = 2    -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm        = true -- Confirm to save changes before exiting modified buffer
opt.cursorline     = true -- Highlight current line
opt.colorcolumn    = "120"
opt.expandtab      = true -- Use spaces instead of tabs
opt.fillchars      = {foldopen = "",foldclose = "",fold = "-",foldsep = " ",diff = "╱",eob = " ",}

opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"

opt.grepformat     = "%f:%l:%c:%m"
opt.grepprg        = "rg --vimgrep"
-- opt.guicursor      = ''
opt.hlsearch       = true
opt.ignorecase     = true -- Ignore case when searching (use `\C` to force not doing that)
opt.inccommand     = "split" -- preview incremental substitute
opt.incsearch      = true -- Show search results while typing
opt.infercase      = true -- Infer letter cases for a richer built-in keyword completion
opt.laststatus     = 3 -- global statusline
opt.linebreak      = true    -- Wrap long lines at 'breakat' (if 'wrap' is set)
opt.list           = true -- Show some invisible characters (tabs...
opt.listchars      = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',') -- Define which helper symbols to show
opt.mouse          = 'a'   -- Enable mouse for all available modes
opt.number         = true  -- Show line numbers
opt.pumblend       = 0 --  no transparency
opt.pumheight      = 10 -- Make popup menu smaller
opt.winblend       = 0 --  No transparency
opt.relativenumber = true -- Relative line numbers
opt.ruler          = false   -- Don't show cursor position in command line
opt.scrolloff      = 10 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround     = true -- Round indent
opt.shiftwidth     = 2 -- Size of an indent
opt.showmode      = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn    = "yes:1" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase     = true -- Don't ignore case with capitals
opt.smartindent   = true -- Insert indents automatically
opt.smoothscroll  = true
opt.spelllang     = { "en" }
opt.splitbelow    = true -- Put new windows below current
opt.splitkeep     =  "screen"
opt.splitright    = true -- Put new windows right of current
opt.swapfile      = false -- bye bye
opt.tabstop       = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen    = 1000 --300
opt.ttimeoutlen   = 10
opt.undofile      = true  -- Enable persistent undo (see also `:h undodir`)
opt.undolevels    = 10000
opt.updatetime    = 250 -- Save swap file and trigger CursorHold
opt.virtualedit   = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode      = "longest:full,full" -- Command-line completion mode
opt.winblend      = 0 -- Have no transparency to always have "overflow" icons
opt.winminwidth   = 5 -- Minimum window width
opt.wrap          = false   -- Display long lines as just one line
opt.writebackup   = false -- Don't store backup while overwriting the file


--
-- vim.opt.foldlevel = 99
-- TODO!
-- vim.opt.foldtext = "v:lua.require'ak.util'.ui.foldtext()"
-- vim.opt.statuscolumn = [[%!v:lua.require'ak.util'.ui.statuscolumn()]]
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.require'ak.util'.ui.foldexpr()"
-- vim.opt.foldmethod = "indent"
--

--opt.shortmess:append({ W = true, I = true, c = true, C = true })
--
--
-- opt.formatoptions  = "jcroqlnt" -- tcqj
--opt.fillchars      = 'eob: ' -- Don't show `~` outside of buffer
--
-- opt.completeopt = "menu,menuone,noselect"
