return {
	"rose-pine/neovim",
	--name = "rose-pine-moon"
	config = function()
		require('rose-pine').setup({
			variant = "auto",
			dark_variant = 'moon',
			dim_inactive_windows = true,
			extend_background_behind_borders = true,
			enable = {
				terminal = true,
				legacy_highlights = true,
				migrations = true,
			},
			styles = { bold = true, italic = true, transparency = true }
		})
	end
}

--return {
--
--	"scottmckendry/cyberdream.nvim",
--	config = function()
--		require("cyberdream").setup({
--			transparent = true,
--			italic_comments = true,
--			cache = true,
--			extensions = {
--				lazy = true,
--				mini = true,
--				notify = true,
--				noice = true,
--				gitsigns = true,
--				cmp = true,
--				treesitter = true,
--				fzflua = true,
--			},
--		})
--	end
--}
