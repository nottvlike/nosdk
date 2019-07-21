require 'mxml'

local function praseXml(tree, tt)
	local current = mxml.elementFirstChild(tree)
	while(current ~= nil) 
	do
		if mxml.elementType(current) == 0 then
			local name = mxml.elementName(current)
			if tt[name] == nil then
				tt[name] = {}
			end

			local curTable = {}
			local count = mxml.elementAttrCount(current)
			for i = 0,count - 1,1 do
				curTable[mxml.elementAttrName(current, i)] = mxml.elementAttrValue(current, i)
			end

			table.insert(tt[name], curTable)
			praseXml(current, curTable)
		end

		current = mxml.elementNextChild(current)
	end
end

local tree = mxml.loadFile("test.xml")
local tt = {}
praseXml(tree, tt)