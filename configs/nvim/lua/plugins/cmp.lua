--vim.api.nvim_create_autocmd('LspAttach', {
--	callback = function(ev)
--		local client = vim.lsp.get_client_by_id(ev.data.client_id)
--		if client and client:supports_method('textDocument/completion') then
--			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--		end
--	end
--})
--return {}

return {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.compat", "rafamadriz/friendly-snippets", },
	version = "*",
	opts_extend = { 'sources.default', "sources.completion.enabled_providers" },

	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		cmdline = { enabled = false },
		appearance = { nerd_font_variant = 'mono' },
		sources = {
			-- default = { 'lsp', 'path', 'snippets', 'buffer' },
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"obsidian",
				"obsidian_new",
				"obsidian_tags",
			},
			providers = {
				obsidian = {
					name = "obsidian",
					module = "blink.compat.source",
				},
				obsidian_new = {
					name = "obsidian_new",
					module = "blink.compat.source",
				},
				obsidian_tags = {
					name = "obsidian_tags",
					module = "blink.compat.source",
				},
			},
		},
		fuzzy = { use_proximity = true },
		signature = { enabled = true },
		completion = {
			accept = {
				auto_brackets = {
					enabled = false,
					default_brackets = { '(', ')', '{', '}', '[', ']' },
				}
			},
		},
		keymap = {
			['<tab>'] = { 'select_next', 'fallback' },
			['<S-tab>'] = { 'select_prev', 'fallback' },
			['<cr>'] = { 'accept', 'fallback' },
		}
	}
}
