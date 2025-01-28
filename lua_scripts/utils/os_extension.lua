local M = {}

--- @param workdir string Directory in which the command should be run
--- @param command string Command to execute
--- @return string the command result
function M.execute(workdir, command)
    local f = assert(io.popen("cd " .. workdir .. " && " .. command, "r"))
    local s = assert(f:read("*a"))
    f:close()
    return s
end

return M
