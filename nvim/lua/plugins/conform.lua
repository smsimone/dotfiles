return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			-- Map of filetype to formatters
			formatters_by_ft = {
				lua = { "stylua" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				rust = { "rustfmt" },
				shell = { "shellcheck", "beautysh", "gosh" },
				swift = { "swiftformat" },
				bash = { "beautysh", "gosh" },
				toml = { "taplo" },

				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			-- If this is set, Conform will run the formatter on save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_fallback = true,
				timeout_ms = 500,
			},
			-- If this is set, Conform will run the formatter asynchronously after save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_after_save = {
				lsp_fallback = true,
			},
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,
			-- Conform will notify you when a formatter errors
			notify_on_error = true,
		})

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
