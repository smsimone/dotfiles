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
	local os_name = io.popen("uname"):read("*a")
	if not os_name:find("Darwin") then
		return 'cyberdream'
	end

	local interfaceStyle = io.popen("2>&1 defaults read -g AppleInterfaceStyle | tr -d '\\n'"):read("*a")
	if interfaceStyle == 'Dark' then
		return 'cyberdream'
	else
		return 'cyberdream'
	end
end

vim.cmd.colorscheme("cyberdream")

require("configurations/configurations")
require("configurations/mappings")
