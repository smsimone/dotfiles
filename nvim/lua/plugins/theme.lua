return {
	"scottmckendry/cyberdream.nvim",
	config = function()
		require("cyberdream").setup({
			transparent = true,
			italic_comments = true,
			cache = true,
			extensions = {
				lazy = true,
				mini = true,
				notify = true,
				noice = true,
				gitsigns = true,
				cmp = true,
				treesitter = true,
				fzflua = true,
			},
		})
	end
}
