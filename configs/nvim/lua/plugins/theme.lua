--return {
--	"rose-pine/neovim",
--	config = function()
--		require('rose-pine').setup({
--			variant = "auto",
--			dark_variant = 'moon',
--			extend_background_behind_borders = true,
--			enable = {
--				terminal = true,
--				legacy_highlights = true,
--				migrations = true,
--			},
--			styles = { bold = true, italic = true, transparency = true }
--		})
--	end
--}
--
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		"rjshkhr/shadow.nvim",
	},
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.zenbones_darken_comments = 45
			vim.g.zenbones_compat = 1
			-- vim.cmd.colorscheme('zenbones')
		end
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				-- optional configuration here
			})
		end
	},
}
