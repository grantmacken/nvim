--[[
When the Nvim LSP client starts it enables diagnostics @see './diagnostic.lua'
LSP DEFAULTS:
NOTE: do not overide by duplicating in lsp attach
- 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger completion.
- 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
  go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|,
  |CTRL-W_}| to utilize the language server.
- 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via |gq| if the language server supports it.
- To opt out of this use |gw| instead of gq, or clear 'formatexpr' on |LspAttach|.
- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or a custom keymap for `K` exists.

 --Some keymaps are created unconditionally when Nvim starts:
 --NOTE: do not overide
- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()

Not all language servers provide the same capabilities. 
Use capability checks to ensure you only use features supported by the language server.
:lua =vim.lsp.get_clients()[1].server_capabilities
Not all language servers provide the same capabilities. Use
capability checks to ensure you only use features supported by the language
server.
]]--
 vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- if client.supports_method('textDocument/implementation') then
        --   -- Create a keymap for vim.lsp.buf.implementation
        -- end

        if client.supports_method('textDocument/completion') then
          -- Enable auto-completion
          vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
        end

        if client.supports_method('textDocument/formatting') then
          -- Format the current buffer on save
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({bufnr = args.buf, id = client.id})
            end,
          })
        end
      end,
    })

vim.api.nvim_create_autocmd('LspDetach', {
      callback = function(args)
        -- Get the detaching client
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Remove the autocommand to format the buffer on save, if it exists
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({
            event = 'BufWritePre',
            buffer = args.buf,
          })
        end
      end,
    })
--[[
LspNotify                                                          *LspNotify*
    This event is triggered after each successful notification sent to an
    LSP server.

 vim.api.nvim_create_autocmd('LspNotify', {
      callback = function(args)
        local bufnr = args.buf
        local client_id = args.data.client_id
        local method = args.data.method
        local params = args.data.params

        -- do something with the notification
        if method == 'textDocument/...' then
          update_buffer(bufnr)
        end
      end,
    })

see also
LspProgress

LspRequest
LspTokenUpdate
]]--

