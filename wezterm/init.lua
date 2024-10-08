local wezterm = require 'wezterm'


local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  require('win_config').apply_to_config(config)
elseif wezterm.target_triple == 'x86_64-apple-darwin' or wezterm.target_triple == 'aarch64-apple-darwin' then
  require('mac_config').apply_to_config(config)
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  require('tux_config').apply_to_config(config)
end

config.color_scheme = 'Catppuccin Frappe'
config.use_fancy_tab_bar = false
config.tab_max_width = 99
config.hide_tab_bar_if_only_one_tab = true

return config
