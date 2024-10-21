local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.font = wezterm.font 'Iosevka Nerd Font'
config.window_decorations = "RESIZE"
config.color_scheme = "catppuccin-mocha"

return config
