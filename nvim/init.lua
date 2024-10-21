vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup(
--- @type LazyConfig
	{
		spec = {
			{ import = "plugins" },
		},
		checker = {
			enabled = true,
			concurrency = 8,
			notify = false
		},
		ui = {
			icons = {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				require = "🌙",
				source = "📄",
				start = "🚀",
				task = "📌",
				lazy = "💤 ",
			},
		},
	})

--- @return string
local function get_colorscheme()
	local interfaceStyle = io.popen("defaults read -g AppleInterfaceStyle | tr -d '\\n'"):read("*a")
	if interfaceStyle == 'Dark' then
		return 'catppuccin-mocha'
	else
		return 'catppuccin-latte'
	end
end

vim.cmd.colorscheme(get_colorscheme())

require("configurations/configurations")
require("configurations/mappings")
