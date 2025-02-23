return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",

	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		cmdline = { enabled = false },
		appearance = { nerd_font_variant = 'mono' },
		sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
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
	},
	opts_extend = { 'sources.default' }
}
