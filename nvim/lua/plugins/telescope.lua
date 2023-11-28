return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	event = "VeryLazy",
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

		--telescope.load_extension("notify")
	end,
}
