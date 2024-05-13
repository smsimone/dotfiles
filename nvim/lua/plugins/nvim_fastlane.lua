return {
    dir = "/Users/simonemasoero/Development/nvim_fastlane",
    name = "nvim_fastlane",
    config = function()
        require("nvim_fastlane").setup {
            name = "cicio"
        }
    end
}
