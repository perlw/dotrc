local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font 'IosevkaTerm NFM'
  config.font_size = 16
  config.default_prog = { 'zsh', '--login' }
  config.send_composed_key_when_left_alt_is_pressed = true
end

return module
