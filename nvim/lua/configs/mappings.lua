local wk = require("which-key")

-- LSP configurations
wk.register({
    l = {
        name = "Lsp",
        s = { "<cmd>FzfLua lsp_document_symbols<cr>", "Find document symbols" },
        S = { "<cmd>FzfLua lsp_workspace_symbols<cr>", "Find workspace symbols" },
        a = { "<cmd>FzfLua lsp_code_actions<cr>", "Code actions" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
        D = { "<cmd>FzfLua lsp_workspace_diagnostics<cr>", "Toggle trouble" },
        c = {
            name = "Method calls",
            i = { "<cmd>FzfLua lsp_incoming_calls<cr>", "Incoming calls" },
            o = { "<cmd>FzfLua lsp_outgoing_calls<cr>", "Outgoing calls" },
        }
    },

    -- Files config
    f = {
        name = "Files",
        e = { function() MiniFiles.open() end, "Explorer" },
        f = { "<cmd>FzfLua files<cr>", "Find files" },
        w = { "<cmd>FzfLua live_grep_native<cr>", "Find with grep" },
        b = { "<cmd>FzfLua buffeFzfLua buffersrs<cr>", "Select buffer from opens" },
    },

    w = { "<cmd>silent w<cr>", "Save file" },
    q = { "<cmd>confirm quit<cr>", "Quit buffer" },
    u = { "<cmd>UndotreeToggle<cr>", "Toggle undotree" },

    -- Plugin management
    p = {
        name = "Plugin management",
        i = {
            function()
                require("lazy").install()
            end,
            "Install",
        },
        s = {
            function()
                require("lazy").sync()
            end,
            "Sync",
        },
        u = {
            function()
                require("lazy").update()
            end,
            "Update",
        },
        m = {
            name = "Mason",
            u = { "<cmd>MasonUpdate<cr>", "Update" },
        },
    },

    -- Buffer configs
    b = {
        name = "Buffer mappings",
        V = { "<cmd>vsplit<cr>", "VSplit" },
        S = { "<cmd>split<cr>", "HSplit" },
    },

    -- Terminal config
    t = {
        name = "Terminal",
        f = { "<cmd>ToggleTerm direction=float<cr>", "Floating" },
        h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal terminal" },
        v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical terminal" },
    },

    -- Git configs
    g = {
        name = "Git",
        f = { "<cmd>FzfLua git_files<cr>", "Find file" },
        u = { "<cmd>LazyGit<cr>", "Open LazyGit UI" },
    },

    -- Debugger configs
    d = {
        name = "Debugger",
        b = {
            function()
                require("dap").toggle_breakpoint()
            end,
            "Toggle breakpoint",
        },
        c = {
            function()
                require("dap").continue()
            end,
            "Continue/Start",
        },
        T = {
            function()
                require("dapui").toggle({})
            end,
            "Toggle dapUI",
        },

        t = {
            function()
                require("dap").terminate()
            end,
            "Terminate",
        },
        s = {
            o = {
                function()
                    require("dap").step_over()
                end,
                "Step over",
            },
            i = {
                function()
                    require("dap").step_into()
                end,
                "Step into",
            },
        },
    },
}, { prefix = "<leader>" })

vim.keymap.set("n", "<C-h>", function()
    require("smart-splits").move_cursor_left()
end)
vim.keymap.set("n", "<C-j>", function()
    require("smart-splits").move_cursor_down()
end)
vim.keymap.set("n", "<C-k>", function()
    require("smart-splits").move_cursor_up()
end)
vim.keymap.set("n", "<C-l>", function()
    require("smart-splits").move_cursor_right()
end)
vim.keymap.set("n", "<C-Up>", function()
    require("smart-splits").resize_up()
end)
vim.keymap.set("n", "<C-Down>", function()
    require("smart-splits").resize_down()
end)
vim.keymap.set("n", "<C-Left>", function()
    require("smart-splits").resize_left()
end)
vim.keymap.set("n", "<C-Right>", function()
    require("smart-splits").resize_right()
end)

vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>")
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>")
vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>")
