return {
	"nvim-flutter/flutter-tools.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim"
	},
	config = function()
		require('flutter-tools').setup({
			flutter_path = "/Users/simonemasoero/fvm/default/bin/flutter"
		})
	end
}
