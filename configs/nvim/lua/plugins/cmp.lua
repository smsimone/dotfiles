return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",

	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		appearance = {
			nerd_font_variant = 'mono',
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
			cmdline = {}
		},
		fuzzy = {
			use_proximity = true,
			use_typo_resistance = true,
		},
		signature = { enabled = true },
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
					default_brackets = { '(', ')', '{', '}', '[', ']' },
				}
			},
		},
		keymap = {
			['<tab>'] = { 'select_next', 'fallback' },
			['<S-tab>'] = { 'select_prev', 'fallback' },
			['<cr>'] = { 'accept', 'fallback' },
		}
	},
	opts_extend = { 'sources.default' }
}
