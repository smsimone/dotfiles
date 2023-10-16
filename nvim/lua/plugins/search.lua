return {
	"backdround/improved-search.nvim",
	config = function()
		local search = require("improved-search")

		-- Search next / previous.
		vim.keymap.set({ "n", "x", "o" }, "n", search.stable_next)
		vim.keymap.set({ "n", "x", "o" }, "N", search.stable_previous)

		-- Search selected text in visual mode
		vim.keymap.set("x", "*", search.forward) -- search selection forward
		vim.keymap.set("x", "#", search.backward) -- search selection backward
	end,
}
