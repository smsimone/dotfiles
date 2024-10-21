local M = {}

--- @param str string
--- @param prefix string
--- @param ignore_case boolean
--- @return boolean
function M.starts_with(str, prefix, ignore_case)
	if ignore_case then
		str = str.lower(str)
		prefix = str.lower(prefix)
	end

	return str.sub(1, #prefix) == prefix
end

--- @param str string
--- @param suffix string
--- @param ignore_case boolean
--- @return boolean
function M.ends_with(str, suffix, ignore_case)
	if ignore_case then
		str = str.lower(str)
		suffix = str.lower(suffix)
	end

	return suffix == "" or str.sub(#suffix, #str) == suffix
end

return M
