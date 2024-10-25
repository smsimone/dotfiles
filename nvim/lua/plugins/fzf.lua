return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			files = { cmd = 'fd' },
			live_grep = { cmd = "git grep --line-number --column --color=always" },
		})
	end
}
