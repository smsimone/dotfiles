return {
	"nvim-flutter/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim"
	},
	config = function()
		local flutter_path = vim.fn.expand('$HOME/fvm/default/bin/flutter')
		require('flutter-tools').setup({ flutter_path = flutter_path })
	end
}
