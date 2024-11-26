
M = {}
--[[ h: lsp-defaults
NOTE: do not overide

- 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger
  completion.
- 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
  go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|,
  |CTRL-W_}| to utilize the language server.
- 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via
  |gq| if the language server supports it.
  - To opt out of this use |gw| instead of gq, or clear 'formatexpr' on |LspAttach|.
- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or a custom keymap for `K` exists.


--Some keymaps are created unconditionally when Nvim starts:
-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
--
]]--
--
-- Keywords LSP as keywordprg
-- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or a custom keymap for `K` exists.
-- keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('lsp: signature help'))
-- GOTOs Declaration Definition Implementation References
--  gr
--  gd  default keymap.set('n', 'gd', vim.lsp.buf.definition, desc('lsp: go to [d]efinition'))
--keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('lsp: go to [D]eclaration'))
--keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('LSP: go to [i]mplementation'))
-- GOTO References
-- "gr" is mapped in Normal mode to vim.lsp.buf.references() gr-default
-- GOTO Definitions as tagfunc
-- "gd" is mapped to vim.lsp.buf.definition
-- -- 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like go-to-definition, |:tjump|,
-- and keymaps like |CTRL-]|, |CTRL-W_]|,|CTRL-W_}| to utilize the language server
-- keymap.set('n', 'gr', vim.lsp.buf.references, desc('lsp: [g]et [r]eferences'))
-- keymap.set('n', '<leader>gi', go_to_first_import, desc('lsp: [g]o to fist [i]mport'))
-- Signature Help
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()

local lspMappings = function(bufnr)
  local nmap_leader = function(suffix, rhs, description )
    local opts = { noremap = true, silent = true, buffer = bufnr}
    opts.desc = description
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
  end

-- Workspace Folders
nmap_leader('wa', vim.lsp.buf.add_workspace_folder, 'LSP: [w]orkspace folder [a]dd')
nmap_leader('wr', vim.lsp.buf.remove_workspace_folder, 'LSP: [w]orkspace folder [r]emove')
nmap_leader('wl', function() vim.print(vim.lsp.buf.list_workspace_folders()) end, 'lsp: [w]orkspace folders [l]')
nmap_leader('wq', vim.lsp.buf.workspace_symbol, 'LSP: [w]orkspace symbol [q]uery')
end

M.attached = function(client, bufnr)
 vim.api.nvim_buf_set_var(bufnr, 'lsp_client_id', client.id)
 vim.cmd.setlocal('signcolumn=yes')
  -- Enable omnifunc-completion
 vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
 vim.bo[bufnr].bufhidden = 'hide'
  -- log('Lang Server attached buffer: ' .. bufnr)
  lspMappings(bufnr)
end

return M
