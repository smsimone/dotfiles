return {
	"ThePrimeagen/git-worktree.nvim",
	config = function()
		local Worktree = require("git-worktree")
		Worktree.setup({})

		Worktree.on_tree_change(function(op, meta)
			if op == Worktree.Operations.Switch then
				print("Switched from " .. meta.prev_path .. " to " .. meta.path)
			end
		end)

		require("telescope").load_extension("git_worktree")
	end,
}
