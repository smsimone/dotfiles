return {
    "neovim/nvim-lspconfig",
    dependencies = {
        --{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
        -- { "folke/neodev.nvim", opts = {} },
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup({})
            end,
        },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },
}
