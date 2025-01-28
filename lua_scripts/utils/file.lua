local M = {}

--- @param file string
--- @return boolean, string?
function M.exists(file)
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
function M.isdir(file)
    return M.exists(file .. "/")
end

return M
