return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "neovim/nvim-lspconfig",
            opts = {
                -- disabled because it generates an error:
                --
                -- [lspconfig] Cannot access configuration for inline_hints. Ensure this server is listed in `server_configurations.md` or added as a custom server.
                -- [lspconfig] Cannot access configuration for servers. Ensure this server is listed in `server_configurations.md` or added as a custom server.
                -- inline_hints = { enabled = false },
                servers = {
                    jdtls = {
                        cmd = {
                            "jdtls",
                            "--jvm-arg=" ..
                            string.format("-javaagent:%s",
                                vim.fn.expand(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar"))
                        }
                    },
                }
            },
            config = function(_, servers)
                for server, opts in pairs(servers) do
                    require('lspconfig')[server].setup(opts)
                end
            end
        },
        "onsails/lspkind.nvim",
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
        },
    },
    config = function()
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
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        elseif require("luasnip").expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                        else
                            fallback()
                        end
                    end, { "i", "s" }
                ),
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
            ["gopls"] = function()
                require 'lspconfig'.gopls.setup({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        navic.attach(client, bufnr)
                    end,
                    settings = { -- custom settings for gopls
                        gopls = {
                            gofumpt = false,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                fieldalignment = true,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            semanticTokens = true,
                        },
                    },
                })
            end
        })
    end,
}
