return {
	"rcarriga/nvim-dap-ui",
	module = "dap-install",
	dependencies = {
		"mfussenegger/nvim-dap",
		"mxsdev/nvim-dap-vscode-js",
	},
	config = function()
		local dap = require("dap")

		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
			debugger_cmd = { "js-debug-adapter" },
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					name = "Launch",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					name = "Attach to node process",
					type = "pwa-node",
					request = "attach",
					rootPath = "${workspaceFolder}",
					processId = require("dap.utils").pick_process,
				},
				{
					name = "Debug Main Process (Electron)",
					type = "pwa-node",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/electron",
					args = {
						"${workspaceFolder}/dist/index.js",
					},
					outFiles = {
						"${workspaceFolder}/dist/*.js",
					},
					resolveSourceMapLocations = {
						"${workspaceFolder}/dist/**/*.js",
						"${workspaceFolder}/dist/*.js",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
			}
		end
	end,
}
