-- return {
-- 	"stevearc/oil.nvim",
-- 	dependencies = "nvim-tree/nvim-web-devicons",
-- 	config = function()
-- 		require("oil").setup({
-- 			view_options = {
-- 				show_hidden = true,
-- 				is_hidden_file = function(name, _)
-- 					return vim.startswith(name, ".")
-- 				end,
-- 			},
-- 		})
-- 	end,
-- }
return {
	"echasnovski/mini.nvim",
	version = false,
	enabled = false,
	config = function()
		require("mini.files").setup()
	end,
}
