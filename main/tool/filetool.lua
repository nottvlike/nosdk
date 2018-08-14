local systemtool = require 'tool.systemtool'

local systemType = systemtool.getSystemType()

local function getWindowsPath(path)
	return string.gsub(path, '/', '\\')
end

local filetool = {}

function filetool.rmDir(dir)
    local cmd = ''
    if systemType == SystemType.mac then
        cmd = 'rm -d -f -R ' .. dir
    elseif systemType == SystemType.windows then
		dir = getWindowsPath(dir)
        cmd = 'rmdir /S /Q ' .. dir
    end

    systemtool.execute(cmd)
end

function filetool.mkDir(dir)
    local cmd = ''
    if systemType == SystemType.mac then
        cmd = 'mkdir -p ' .. dir
    elseif systemType == SystemType.windows then
		dir = getWindowsPath(dir)
        cmd = 'mkdir ' .. dir
    end

    systemtool.execute(cmd)
end

function filetool.copy(source, target)
    local cmd = ''
    if systemType == SystemType.mac then
        cmd = 'cp -r ' .. source .. ' ' .. target
    elseif systemType == SystemType.windows then
		source = getWindowsPath(source)
		target = getWindowsPath(target)
        cmd = 'xcopy /Y /S ' .. source .. ' ' .. target
    end

    systemtool.execute(cmd)    
end

return filetool