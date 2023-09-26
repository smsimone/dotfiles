local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner'
      }
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['nf'] = '@function.outer',
        ['nc'] = '@class.outer'
      },
      goto_next_end = {
        ['nF'] = '@function.outer',
        ['nC'] = '@class.outer'
      },
      goto_previous_start = {
        ['Nf'] = '@function.outer',
        ['Nc'] = '@class.outer'
      },
      goto_previous_end = {
        ['NF'] = '@function.outer',
        ['NC'] = '@class.outer'
      }
    }
  }
}
