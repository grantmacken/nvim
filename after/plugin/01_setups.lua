
local mini_plugs = {
  'statusline',
  'tabline',
  'align',
  'bufremove',
  'cursorword',
  'indentscope',
  'splitjoin',
  'surround',
  'trailspace',
}
for _, plugin in ipairs( mini_plugs ) do
  require( 'mini.' .. plugin).setup()
end

-- plugins that require a setup function
-- but I don't alter the options
-- NOTE: set keymaps in /after/plugin dir
local default_setups = {
  'flash',
}

for _, plugin in ipairs( default_setups ) do
  require(plugin).setup()
end

-- other setup function options for plugins
require('plugins')
