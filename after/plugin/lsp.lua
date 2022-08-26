
-- to debug
vim.lsp.set_log_level("info")
--vim.lsp.set_log_level("debug")
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Don't show the dumb matching stuff.
vim.opt.pumheight = 5

vim.opt.shortmess:append 'c'
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

--   פּ ﯟ   some other good icons
--
--

--
-- local kinds = vim.lsp.protocol.CompletionItemKind
-- for i, kind in ipairs(kinds) do
--   kinds[i] = icons[kind] or kind
-- end

-- local function lsp_highlight_document(client)
--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec(
--       [[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end

-- LSP mappings as per https://github.com/neovim/nvim-lspconfig
local function lsp_buffer_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true }
  local km = vim.api.nvim_buf_set_keymap
  km(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
  km(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
  km(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
  km(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
  km(bufnr, 'n', '<A-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)
  km(bufnr, 'n', '<space>wa', '<cmd>vim.lsp.buf.add_workspace_folder<CR>', bufopts)
  km(bufnr, 'n', '<space>wr', '<cmd>vim.lsp.buf.remove_workspace_folder<CR>', bufopts)
  --km(bufnr, 'n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  km(bufnr, 'n', '<space>D', '<cmd>vim.lsp.buf.type_definition<CR>', bufopts)
  km(bufnr, 'n', '<space>rn', '<cmd>vim.lsp.buf.rename<CR>', bufopts)
  km(bufnr, 'n', '<space>ca', '<cmd>vim.lsp.buf.code_action<CR>', bufopts)
  km(bufnr, 'n', 'gr', '<cmd>vim.lsp.buf.references<CR>', bufopts)
  km(bufnr, 'n', '<space>f', '<cmd>vim.lsp.buf.formatting<CR>', bufopts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  km(bufnr, 'n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', bufopts)
  --vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end
local on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  lsp_buffer_keymaps(bufnr)
  -- lsp_highlight_document(client)
end



-- https://github.com/hrsh7th/vscode-langservers-extracted
-- vscode-html-language-server
-- vscode-css-language-server
-- vscode-json-language-server
-- vscode-eslint-language-server

-- Enable the following language servers
--
--
-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local util = require('lspconfig.util')

lspconfig['xqueryls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

local servers = { 'bashls', 'cssls', 'html', 'jsonls', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


lspconfig['yamlls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  schemas = {
    ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
  },
}
lspconfig['erlangls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'podman', 'run', '--interactive', '--rm', 'ghcr.io/grantmacken/erlang_ls:v25.0.1' },
}

-- local server = "sumneko_lua"
lspconfig['sumneko_lua'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'podman', 'run', '--interactive', '--rm', 'ghcr.io/grantmacken/lua-language-server:v2.6.0' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
  return
end

local kind_icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
      })[entry.source.name]
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.expand_or_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  window = {
    documentation = {
      border = 'rounded',
    },
  },
  sources = {
    { name = 'nvim_lsp'},
    { name = 'luasnip', keyword_length = 3 },
    { name = 'path' },
  },
}

-- {name = 'nvim_lsp', keyword_length = 3},
-- {name = 'buffer', keyword_length = 3},
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   }),
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }
--
-- vim.api.nvim_create_autocmd({ 'TextChangedI', 'TextChangedP' }, {
--   callback = function()
--     local line = vim.api.nvim_get_current_line()
--     local cursor = vim.api.nvim_win_get_cursor(0)[2]
--
--     local current = string.sub(line, cursor, cursor + 1)
--     if current == '.' or current == ',' or current == ' ' then
--       require('cmp').close()
--     end
--
--     local before_line = string.sub(line, 1, cursor + 1)
--     local after_line = string.sub(line, cursor + 1, -1)
--     if not string.match(before_line, '^%s+$') then
--       if after_line == '' or string.match(before_line, ' $') or string.match(before_line, '%.$') then
--         require('cmp').complete()
--       end
--     end
--   end,
--   pattern = '*',
-- })
