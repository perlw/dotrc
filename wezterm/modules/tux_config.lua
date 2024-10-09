local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font 'IosevkaTerm NFM'
  config.font_size = 14
  config.default_prog = { '/usr/bin/zsh', '-l' }
  config.send_composed_key_when_left_alt_is_pressed = true
end

return module
