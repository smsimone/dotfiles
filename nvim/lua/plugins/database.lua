return {
	'tpope/vim-dadbod',
	event = "VeryLazy",
	dependencies = {
		'kristijanhusak/vim-dadbod-ui',
		{
			'kristijanhusak/vim-dadbod-completion',
			ft = { 'plsql' },
			lazy = true
		},
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	config = function()
		-- require("config.dadbod").setup()
	end,
}
