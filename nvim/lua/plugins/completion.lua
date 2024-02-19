return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "neovim/nvim-lspconfig",
            opts = {
                inline_hints = { enabled = true },
                servers = {
                    jdtls = {
                        cmd = {
                            "jdtls",
                            "--jvm-arg=" ..
                            string.format("-javaagent:%s",
                                vim.fn.expand("/Users/simonemasoero/.local/share/nvim/mason/packages/jdtls/lombok.jar"))
                        }
                    }
                }
            }
        },
        "onsails/lspkind.nvim",
        {
            "L3MON4D3/LuaSnip",
            --version = "2.*",
            build = "make install_jsregexp",
        },
    },
    config = function()
        --
        -- Set up nvim-cmp.
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol",
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = 'luasnip' },
            }, {
                { name = "buffer" },
            }),
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = "buffer" },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        -- Set up lspconfig.
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local navic = require("nvim-navic")

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        navic.attach(client, bufnr)
                    end
                })
            end,
        })
    end,
}
