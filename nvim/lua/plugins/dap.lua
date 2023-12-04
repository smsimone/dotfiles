return {
	"rcarriga/nvim-dap-ui",
	module = "dap-install",
	enabled = true,
	dependencies = {
		"mfussenegger/nvim-dap",
		"leoluz/nvim-dap-go",
	},
	config = function()
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})

		require("dapui").setup()
	end,
}
