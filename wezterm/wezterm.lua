local wezterm = require('wezterm')
local config = wezterm.config_builder()
local opacity = 0.92
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"


--- @return string
local function scheme_for_appearance()
	local function get_appearance()
		if wezterm.gui then
			return wezterm.gui.get_appearance()
		end
		return "Dark"
	end

	if get_appearance():find 'Dark' then
		-- return 'catppuccin-mocha'
		return 'theme'
	else
		-- return 'catppuccin-latte'
		return 'theme-light'
	end
end

-- Font
config.font = wezterm.font_with_fallback({
	{ family = 'Iosevka Nerd Font', weight = "Medium" },
	-- "Segoe UI Emoji",
})
config.font_size = 12

-- Window
config.initial_rows = 24
config.initial_cols = 100
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"
config.max_fps = 60
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Colors
config.colors = require(scheme_for_appearance())
config.color_scheme = scheme_for_appearance()
config.force_reverse_video_cursor = true

-- Tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = transparent_bg,
	new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
	new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = config.colors.brights[1]
	local foreground = config.colors.foreground

	if tab.is_active then
		background = config.colors.brights[7]
		foreground = config.colors.background
	elseif hover then
		background = config.colors.brights[8]
		foreground = config.colors.background
	end

	local title = tostring(tab.tab_index + 1)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)


return config
