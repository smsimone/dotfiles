local register = require("utilities.mappings_register")

register.setup({
	n = {
		w = { "<cmd>w<cr>", desc = "Save current buffer" },
		W = { "<cmd>wall<cr>", desc = "Save all buffers" },
		q = { function() vim.cmd [[confirm quit]] end, desc = "Closes current buffer" },
		Q = { "qall", desc = "Quit all buffers" },
		b = {
			V = { "vsplit", desc = "Split buffer vertically" },
			S = { "split", desc = "Split buffer horizontally" },
		},
		f = {
			f = { "FzfLua files", desc = "Find files" },
			b = { "FzfLua buffers", desc = "Find buffers" },
			d = { "FzfLua diagnostics_workspace", desc = "Find diagnostics" },
			w = { "FzfLua live_grep", desc = "Find words" },
			l = { "FzfLua", desc = "FzfLua" }
		},
		g = {
			r = { "FzfLua lsp_references", desc = "Find references", leader = "" },
			d = { "FzfLua lsp_definitions", desc = "Find definitions", leader = "" },
			i = { "FzfLua lsp_implementations", desc = "Find implementation", leader = "" },
			u = { "LazyGit", desc = "Open lazygit" },
		},
		p = {
			i = { "Lazy install", desc = "Install lazy packages" },
			u = { "Lazy update", desc = "Update lazy packages" }
		},
		M = { "Mason", desc = "Open mason" },

		t = {
			f = { "<cmd>ToggleTerm direction=float name=terminal<cr>", desc = "Floating" },
			h = { "<cmd>ToggleTerm direction=horizontal name=terminal<cr>", desc = "Horizontal terminal" },
			v = { "<cmd>ToggleTerm direction=vertical name=terminal<cr>", desc = "Vertical terminal" },
			s = { "<cmd>TodoShow<cr>", desc = "Show todos" },
			a = { "<cmd>TodoAdd<cr>", desc = "Add new todo" },
		},
		l = {
			i = { "LspInfo", desc = "Lsp info" },
			s = { "FzfLua lsp_document_symbols", desc = "Document symbols" },
			S = { "FzfLua lsp_workspace_symbols", desc = "Document symbols" },
			a = { "FzfLua lsp_code_actions", desc = "Lsp code actions" },
		},
		D = {
			t = { "DBUIToggle", desc = "Toggle DBUI" }
		},
	},
})

vim.keymap.set("n", "<C-h>", function() require("smart-splits").move_cursor_left() end)
vim.keymap.set("n", "<C-j>", function() require("smart-splits").move_cursor_down() end)
vim.keymap.set("n", "<C-k>", function() require("smart-splits").move_cursor_up() end)
vim.keymap.set("n", "<C-l>", function() require("smart-splits").move_cursor_right() end)
vim.keymap.set("n", "<M-k>", function() require("smart-splits").resize_up() end)
vim.keymap.set("n", "<M-j>", function() require("smart-splits").resize_down() end)
vim.keymap.set("n", "<M-h>", function() require("smart-splits").resize_left() end)
vim.keymap.set("n", "<M-l>", function() require("smart-splits").resize_right() end)
