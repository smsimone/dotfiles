return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	tag = "0.1.3",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})

		telescope.load_extension("notify")
	end,
}
