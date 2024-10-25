local Path = require('plenary.path')

local dir = Path:new("~/Development/todolist/")
if dir:exists() and dir:is_dir() then
	return {
		dir = "~/Development/todolist/",
		name = "todolist",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require('todolist').setup({
				completed_symbol = '❎'
			})
		end
	}
end

return {
	"smsimone/todolist.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require('todolist').setup({
			completed_symbol = '❎'
		})
	end
}
