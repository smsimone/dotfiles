return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"chrisgrieser/nvim-puppeteer",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "python", "javascript", "typescript" },
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			-- default configuration
			require("illuminate").configure({
				-- providers: provider used to get references in the buffer, ordered by priority
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				-- delay: delay in milliseconds
				delay = 100,
				-- filetype_overrides: filetype specific overrides.
				-- The keys are strings to represent the filetype while the values are tables that
				-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
				filetype_overrides = {},
				-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
				filetypes_denylist = {
					"dirvish",
					"fugitive",
				},
				-- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
				filetypes_allowlist = {},
				-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
				-- See `:help mode()` for possible values
				modes_denylist = {},
				-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
				-- See `:help mode()` for possible values
				modes_allowlist = {},
				-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_denylist = {},
				-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_allowlist = {},
				-- under_cursor: whether or not to illuminate under the cursor
				under_cursor = true,
				-- large_file_cutoff: number of lines at which to use large_file_config
				-- The `under_cursor` option is disabled when this cutoff is hit
				large_file_cutoff = nil,
				-- large_file_config: config to use for large files (based on large_file_cutoff).
				-- Supports the same keys passed to .configure
				-- If nil, vim-illuminate will be disabled for large files.
				large_file_overrides = nil,
				-- min_count_to_highlight: minimum number of matches required to perform highlighting
				min_count_to_highlight = 1,
				-- should_enable: a callback that overrides all other settings to
				-- enable/disable illumination. This will be called a lot so don't do
				-- anything expensive in it.
				should_enable = function(bufnr)
					return true
				end,
				-- case_insensitive_regex: sets regex case sensitivity
				case_insensitive_regex = false,
			})
		end,
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = {
					plugins = {
						"nvim-dap-ui",
					},
					types = true,
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
				},
			})
		end,
	},
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{ "SmiteshP/nvim-navic" },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{ "mrjones2014/smart-splits.nvim" },
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
}
