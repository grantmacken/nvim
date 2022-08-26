local opt = vim.opt
opt.encoding = "UTF-8"
opt.termguicolors = true
-- Ignore compiled files
--opt.wildignore = "__pycache__"
--opt.wildignore = opt.wildignore + { ".git", "*.o", "*~", "*.pyc", "*pycache*", "*/node_modules/*" }
-- Cool floating window popup menu for completion on command line
opt.pumblend = 10
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true --  unless there is a capital letter in the query

opt.hidden = true -- I like having buffers stay around
opt.cursorline = true -- Highlight the current line
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
opt.signcolumn = 'yes' -- Display signs in the number column
opt.laststatus = 3   -- Global statusline
--tabs
-- opt.autoindent = true
-- opt.cindent = true
-- opt.wrap = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- opt.breakindent = true
-- opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
-- opt.linebreak = true

--folds
opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1
opt.mouse = "a"    -- try n
opt.belloff = "all" -- Just turn the dang bell off
opt.clipboard = "unnamedplus"
opt.inccommand = "split"

-- file management
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.undofile    = true  -- ok use undo
opt.undolevels  = 5000  -- with lots of undolevels
opt.undoreload  = 10000 -- and reloads
opt.lazyredraw     = true
opt.autoread = true
opt.autowrite = true --autowrite buffer when it's not focused
opt.backup = false       -- nope
opt.writebackup = false  -- nope
opt.swapfile = false     -- nope
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done
-- set fillchars=eob:~
-- opt.fillchars = { eob = "~" }
opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})



-- can be overidden with buffer-local options
opt.grepformat  = "%f:%l:%c:%m"
opt.grepprg     = 'rg --hidden --vimgrep --smart-case --'
opt.shell = "/usr/bin/bash"
  -- formatprg = 'prettier --stdin-filepath=%'

--[[
SetGlobalOptions({
  -- guifont     = 'BlexMono Nerd Font';

  hidden = true; -- keep hidden buffers I think this is default
  showtabline = 1;
  showmatch = true;
  clipboard = "unnamed";
  sidescroll  = 2;
  sidescrolloff  = 15;
})

SetOptions({ -- file management

})
SetOptions({
  number = true;
  relativenumber = true;
  showmode = false;
  pumblend = 10;
  -- splits
  splitbelow = true;
  splitright = true;
  shortmess  = vim.o.shortmess .. 'cI'; -- No startup screen, no ins-completion-menu messages
})
SetOptions({
  mouse = 'a';
  cursorline = true;
  wrap = false;
  expandtab = true;     -- Insert 2 spaces for a tab
  tabstop = 2;          -- Change the number of space characters inserted for indentation
  shiftwidth = 2;       -- Converts tabs to spaces
  --  search behaviour
  incsearch   = true;
  inccommand  = 'split'; -- show replacements
  timeoutlen   = 400; -- faster timeout wait time
  updatetime  = 1000; -- trigger CursorHold after 1 sec
  list = true;
  linebreak = true;
  breakindent = true;
})
  --foldmethod     = "expr";
  --foldexpr     = "nvim_treesitter#foldexpr()";

})
--]]
