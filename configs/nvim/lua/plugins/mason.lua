function lsp_binary_exists(server_config)
	local valid_config = server_config.document_config and
	    server_config.document_config.default_config and
	    type(server_config.document_config.default_config.cmd) == "table" and
	    #server_config.document_config.default_config.cmd >= 1

	if not valid_config then
		return false
	end

	local binary = server_config.document_config.default_config.cmd[1]

	return vim.fn.executable(binary) == 1
end

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		init = function()
			-- so mason packages are available before loading mason itself
			vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
		end,
		opts = {
			PATH = "skip", -- since already adding to PATH above
			ui = {
				border = vim.g.borderStyle,
				height = 0.85,
				width = 0.8,
				icons = {
					package_installed = "✓",
					package_pending = "󰔟",
					package_uninstalled = "✗",
				},
				keymaps = { -- consistent with keymaps for lazy.nvim
					uninstall_package = "x",
					toggle_help = "?",
					toggle_package_expand = "<Tab>",
				},
			},
		},
	},
	{ -- auto-install lsps & formatters
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		config = function()
			local packages = require("configurations.lsp-servers").masonDependencies()
			-- assert(#packages > 10, "Warning: in mason config, many packages would be uninstalled.")

			-- FIX manually running `MasonToolsUpdate`, since `run_on_start` does
			-- not work with lazy-loading.
			require("mason-tool-installer").setup { ensure_installed = packages }
			vim.defer_fn(vim.cmd.MasonToolsInstall, 500)
			vim.defer_fn(vim.cmd.MasonToolsUpdate, 5000)
			vim.defer_fn(vim.cmd.MasonToolsClean, 8000)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("neodev").setup({})
			require("lspconfig.ui.windows").default_options.border = vim.g.borderStyle

			-- Enable completion (nvim-cmp/blink.cmp) and folding (nvim-ufo)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.foldingRange =
			{ dynamicRegistration = false, lineFoldingOnly = true }

			local lspConfigs = require("configurations.lsp-servers")
			local myServerConfigs = lspConfigs.serverConfigs

			local lspconfig = require('lspconfig')

			for lsp, config in pairs(myServerConfigs) do
				if lspConfigs.is_enabled(lsp) then
					-- need to check for setup because some of
					-- lsp configurations exist but have no setup (i.e. are deprecated)
					if lsp_binary_exists(lspconfig[lsp]) then
						config.capabilities = capabilities
						lspconfig[lsp].setup(config)
					end
				end
			end
		end,
		dependencies = {
			"folke/neodev.nvim",
		}
	},
}
