local cmp = require('cmp')
vim.opt.pumheight = 15
vim.opt.completeopt = 'menuone,noselect'

cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				rg = '[Rg]',
				buffer = '[Buffer]',
				nvim_lsp = '[LSP]',
				vsnip = '[Snippet]',
				tags = '[Tag]',
				path = '[Path]',
				orgmode = '[Org]',
				['vim-dadbod-completion'] = '[DB]',
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'buffer' },
		{ name = 'tags',    keyword_length = 2 },
		{ name = 'rg',      keyword_length = 3 },
		{ name = 'path' },
		{ name = 'orgmode' },
	},
	window = {
		documentation = {
			border = 'rounded',
		},
	},
})

local autocomplete_group = vim.api.nvim_create_augroup('vimrc_autocompletion', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'sql', 'mysql', 'plsql' },
	callback = function()
		cmp.setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
	end,
	group = autocomplete_group,
})

vim.opt.wildignore = {
	'*.o',
	'*.obj,*~',
	'*.git*',
	'*.meteor*',
	'*vim/backups*',
	'*sass-cache*',
	'*mypy_cache*',
	'*__pycache__*',
	'*cache*',
	'*logs*',
	'*node_modules*',
	'**/node_modules/**',
	'*DS_Store*',
	'*.gem',
	'log/**',
	'tmp/**',
}
