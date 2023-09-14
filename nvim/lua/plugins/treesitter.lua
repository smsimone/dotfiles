local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true
  },
})
