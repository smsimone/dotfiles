return {
    "akinsho/toggleterm.nvim",
    config = true,
    setup = function()
        require("toggleterm").setup({
            -- size can be a number or function which is passed the current terminal
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
            }
        })
    end
}
