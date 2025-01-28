local files = require('utils.file')
local os_ext = require('utils.os_extension')

--- @param project_folder string
--- @return integer
local function main(project_folder)
	local is_directory = assert(files.isdir(project_folder))
	if not is_directory then return 1 end

	local current_branch = os_ext.execute(project_folder, "git branch")
	if string.find(current_branch, "no branch") then
		print(project_folder .. " -> not connected to a branch")
		return 1
	end

	local result = os_ext.execute(project_folder, "git pull | head -1")
	result = result:gsub("\n", "")
	print(project_folder .. " -> " .. result)

	return 0
end

main(arg[1])
