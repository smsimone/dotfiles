--- @class CommandMapping
--- @field command string | function
--- @field desc string?
--- @field leader string?

--- @class CommandConfig
--- @field [string] CommandMapping[] | CommandConfig[]

--- @param cmd string
--- @return string
local function sanitize_command(cmd)
	if string.lower(cmd:sub(1, #'<cmd>')) ~= '<cmd>' then
		cmd = '<cmd>' .. cmd
	end

	if string.lower(cmd:sub(- #'<cr>')) ~= '<cr>' then
		cmd = cmd .. '<cr>'
	end
	return cmd
end

--- @param config CommandConfig
--- @return string?
local function get_desc(config)
	if config[2] ~= nil then return config[2] end
	return config.desc
end

--- @param mode string
--- @param keystroke string
--- @param command string | function
--- @param desc string?
local function add_mapping(mode, keystroke, command, desc)
	--- @param cmd string | function
	--- @return string
	local function get_as_command(cmd)
		if type(cmd) == 'string' then return sanitize_command(cmd) end
		return ""
	end

	--- @param cmd string | function
	--- @return function?
	local function get_as_callback(cmd)
		if type(cmd) == 'function' then return cmd end
		return nil
	end

	vim.keymap.set(mode, keystroke, get_as_command(command), {
		noremap = true,
		desc = desc,
		callback = get_as_callback(command)
	})
end

--- @param map CommandMapping | CommandConfig
--- @return boolean
local function is_mapping(map)
	local command_defined = map[1] ~= nil or map.command ~= nil
	return type(map) == 'table' and command_defined
end

--- @param mode string
--- @param config CommandMapping[] | CommandConfig[]
--- @param base_command string
local function apply_configs(mode, config, base_command)
	for key, subconfig in pairs(config) do
		local command = base_command .. key
		if is_mapping(subconfig) then
			if subconfig.leader ~= nil then
				command = command:gsub("<leader>", subconfig.leader)
			end
			add_mapping(mode, command, subconfig[1], get_desc(subconfig))
		else
			apply_configs(mode, subconfig, command)
		end
	end
end

local M = {};

--- @param maps CommandConfig
function M.setup(maps)
	for mode, config in pairs(maps) do
		apply_configs(mode, config, "<leader>")
	end
end

return M
