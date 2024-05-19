return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    enabled = false,
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        { "gi", vim.NIL },
        { "gd", vim.NIL },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
        })
    end,
}
