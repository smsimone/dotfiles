local wk = require 'which-key'

-- LSP configurations
wk.register(
  {
    l = {
      name = "Lsp",
      f = { "<cmd>LspZeroFormat<cr>", "Format file" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Find document symbols" },
      S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Find workspace symbols" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
      d = { "", "Line error" },
      D = { "<cmd>Telescope diagnostics<cr>", "Project diagnostics" }
    },

    -- Files config
    f = {
      name = "Files",
      e = { "<cmd>Oil<cr>", "Explorer" },
      f = { "<cmd>Telescope find_files<cr>", "Find files" },
      w = { "<cmd>Telescope live_grep<cr>", "Find with grep" },
    },
    w = { "<cmd>w<cr>", "Save file" },
    q = { "<cmd>confirm quit<cr>", "Quit buffer" },
    u = { "<cmd>UndotreeToggle<cr>", "Toggle undotree" },
    T = { "<cmd>Telescope<cr>", "Open telescope" },

    -- Plugin management
    p = {
      name = 'Plugin management',
      i = { function() require('lazy').install() end, "Install" },
      s = { function() require("lazy").sync() end, "Sync" },
      u = { function() require('lazy').update() end, "Update" },
      m = {
        name = "Mason",
        u = { "<cmd>MasonUpdate<cr>", "Update" }
      }
    },

    -- Buffer configs
    b = {
      name = "Buffer mappings",
      c = { "<cmd>bufdo close<cr>", "Close buffer" },
      V = { "<cmd>vsplit<cr>", "VSplit" },
      S = { "<cmd>split<cr>", "HSplit" },
      b = { "<cmd>BufferLinePick<cr>", "Select buffer from opens" },
      d = { "<cmd>BufferLinePickClose<cr>", "Pick buffer to close" },
    },

    -- Terminal config
    t = {
      name = "Terminal",
      f = { "<cmd>ToggleTerm direction=float<cr>", "Floating" },
      h = { "<cmd>ToggleTerm direction=horizontal size=20<cr>", "Horizontal terminal" },
    },
    g = {
      name = "Git",
      f = { "<cmd>Telescope git_files<cr>", "Find file" }
    },

    -- Debugger configs
    d = {
      name = "Debugger",
      b = { function() require('dap').toggle_breakpoint() end, "Toggle breakpoint" },
      c = { function() require('dap').continue() end, "Continue/Start" },
    }
  },
  { prefix = "<leader>" }
)
