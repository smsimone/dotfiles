-- File with all things related to auto complete (excluding the LSP server stuff itself)

local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 25

return {
	{
		"benlubas/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			vim.api.nvim_set_hl(0, "CmpItemAbbr", {})
			local cmp = require("cmp")

			local keys = {
				["<C-Space>"] = cmp.mapping.complete(),
				["<tab>"] = cmp.mapping.select_next_item(),
				["<S-tab>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-q>"] = cmp.mapping.close(),
				["<cr>"] = cmp.mapping.confirm({ select = true }),
			}

			cmp.setup({
				completion = {
					keyword_length = 1,
				},
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = {
						winhighlight = winhighlight,
						col_offset = -2,
					},
					documentation = {
						winhighlight = winhighlight,
					},
				},
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				mapping = keys,
				formatting = {
					expandable_indicator = true,
					number_options = { start_index = 0, end_index = 0 },
					fields = { "abbr", "kind" },
					format = function(entry, vim_item)
						local label = vim_item.abbr
						local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
						if truncated_label ~= label then
							vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
						end
						return vim_item
					end,
				},
				-- Installed sources
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "git" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require("luasnip")
			ls.setup({
				link_children = true,
				link_roots = false,
				keep_roots = false,
				update_events = { "TextChanged", "TextChangedI" },
			})
			local c = ls.choice_node
			ls.choice_node = function(pos, choices, opts)
				P(opts)
				if opts then
					opts.restore_cursor = true
				else
					opts = { restore_cursor = true }
				end
				return c(pos, choices, opts)
			end

			vim.cmd.runtime({ args = { "lua/snippets/*.lua" }, bang = true }) -- load custom snippets
		end,
	},
	{
		"windwp/nvim-autopairs",
		dependencies = {
			"benlubas/nvim-cmp",
		},
		config = function()
			require("nvim-autopairs").setup({
				-- map_bs = false,
				check_ts = true,
				fast_wrap = {
					map = "<A-e>",
					chars = { "{", "[", "(", '"', "'", "`" },
					pattern = [=[[%'%"%>%]%)%}%,]]=],
					end_key = "$",
					cursor_pos_before = true,
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					manual_position = false,
				},
			})
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
