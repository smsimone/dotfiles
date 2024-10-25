local wezterm  = require('wezterm')
local config   = wezterm.config_builder()
local opacity  = 0.96
local features = require('theme-switch')



-- Font
config.font                         = wezterm.font_with_fallback({
	-- { family = 'Iosevka Nerd Font', weight = "Medium" },
	{ family = 'JetBrainsMonoNL Nerd Font Mono' },
	-- { family = 'CaskaydiaMono Nerd Font' },
	-- { family = 'MonispaceNe Nerd Font', weight = "Medium" },
	"Segoe UI Emoji",
})
config.font_size                    = 11.2
config.line_height                  = 1.2

-- Window
config.initial_rows                 = 24
config.initial_cols                 = 100
config.window_decorations           = "RESIZE"
config.window_background_opacity    = opacity
config.window_close_confirmation    = "NeverPrompt"
config.win32_system_backdrop        = "Acrylic"
config.max_fps                      = 60
config.animation_fps                = 60
config.cursor_blink_rate            = 250

-- Colors
config.color_scheme                 = "rose-pine-moon"
config.force_reverse_video_cursor   = true

-- Tabs
config.enable_tab_bar               = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar    = true
config.use_fancy_tab_bar            = false


config.keys = {
	{
		key = 'k',
		mods = 'CMD',
		action = wezterm.action_callback(function(window, pane)
			features.theme_switcher(window, pane)
		end)
	},
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

wezterm.on('user-var-changed', function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while (number_value > 0) do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
