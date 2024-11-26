-- h vim.diagnostic.config()
--
--
--  `false`: Disable this feature
--  `true`: Enable this feature, use default settings.
--  `table`: Enable this feature with overrides. Use an empty table to use
--     default values.
--  `function`: Function with signature (namespace, bufnr) that returns any
--     of the above.
local opts = {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
  float = true,
}

-- global diagnostic config
vim.diagnostic.config(opts)

-- NOTE
-- BRACKETS
-- ]d-default| and |[d-default| accept a count.
-- [D-default| and |]D-default| jump to the first and last diagnostic in the current buffer
--
