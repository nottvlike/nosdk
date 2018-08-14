SystemType = {
	mac = 1,
	windows = 2
}

local system = {}

function system.getSystemType()
	local result = ''
	local cmd = 'uname -s'
	if system.execute(cmd .. ' >> sdktool.log 2>&1') then
		local handle = io.popen(cmd)
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

function system.log(info)
	print(info)
end

function system.execute(cmd)
	if not os.execute(cmd .. ' >> sdktool.log 2>&1') then
		print("error: execute " .. cmd .. " failed!")
		return false
	end
	
	return true
end

return system