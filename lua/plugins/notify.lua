
local miniNotify = require('mini.notify')
miniNotify.setup({
  window = { config = { border = 'double' } },
})
vim.notify = miniNotify.make_notify()
-- local filterout_lua_diagnosing = function(notif_arr)
--   local not_this_filter = function(notif)
--     return not vim.endswith(notif.msg, 'for more information')
--   end
--   notif_arr = vim.tbl_filter(not_this_filter, notif_arr)
--   --TODO
--   return miniNotify.default_sort(notif_arr)
-- end

--content = { sort = filterout_lua_diagnosing },



