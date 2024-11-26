
local plugins = {
  'icons',
  -- 'notify',
  'clue',
  --  'care',
 -- 'noice',
  --'conform',
  --'copilot',
  -- 'flash',
  'oil',
  --'quicker',
  'toggleterm',
}

for _, plugin in ipairs(plugins) do
  require( 'plugins.' .. plugin)
end
