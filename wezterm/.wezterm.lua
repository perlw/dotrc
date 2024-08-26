local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'IosevkaTerm NFM'
config.font_size = 14
config.color_scheme = 'Catppuccin Frappe'
config.default_prog = { 'pwsh.exe' }

return config
