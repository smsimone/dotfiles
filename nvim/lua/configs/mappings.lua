local wk = require("which-key")

-- LSP configurations
wk.register({
	l = {
		name = "Lsp",
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Find document symbols" },
		S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Find workspace symbols" },
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
		d = { "<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<cr>", "Get line diagnostic" },
		D = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
	},

	-- Harpoon config
	h = {
		name = "Harpoon",
		a = {
			function()
				require("harpoon.mark").add_file()
			end,
			"Add file to harpoon",
		},
		s = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			"Select file",
		},
	},

	-- Files config
	f = {
		name = "Files",
		e = { "<cmd>Oil<cr>", "Explorer" },
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		w = { "<cmd>Telescope live_grep<cr>", "Find with grep" },
		b = {
			function()
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				local opts = {
					previewer = false,
					results_height = 15,
				}
				opts.attach_mappings = function(prompt_bufnr, map)
					local delete_buf = function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						vim.api.nvim_buf_delete(selection.bufnr, { force = true })
					end
					map("i", "<c-d>", delete_buf)
					return true
				end
				opts.previewer = false

				require("telescope.builtin").buffers(require("telescope.themes").get_dropdown(opts))
			end,
			"Select buffer from opens",
		},
	},

	w = { "<cmd>silent w<cr>", "Save file" },
	q = { "<cmd>confirm quit<cr>", "Quit buffer" },
	u = { "<cmd>UndotreeToggle<cr>", "Toggle undotree" },

	-- Plugin management
	p = {
		name = "Plugin management",
		i = {
			function()
				require("lazy").install()
			end,
			"Install",
		},
		s = {
			function()
				require("lazy").sync()
			end,
			"Sync",
		},
		u = {
			function()
				require("lazy").update()
			end,
			"Update",
		},
		m = {
			name = "Mason",
			u = { "<cmd>MasonUpdate<cr>", "Update" },
		},
	},

	-- Buffer configs
	b = {
		name = "Buffer mappings",
		c = { "<cmd>BufferClose<cr>", "Close buffer" },
		V = { "<cmd>vsplit<cr>", "VSplit" },
		S = { "<cmd>split<cr>", "HSplit" },
	},

	-- Terminal config
	t = {
		name = "Terminal",
		f = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"Floating",
		},
		h = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"Horizontal terminal",
		},
		v = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"Vertical terminal",
		},
	},

	-- Git configs
	g = {
		name = "Git",
		f = { "<cmd>Telescope git_files<cr>", "Find file" },
		u = { "<cmd>LazyGit<cr>", "Open LazyGit UI" },
	},

	-- Debugger configs
	d = {
		name = "Debugger",
		b = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		c = {
			function()
				require("dap").continue()
			end,
			"Continue/Start",
		},
		T = {
			function()
				require("dapui").toggle({})
			end,
			"Toggle dapUI",
		},

		t = {
			function()
				require("dap").terminate()
			end,
			"Terminate",
		},
		s = {
			o = {
				function()
					require("dap").step_over()
				end,
				"Step over",
			},
			i = {
				function()
					require("dap").step_into()
				end,
				"Step into",
			},
		},
	},
}, { prefix = "<leader>" })

vim.keymap.set("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end)
vim.keymap.set("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end)
vim.keymap.set("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end)
vim.keymap.set("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end)
vim.keymap.set("n", "<C-Up>", function()
	require("smart-splits").resize_up()
end)
vim.keymap.set("n", "<C-Down>", function()
	require("smart-splits").resize_down()
end)
vim.keymap.set("n", "<C-Left>", function()
	require("smart-splits").resize_left()
end)
vim.keymap.set("n", "<C-Right>", function()
	require("smart-splits").resize_right()
end)

vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
