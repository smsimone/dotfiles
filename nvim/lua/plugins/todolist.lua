local Path = require('plenary.path')

local dir_path = Path:new("/Users/simonemasoero/Development/todolist.nvim")

local configs = {}

if dir_path:exists() and dir_path:is_dir() then
	return {
		dir = "~/Development/todolist.nvim",
		name = "todolist",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require('todolist').setup(configs)
		end
	}
else
	return {
		"smsimone/todolist.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require('todolist').setup(configs)
		end
	}
end
