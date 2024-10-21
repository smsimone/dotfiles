return {
	'saghen/blink.cmp',
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source
	dependencies = 'rafamadriz/friendly-snippets',

	-- use a release tag to download pre-built binaries
	version = 'v0.*',
	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			providers = {
				{ "blink.cmp.sources.lsp", name = "LSP", score_offset = 1, },
				{
					"blink.cmp.sources.snippets",
					name = "Snippets",
					-- keyword_length = 1, -- not supported yet
				},
				{
					"blink.cmp.sources.path",
					name = "Path",
					score_offset = 3,
					opts = { get_cwd = vim.uv.cwd },
				},
				{
					"blink.cmp.sources.buffer",
					name = "Buffer",
					keyword_length = 3,
					score_offset = -1,
					fallback_for = { "Path" }, -- PENDING https://github.com/Saghen/blink.cmp/issues/122
				},
			},
		},
		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
		},
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = 'normal',

		-- experimental auto-brackets support
		-- accept = { auto_brackets = { enabled = true } }

		-- experimental signature help support
		-- trigger = { signature_help = { enabled = true } }
	}
}

