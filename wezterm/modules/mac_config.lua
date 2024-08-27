local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font 'IosevkaTerm NFM'
  config.font_size = 18
  config.default_prog = { 'zsh', '--login' }
end

return module
