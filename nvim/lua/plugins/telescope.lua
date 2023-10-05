local telescope = require("telescope")

telescope.setup({
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
})

telescope.load_extension("notify")
