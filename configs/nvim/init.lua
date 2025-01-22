vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

--- Executes the given command and returns its result
--- @param cmd string
--- @return string
local function execute(cmd)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	return s
end

--- Returns the theme based on current system brightness
--- @return string
local function get_theme()
	-- if the current theme is light, this snippet does not return anything
	if execute("defaults read -g AppleInterfaceStyle 2>&1 | tr -d '\n'") == 'Dark' then
		return 'catppuccin-mocha'
	else
		return 'catppuccin-latte'
	end
end

local term_program = execute("echo $TERM_PROGRAM | tr -d '\n'")

if term_program == 'Apple_Terminal' then
	vim.cmd.colorscheme('wildcharm')
elseif term_program == 'ghostty' or term_program == 'tmux' then
	vim.cmd.colorscheme(get_theme())
else
	vim.cmd.colorscheme("catppuccin-mocha")
end

require("configurations/configurations")
require("configurations/mappings")
require("configurations/autocmds")
