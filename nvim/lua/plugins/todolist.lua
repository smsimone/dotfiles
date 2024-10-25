local Path = require('plenary.path')

--- @type configs
local confs = {
	item_symbols = {
		completed = '❎',
		todo = '❌',
	},
	reorder_elements = true,
	text_ellipsis = '..',
}

local dir = Path:new("/Users/simonemasoero/Development/todolist")
if dir:exists() and dir:is_dir() then
	return {
		dir = "~/Development/todolist/",
		name = "todolist",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim"
		},
		config = function()
			require('todolist').setup(confs)
		end
	}
end

return {
	"smsimone/todolist.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim"
	},
	config = function()
		require('todolist').setup(confs)
	end
}
