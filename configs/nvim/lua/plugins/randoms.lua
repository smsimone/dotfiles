return {
	-- syntax highlighting
	{
		event = "VeryLazy",
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
				ensure_installed = {
					"go"
				},
				sync_install = true,
				ignore_install = {},
				modules = {},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
	},

	-- time tracking
	{
		"wakatime/vim-wakatime",
		lazy = false,
		enabled = false
	},


	-- code formatting
	{
		'stevearc/conform.nvim',
		event = "VeryLazy",
		config = function()
			require("conform").setup({
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_fallback = true }
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
					if args.bang then
						-- FormatDisable will disable formatting just for this buffer
						vim.b.disable_autoformat = true
					else
						vim.g.disable_autoformat = true
					end
				end,
				{ desc = "Disable autoformat-on-save", bang = true }
			)

			vim.api.nvim_create_user_command("FormatEnable", function()
					vim.b.disable_autoformat = false
					vim.g.disable_autoformat = false
				end,
				{ desc = "Re-enable autoformat-on-save" }
			)
		end
	},

	-- smart splits
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
	}
}
