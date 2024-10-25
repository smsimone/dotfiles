return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff' },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { 'datetime' },
				lualine_z = { 'location' }
			},
			inactive_sections = {},
			tabline = {},
			winbar = {
				lualine_a = { "filename" }
			},
			inactive_winbar = {
				lualine_a = { "filename" }
			},
			extensions = {}
		}
	end
}
