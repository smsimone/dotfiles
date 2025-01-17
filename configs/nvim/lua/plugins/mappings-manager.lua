return {
	"echasnovski/mini.clue",
	version = "*",
	config = function()
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },
			},
			clues = {
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
			window = {
				delay = 300,
			},
		})
	end
}
