vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')
lazy.setup('plugins/lazy', {})

require 'plugins/completion'
require 'plugins/dap'
require 'plugins/lsp'
require 'plugins/nvim-cmp'
require 'plugins/telescope'
require 'plugins/terminal'
require 'plugins/treesitter'

require 'configs/mappings'
require 'configs/configurations'

require('dap.ext.vscode').load_launchjs()
