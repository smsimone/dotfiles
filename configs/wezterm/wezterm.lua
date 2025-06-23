local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function scheme_for_appearance(appearance)
	print("appearance: " .. appearance)
	if appearance:find "Dark" then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end


config.font = wezterm.font_with_fallback({
	-- { family = "MonaspiceNE Nerd Font", weight = "Regular" },
	{ family = "Maple Mono NF", weight = "Regular" },
	"Segoe UI Emoji", -- emoji font
})
config.font_size = 13
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.force_reverse_video_cursor = true

-- Window configuration
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"

-- Performance settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = true
config.use_fancy_tab_bar = false

-- Keybindings
local act = wezterm.action
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "l", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "j", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = 'l', mods = 'CTRL',   action = act.ActivatePaneDirection 'Right' },
	{ key = 'h', mods = 'CTRL',   action = act.ActivatePaneDirection 'Left' },
	{ key = 'k', mods = 'CTRL',   action = act.ActivatePaneDirection 'Up' },
	{ key = 'j', mods = 'CTRL',   action = act.ActivatePaneDirection 'Down' },
}

return config
