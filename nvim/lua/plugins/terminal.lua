return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	config = true,
	setup = function()
		require("toggleterm").setup(
		--- @type ToggleTermConfig
			{
				-- size can be a number or function which is passed the current terminal
				--- @param term Terminal
				size = function(term)
					if term.direction == "horizontal" then
						return 10
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.7
					end
				end,
				float_ops = {
					border = "curved",
					title_post = "left"
				},
			})
	end
}
