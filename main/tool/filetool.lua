local filetool = {}

filetool.systemType = SystemType.mac

local function getWindowsPath(path)
	return string.gsub(path, '/', '\\')
end

function filetool.rmDir(dir)
    local cmd = ''
    if filetool.systemType == SystemType.mac then
        cmd = 'rm -d -f -R ' .. dir
    elseif filetool.systemType == SystemType.windows then
		dir = getWindowsPath(dir)
        cmd = 'rmdir /S /Q ' .. dir
    end

    filetool.execute(cmd)
end

function filetool.mkDir(dir)
    local cmd = ''
    if filetool.systemType == SystemType.mac then
        cmd = 'mkdir -p ' .. dir
    elseif filetool.systemType == SystemType.windows then
		dir = getWindowsPath(dir)
        cmd = 'mkdir ' .. dir
    end

    filetool.execute(cmd)
end

function filetool.copy(source, target)
    local cmd = ''
    if filetool.systemType == SystemType.mac then
        cmd = 'cp -r ' .. source .. ' ' .. target
    elseif filetool.systemType == SystemType.windows then
		source = getWindowsPath(source)
		target = getWindowsPath(target)
        cmd = 'xcopy /Y /S ' .. source .. ' ' .. target
    end

    filetool.execute(cmd)    
end

function filetool.execute(info)
	if os.execute(info .. ' >> sdktool.log 2>&1') == 0 then
		print("error: execute " .. info .. " failed!")
	end
end

return filetool