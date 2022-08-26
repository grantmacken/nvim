
--[[
vim.api.nvim_create_autocmd( 'filetype', {
 pattern = 'xquery',
 callback = function()
    local data = {
      buf = vim.fn.expand('<abuf>'),
      file = vim.fn.expand('<afile>'),
      match = vim.fn.expand('<amatch>'),
    }
    vim.schedule(function()
      --print( 'XQUERY' )
      -- print( vim.inspect(data))
      end
    )
  end,
  group = 'xqerl_group'
} )
--]]

vim.api.nvim_create_autocmd( 'BufWritePost', {
  group = vim.api.nvim_create_augroup( 'xqerl_group', {clear = true}),
  pattern = {'*.xqm', '*.xq'},
  callback = function()
    --vim.cmd([[ compiler  xqerlCompiler ]])
    local ns = vim.api.nvim_create_namespace('xqerlCompiler')
    local window = vim.api.nvim_get_current_win()
    local buffer = vim.api.nvim_win_get_buf(window)
    local bufferName =  vim.api.nvim_buf_get_name( buffer )
    local sTitle = 'xqerl compiler [' .. buffer .. '] ' .. bufferName
    -- local fileName = vim.fn.expand('<afile>')
    -- local qfTitle = { title =  sTitle }
  -- create a new quickfix list
    vim.api.nvim_call_function('setqflist',{{},' ',{ title =  sTitle}})
    vim.opt_local.makeprg = 'make code'
    vim.opt_local.errorformat = '%f:%l:%trror: %m'
    local makePrg = vim.api.nvim_buf_get_option(0, 'makeprg')
    local efm = vim.api.nvim_buf_get_option(0, 'errorformat')
    local on_event = function(_, data, event)
      if event == "stdout" then
        if data then
         local items =  vim.fn.getqflist({
            ['lines'] =  data,
            ['efm'] = efm,
          }).items
          --print(vim.inspect(items))
          for i, item in ipairs(items) do
            if item.type == 'E' then
               vim.api.nvim_command('silent! caddexpr "' .. data[i] .. '"')
            end
          end
        end
      end
      if event == "exit" then
      local diagnostics = vim.diagnostic.fromqflist(vim.fn.getqflist())
      vim.diagnostic.set(ns, 0, diagnostics, {})
      end
    end
    vim.fn.jobstart( makePrg  ,
      {
        --stdout_buffered = true,
        on_stdout = on_event,
        --on_stderr = on_event,
        on_exit =  on_event,
      }
    )
  end,
}
)

