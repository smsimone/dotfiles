local wezterm = require('wezterm')
local config = wezterm.config_builder()

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find 'Dark' then
		return 'catppuccin-mocha'
	else
		return 'catppuccin-latte'
	end
end

config.font = wezterm.font 'Iosevka Nerd Font'
config.window_decorations = "RESIZE"
config.color_scheme = scheme_for_appearance(get_appearance())

return config
