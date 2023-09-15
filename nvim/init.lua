vim.g.mapleader = " "
vim.g.maplocalleader = " "

require 'plugins/lazy'
require 'lazy'.setup('plugins/lazy_plugins', {})

require 'plugins/completion'
require 'plugins/dap'
require 'plugins/lazy'
require 'plugins/lazy_plugins'
require 'plugins/lsp'
require 'plugins/nvim-cmp'
require 'plugins/telescope'
require 'plugins/treesitter'

require 'configs/mappings'
require 'configs/configurations'
