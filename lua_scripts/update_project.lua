--- @param file string
--- @return boolean, string?
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- permission denied
			return true
		end
	end
	return ok, err
end

--- @param file string
--- @return boolean, string?
local function isdir(file)
	return exists(file .. "/")
end

--- @param workdir string Directory in which the command should be run
--- @param command string Command to execute
--- @return string the command result
local function execute(workdir, command)
	local f = assert(io.popen("cd " .. workdir .. " && " .. command, "r"))
	local s = assert(f:read("*a"))
	f:close()
	return s
end


--- @param project_folder string
--- @return integer
local function main(project_folder)
	local is_directory = assert(isdir(project_folder))
	if not is_directory then return 1 end

	local current_branch = execute(project_folder, "git branch")
	if string.find(current_branch, "no branch") then
		return 1
	end

	local result = execute(project_folder, "git pull | head -1")
	result = result:gsub("\n", "")
	print(project_folder .. " -> " .. result)

	return 0
end

if #arg ~= 1 then
	print("missing argument")
	return 1
end

main(arg[1])
