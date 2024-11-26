local miniIcons = require('mini.icons')
miniIcons.setup({
  use_file_extension = function(ext, _)
    local suf3, suf4 = ext:sub(-3), ext:sub(-4)
    return suf3 ~= 'scm' and suf3 ~= 'txt' and suf3 ~= 'yml' and suf4 ~= 'json' and suf4 ~= 'yaml'
  end,
})
miniIcons.mock_nvim_web_devicons()
--miniIcons.tweak_lsp_kind()
require('mini.icons').tweak_lsp_kind()


