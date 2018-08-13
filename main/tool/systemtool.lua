SystemType = {
	mac = 1,
	windows = 2
}

local system = {}

function system.getSystemType()
	local result = ''
	local handle = io.popen('uname -s')
	if handle ~= nil then
		result = handle:read('*a')
		handle:close()
	else
		result = os.getenv('OS')
	end

	if result == 'Darwin' then
		return SystemType.mac
	elseif string.match(result,"Windows") then
		return SystemType.windows
	else
		return SystemType.mac
	end
end

return system