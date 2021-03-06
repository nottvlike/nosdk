require 'mxml'
local systemtool = require 'tool.systemtool'

local xmltool = {}
local template = {
	head = "<?xml version=\"1.0\" encoding=\"utf-8\"?>",
	manifest = {
		{
			["uses-sdk"] = {},
			["uses-configuration"] = {},
			["uses-feature"] = {},
			["uses-permission"] = {},
			permission = {},
			["permission-tree"] = {},
			["permission-group"] = {},
			instrumentation = {},
			["supports-screens"] = {},
			["compatible-screens"] = {},
			["supports-gl-texture"] = {},
			application = {
				{
					activity = {
						{
							["intent-filter"] = {
								{
									action = {},
									category = {},
									data = {}
								}
							},
							["meta-data"] = {}
						}
					},
					["activity-alias"] = {
						{
							["intent-filter"] = {
								{
									action = {},
									category = {},
									data = {}
								}
							},
							["meta-data"] = {}
						}
					},
					service = {
						{
							["intent-filter"] = {
								{
									action = {},
									category = {},
									data = {}
								}
							},
							["meta-data"] = {}
						}
					},
					receiver = {
						{
							["intent-filter"] = {
								{
									action = {},
									category = {},
									data = {}
								}
							},
							["meta-data"] = {}
						}
					},
					provider = {
						{
							["grant-uri-permission"] = {},
							["meta-data"] = {},
							["path-permission"] = {}
						}
					},
					["uses-library"] = {},
					["meta-data"] = {}
				}
			}
		}
	}
}

local addEvent = {}

local addType1 = function(element, parent, sub1, sub1sub1, sub1sub2, sub1sbu3, sub2, newElement, keyName)
	if not newElement[element] then
		return
	end

	for i,v in pairs(newElement[element]) do
		if type(v) == 'table' and v[keyName] then
			local isNew = true
			for m,n in pairs(parent[element]) do
				if type(n) == 'table' and n[keyName] and n[keyName] == v[keyName] then
					isNew = false
				end
			end

			if isNew then
				local newV = {}
				for m,n in pairs(v) do
					if type(m) == 'string' and type(n) == 'string' then
						newV[m] = n
					end
				end

				if v[sub1] and #v[sub1] > 0 then
					local intent = v[sub1][1]
					if (intent[sub1sub1] and #intent[sub1sub1]) or (intent[sub1sub2] and #intent[sub1sub2] > 0) or (intent[sub1sbu3] and #intent[sub1sbu3] > 0) then
						newV[sub1] = {}
						newV[sub1][1] = {}

						if intent[sub1sub1] and #intent[sub1sub1] > 0 then
							addEvent[sub1sub1](newV[sub1][1], intent)
						end

						if intent[sub1sub2] and #intent[sub1sub2] > 0 then
							addEvent[sub1sub2](newV[sub1][1], intent)
						end

						if intent[sub1sbu3] and #intent[sub1sbu3] > 0 then
							addEvent[sub1sbu3](newV[sub1][1], intent)
						end
					end
				end

				if v[sub2] and #v[sub2] > 0 then
					addEvent[sub2](newV, v)
				end

				table.insert(parent[element], newV)
			end
		end
	end
end

local addType2 = function(element, parent, newElement, keyName)
	if not newElement[element] then
		return
	end

	if parent and not parent[element] then
		parent[element] = {}
	end

	for i,v in pairs(newElement[element]) do
		if type(v) == 'table' then
			local isNew = true
			for m,n in pairs(parent[element]) do
				if type(n) == 'table' and (n[keyName] and v[keyName] and n[keyName] == v[keyName]) then
					isNew = false
				elseif type(n) == 'table' and (not n[keyName] or not v[keyName]) then
					for j,k in pairs(v) do
						if n[j] and n[j] == k then
							isNew = false
						end
					end
 				end
			end

			if isNew then
				local newV = {}
				for m,n in pairs(v) do
					newV[m] = n
				end

				table.insert(parent[element], newV)
			end
		end
	end
end

local addType3 = function(element, parent, newElement)
	if not newElement or not newElement[element] or not newElement[element][1] then
		return
	end

	if not parent[element] then
		parent[element] = {}
	end

	if not parent[element][1] then
		parent[element][1] = {}
	end

	for i,v in pairs(newElement[element][1]) do
		if type(i) == 'string' and type(v) == 'string' then
			local isNew = true
			for m,n in pairs(parent[element][1]) do
				if type(m) == 'string' and type(n) == 'string' and i == m then
					isNew = false
				end
			end

			if isNew then
				parent[element][1][i] = v
			end
		end
	end
end

local addType4 = function(element, parent, sub1, sub2, sub3, newElement, keyName)
	if not newElement[element] then
		return
	end

	for i,v in pairs(newElement[element]) do
		if type(v) == 'table' and v[keyName] then
			local isNew = true
			for m,n in pairs(parent[element]) do
				if type(n) == 'table' and n[keyName] and n[keyName] == v[keyName] then
					isNew = false
				end
			end

			if isNew then
				local newV = {}
				for m,n in pairs(v) do
					if type(m) == 'string' and type(n) == 'string' then
						newV[m] = n
					end
				end

				if v[sub1] and #v[sub1] > 0 then
					addEvent[sub1](newV, v)
				end

				if v[sub2] and #v[sub2] > 0 then
					addEvent[sub2](newV, v)
				end

				if v[sub3] and #v[sub3] > 0 then
					addEvent[sub3](newV, v)
				end

				table.insert(parent[element], newV)
			end
		end
	end
end

addEvent = {
	["uses-sdk"] = function(parent, newElement)
		addType3("uses-sdk", parent, newElement)
	end,
	["uses-configuration"] = function(parent, newElement)
		addType3("uses-configuration", parent, newElement)
	end,
	["uses-feature"] = function(parent, newElement)
		addType2("uses-feature", parent, newElement, 'android:name')
	end,
	["uses-permission"] = function(parent, newElement)
		addType2("uses-permission", parent, newElement, 'android:name')
	end,
	permission = function(parent, newElement)
		addType2("permission", parent, newElement, 'android:name')
	end,
	["permission-tree"] = function()
		systemtool.log("add permission-tree not yet supported!")
	end,
	["permission-group"] = function()
		systemtool.log("add permission-group not yet supported!")
	end,
	instrumentation = function()
		systemtool.log("add instrumentation not yet supported!")
	end,
	["supports-screens"] = function()
		addType3("supports-screens", parent, newElement)
	end,
	["compatible-screens"] = function()
	end,
	["supports-gl-texture"] = function()
	end,
	activity = function(parent, newElement)
		addType1('activity', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', newElement, 'android:name')
	end,
	["activity-alias"] = function(parent, newElement)
		addType1('activity-alias', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', newElement, 'android:name')
	end,
	service = function(parent, newElement)
		addType1('service', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', newElement, 'android:name')
	end,
	receiver = function(parent, newElement)
		addType1('receiver', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', newElement, 'android:name')
	end,
	provider = function(parent, newElement)
		addType4('provider', parent, 'grant-uri-permission', 'meta-data', 'path-permission', newElement, 'android:name')
	end,
	['uses-library'] = function(parent, newElement)
	end,
	["meta-data"] = function(parent, newElement)
		addType2("meta-data", parent, newElement, 'android:name')
	end,
	data = function(parent, newElement)
		addType2("data", parent, newElement, 'android:name')
	end,
	action = function(parent, newElement)
		addType2("action", parent, newElement, 'android:name')
	end,
	category = function(parent, newElement)
		addType2("category", parent, newElement, 'android:name')
	end,
	['grant-uri-permission'] = function(parent, newElement)
		addType2("grant-uri-permission", parent, newElement, 'android:path')
	end,
	['path-permission'] = function(parent, newElement)
		addType2("path-permission", parent, newElement, 'android:path')
	end
}

local removeEvent = {}

local removeType1 = function(element, parent)
	if not parent then
		return
	end

	if parent[element] then
		parent[element] = {}
		return true
	end

	return false
end

local removeType2 = function(element, parent, removeName, keyName)
	local sdk = parent[element]
	for i = 1,#sdk,1 do
		local item = sdk[i]
		if item[keyName] and item[keyName] == removeName then
			table.remove(parent[element], i)
			return true
		end
	end

	return false
end

local removeType3 = function(element, parent, removeKey)
	local sdk = parent[element]
	for i = 1,#sdk,1 do
		local item = sdk[i]
		if item[removeKey] then
			parent[element][i][removeKey] = nil
			return true
		end
	end

	return false
end

removeEvent = {
	["uses-sdk"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('uses-sdk', parent, removeName)
		else
			return removeType1('uses-sdk', parent)
		end
	end,
	["uses-configuration"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('uses-configuration', parent, removeName)
		else
			return removeType1('uses-configuration')
		end
	end,
	["uses-feature"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('uses-feature', parent, removeName)
		else
			return removeType2('uses-feature')
		end
	end,
	["uses-permission"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('uses-permission', parent, removeName)
		else
			return removeType2('uses-permission', parent, removeName, 'android:name')
		end
	end,
	permission = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('permission', parent, removeName)
		else
			return removeType2('permission', parent, removeName, 'android:name')
		end
	end,
	["permission-tree"] = function()
		systemtool.log("remove permission-tree not yet supported!")
	end,
	["permission-group"] = function()
		systemtool.log("remove permission-group not yet supported!")
	end,
	instrumentation = function()
		systemtool.log("remove instrumentation not yet supported!")
	end,
	["supports-screens"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('supports-screens', parent, removeName)
		else
			return removeType1('supports-screens')
		end
	end,
	["compatible-screens"] = function()
	end,
	["supports-gl-texture"] = function()
	end,
	activity = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('activity', parent, removeName)
		else
			return removeType2('activity', parent, removeName, 'android:name')
		end
	end,
	["activity-alias"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('activity-alias', parent, removeName)
		else
			return removeType2('activity-alias', parent, removeName, 'android:name')
		end
	end,
	service = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('service', parent, removeName)
		else
			return removeType2('service', parent, removeName, 'android:name')
		end
	end,
	receiver = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('receiver', parent, removeName)
		else
			return removeType2('receiver', parent, removeName, 'android:name')
		end
	end,
	provider = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('receiver', parent, removeName)
		else
			return removeType2('receiver', parent, removeName, 'android:name')
		end
	end,
	['uses-library'] = function(parent, prefix)
	end,
	["meta-data"] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('meta-data', parent, removeName)
		else
			return removeType2('meta-data', parent, removeName, removeAttr)
		end
	end,
	action = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('action', parent, removeName)
		else
			return removeType2('action', parent, removeName, 'android:name')
		end
	end,
	category = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('category', parent, removeName)
		else
			return removeType2('category', parent, removeName, 'android:name')
		end
	end,
	['grant-uri-permission'] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('grant-uri-permission', parent, removeName)
		else
			return removeType2('grant-uri-permission', parent, removeName, removeAttr)
		end
	end,
	['path-permission'] = function(parent, removeName, removeAttr)
		if removeAttr then
			return removeType3('path-permission', parent, removeName)
		else
			return removeType2('path-permission', parent, removeName, removeAttr)
		end
	end
}

local toXmlEvent = {}

local toXmlType1 = function(element, parent, sub1, sub1sub1, sub1sub2, sub1sbu3, sub2, prefix)
	local elements = parent[element]
	if not elements or #elements == 0 then
		return ""
	end

	local result = ''
	for i,v in pairs(elements) do
		result = result .. prefix .. '<' .. element
		for j,k in pairs(v) do
			if type(j) == 'string' and type(k) == 'string' then
				result = result .. '\n' .. prefix .. '\t' .. j .. '=\"' .. k .. '\"'
			end
		end

		result = result .. ' >\n'

		if v[sub1] and #v[sub1] > 0 then
			local intent = v[sub1][1]
			if (intent[sub1sub1] and #intent[sub1sub1]) or (intent[sub1sub2] and #intent[sub1sub2] > 0) or (intent[sub1sbu3] and #intent[sub1sbu3] > 0) then
				result = result .. prefix .. '\t' .. '<' .. sub1 .. '>\n'

				if intent[sub1sub1] and #intent[sub1sub1] > 0 then
					local action = toXmlEvent[sub1sub1](intent, prefix .. '\t\t')
					result = result .. action
				end

				if intent[sub1sub2] and #intent[sub1sub2] > 0 then
					local action = toXmlEvent[sub1sub2](intent, prefix .. '\t\t')
					result = result .. action
				end

				if intent[sub1sbu3] and #intent[sub1sbu3] > 0 then
					result = result .. toXmlEvent[sub1sbu3](intent, prefix .. '\t\t')
				end

				result = result .. prefix .. '\t' .. '</' .. sub1 .. '>\n'
			end
		end

		if v[sub2] and #v[sub2] > 0 then
			result = result .. toXmlEvent[sub2](v, prefix .. '\t')
		end

		result = result .. prefix .. '</' .. element .. '>\n'
	end
	return result
end

local toXmlType2 = function(element, parent, prefix)
	local result = ''
	if parent[element] and #parent[element] > 0 then
		for i,v in pairs(parent[element]) do
			result = result .. prefix .. '<' .. element
			for m,n in pairs(v) do
				if type(m) == 'string' and type(n) == 'string' then
					result = result .. '\n' .. prefix .. '\t' .. m .. '=\"' .. n .. '\"'
				end
			end
			result = result .. ' />\n'
		end
	end
	return result
end

local toXmlType3 = function(element, parent, prefix)
	local sdk = parent[element]
	if not sdk or #sdk == 0 then
		return ""
	end

	local result = prefix .. '<' .. element
	for i,v in pairs(sdk[1]) do
		if type(i) == 'string' and type(v) == 'string' then
			result = result .. '\n' .. prefix .. '\t' .. i .. '=\"' .. v .. '\"'
		end
	end
	result = result .. ' />\n'
	return result
end

local toXmlType4 = function(element, parent, sub1, sub2, sub3, prefix)
	local elements = parent[element]
	if not elements or #elements == 0 then
		return ""
	end

	local result = ''
	for i,v in pairs(elements) do
		result = result .. prefix .. '<' .. element
		for j,k in pairs(v) do
			if type(j) == 'string' and type(k) == 'string' then
				result = result .. '\n' .. prefix .. '\t' .. j .. '=\"' .. k .. '\"'
			end
		end

		result = result .. ' >\n'

		if v[sub1] and #v[sub1] > 0 then
			result = result .. toXmlEvent[sub1](v, prefix .. '\t')
		end

		if v[sub2] and #v[sub2] > 0 then
			result = result .. toXmlEvent[sub2](v, prefix .. '\t')
		end

		if v[sub3] and #v[sub3] > 0 then
			result = result .. toXmlEvent[sub3](v, prefix .. '\t')
		end

		result = result .. prefix .. '</' .. element .. '>\n'
	end
	return result
end

toXmlEvent = {
	["uses-sdk"] = function(parent, prefix)
		return toXmlType3('uses-sdk', parent, prefix)
	end,
	["uses-configuration"] = function(parent, prefix)
		return toXmlType3('uses-configuration', parent, prefix)
	end,
	["uses-feature"] = function(parent, prefix)
		return toXmlType2('uses-feature', parent, prefix)
	end,
	["uses-permission"] = function(parent, prefix)
		return toXmlType2('uses-permission', parent, prefix)
	end,
	permission = function(parent, prefix)
		return toXmlType2('permission', parent, prefix)
	end,
	["permission-tree"] = function()
		systemtool.log("toXml permission-tree not yet supported!")
		return ""
	end,
	["permission-group"] = function()
		systemtool.log("toXml permission-group not yet supported!")
		return ""
	end,
	instrumentation = function()
		systemtool.log("toXml instrumentation not yet supported!")
		return ""
	end,
	["supports-screens"] = function(parent, prefix)
		return toXmlType3('supports-screens', parent, prefix)
	end,
	["compatible-screens"] = function()
		systemtool.log("toXml compatible-screens not yet supported!")
		return ""
	end,
	["supports-gl-texture"] = function()
		systemtool.log("toXml supports-gl-texture not yet supported!")
		return ""
	end,
	activity = function(parent, prefix)
		return toXmlType1('activity', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', prefix)
	end,
	["activity-alias"] = function(parent, prefix)
		return toXmlType1('activity-alias', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', prefix)
	end,
	service = function(parent, prefix)
		return toXmlType1('service', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', prefix)
	end,
	receiver = function(parent, prefix)
		return toXmlType1('receiver', parent, 'intent-filter', 'data', 'action', 'category', 'meta-data', prefix)
	end,
	provider = function(parent, prefix)
		return toXmlType4('provider', parent, 'grant-uri-permission', 'meta-data', 'path-permission', prefix)
	end,
	['uses-library'] = function(parent, prefix)
		return ""
	end,
	["meta-data"] = function(parent, prefix)
		return toXmlType2('meta-data', parent, prefix)
	end,
	data = function(parent, prefix)
		return toXmlType2('data', parent, prefix)
	end,
	action = function(parent, prefix)
		return toXmlType2('action', parent, prefix)
	end,
	category = function(parent, prefix)
		return toXmlType2('category', parent, prefix)
	end,
	['grant-uri-permission'] = function(parent, prefix)
		return toXmlType2('grant-uri-permission', parent, prefix)
	end,
	['path-permission'] = function(parent, prefix)
		return toXmlType2('path-permission', parent, prefix)
	end
}

function xmltool.merge(main, other)
	local mainManifest = main['manifest'][1]
	local otherManifest = other['manifest'][1]

	for i,v in pairs(otherManifest) do
		if type(i) == 'string' and type(v) == 'string' then
			local isNew = true
			for m,n in pairs(mainManifest) do
				if type(m) == 'string' and type(n) == 'string' and i == m then
					isNew = false
				end
			end

			if isNew then
				mainManifest[i] = v
			end
		end
	end

	xmltool.add('uses-sdk', mainManifest, otherManifest, true)
	xmltool.add('uses-configuration', mainManifest, otherManifest)
	xmltool.add('uses-feature', mainManifest, otherManifest)
	xmltool.add('uses-permission', mainManifest, otherManifest)
	xmltool.add('permission', mainManifest, otherManifest)
	xmltool.add('permission-tree', mainManifest, otherManifest)
	xmltool.add('permission-group', mainManifest, otherManifest)
	xmltool.add('instrumentation', mainManifest, otherManifest)
	xmltool.add('supports-screens', mainManifest, otherManifest, true)
	xmltool.add('compatible-screens', mainManifest, otherManifest)
	xmltool.add('supports-gl-texture', mainManifest, otherManifest)

	local mainApplication = mainManifest['application'][1]
	local otherApplication = otherManifest['application'][1]

	for i,v in pairs(otherApplication) do
		if type(i) == 'string' and type(v) == 'string' then
			local isNew = true
			for m,n in pairs(mainApplication) do
				if type(m) == 'string' and type(n) == 'string' and i == m then
					isNew = false
				end
			end
			 
			if isNew then
				mainApplication[i] = v
			end
		end
	end

	xmltool.add('activity', mainApplication, otherApplication)
	xmltool.add('activity-alias', mainApplication, otherApplication)
	xmltool.add('service', mainApplication, otherApplication)
	xmltool.add('receiver', mainApplication, otherApplication)
	xmltool.add('provider', mainApplication, otherApplication)
	xmltool.add('uses-library', mainApplication, otherApplication)
	xmltool.add('meta-data', mainApplication, otherApplication)
end

function xmltool.add(elementName, parent, ...)
	if addEvent[elementName] then
		return addEvent[elementName](parent, ...)
	else
		systemtool.log('addEvent : invalid elementName ' .. elementName)
	end
end

function xmltool.remove(elementName, parent, ...)
	if removeEvent[elementName] then
		return removeEvent[elementName](parent, ...)
	else
		systemtool.log('removeEvent : invalid elementName ' .. elementName)
	end
end

function xmltool.toXml(elementName, parent, ...)
	if toXmlEvent[elementName] then
		return toXmlEvent[elementName](parent, ...)
	else
		systemtool.log('toXml : invalid elementName ' .. elementName)
	end
end

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

function xmltool.prase(fileName)
	local xmlTable = {}

	local tree = mxml.loadFile(fileName)
	praseXml(tree, xmlTable)
	setmetatable(xmlTable, {__index = template})
	return xmlTable
end

function xmltool.save(xmlTable)
	local result = ""
	local prefix = ""

	result = result .. xmlTable['head'] .. '\n'

	result = result .. '<manifest'

	local manifest = xmlTable['manifest'][1]
	prefix = prefix .. '\t'
	for i,v in pairs(manifest) do
		if type(i) == 'string' and type(v) == 'string' then
			if i ~= 'android:versionName' and i ~= 'android:versionCode' then
				result = result .. '\n' .. prefix .. i .. '=\"' .. v .. '\"'
			end
		end
	end
	result = result .. ' >\n'
	result = result .. xmltool.toXml('uses-sdk', manifest, prefix)
	result = result .. xmltool.toXml('uses-configuration', manifest, prefix)
	result = result .. xmltool.toXml('uses-feature', manifest, prefix)
	result = result .. xmltool.toXml('uses-permission', manifest, prefix)
	result = result .. xmltool.toXml('permission', manifest, prefix)
	result = result .. xmltool.toXml('permission-tree', manifest, prefix)
	result = result .. xmltool.toXml('permission-group', manifest, prefix)
	result = result .. xmltool.toXml('instrumentation', manifest, prefix)
	result = result .. xmltool.toXml('supports-screens', manifest, prefix)
	result = result .. xmltool.toXml('compatible-screens', manifest, prefix)
	result = result .. xmltool.toXml('supports-gl-texture', manifest, prefix)

	result = result .. prefix .. '<application'
	local application = manifest['application'][1]
	for i,v in pairs(application) do
		if type(i) == 'string' and type(v) == 'string' then
			result = result .. '\n' .. prefix .. '\t' .. i .. '=\"' .. v .. '\"'
		end
	end
	result = result .. ' >\n'

	result = result .. xmltool.toXml('activity', application, prefix .. '\t')
	result = result .. xmltool.toXml('activity-alias', application, prefix .. '\t')
	result = result .. xmltool.toXml('service', application, prefix .. '\t')
	result = result .. xmltool.toXml('receiver', application, prefix .. '\t')
	result = result .. xmltool.toXml('provider', application, prefix .. '\t')
	result = result .. xmltool.toXml('uses-library', application, prefix .. '\t')
	result = result .. xmltool.toXml('meta-data', application, prefix .. '\t')

	result = result .. prefix .. '</application>\n'
	result = result .. '</manifest>\n'
	return result
end

--[[

-- test activites
local activities = {
	["activity"] = {
		{
			['android:name']="com.egls.ssrkr.gp.MainActivity",
			['android:label']="@string/app_name",
            ['android:launchMode']="singleTask",
            ['android:screenOrientation']="sensorLandscape",
        	['intent-filter'] = {
        		{
        			action = {
        				{
        					['android:name']="android.intent.action.VIEW"
        				}
        			},
        			category = {
        				{
        					['android:name']="android.intent.category.DEFAULT"
        				},
        				{
							['android:name']="android.intent.category.BROWSABLE"
        				}
        			}
        		}
        	},
			['meta-data'] = {
				{
					['android:name']="unityplayer.ForwardNativeEventsToDalvik",
					['android:value']="true"
				}
			}
		},
		{
			['android:name']="com.egls.socialization.google.play.GooglePlayActivity",
			['android:screenOrientation']="landscape",
        	['intent-filter'] = {
        		{
        			action = {
        			},
        			category = {
        			}
        		}
        	}
		}
	}
}

setmetatable(activities, {__index = template})

local activitiesResult = xmltool.toXml("activity", activities, '')
print(activitiesResult)


-- test permission
local usessdk = {
	["uses-sdk"] = {
		{
			['android:minSdkVersion']="16",
			['android:targetSdkVersion']="26"
		}
	}
}

local usessdkResult = xmltool.toXml("uses-sdk", usessdk, '')
print(usessdkResult)


-- test remove activity
local removeActivity = xmltool.remove("activity", activities, 'com.egls.socialization.google.play.GooglePlayActivity', false)
print(removeActivity)
print(xmltool.toXml("activity", activities, ''))

local removeActivity = xmltool.remove("activity", activities, 'android:label', true)
print(removeActivity)
print(xmltool.toXml("activity", activities, ''))

-- test provider
local providers = {
	["provider"] = {
		{
			['android:name']="com.facebook.FacebookContentProvider",
			['android:authorities']="com.facebook.app.FacebookContentProvider255019441746143",
            ['android:exported']="false",
        	['path-permission'] = {
        		{
        			['android:path'] = 'com.test.demo'
        		},
        		{
        			['android:path'] = 'com.test.demo1'
        		}
        	},
        	['grant-uri-permission'] = {
        		{
					['android:path']="com.test.demo"
        		},
        		{
					['android:path']="com.test.demow"
        		}
        	},
			['meta-data'] = {
				{
					['android:name']="unityplayer.ForwardNativeEventsToDalvik",
					['android:value']="true"
				}
			}
		}
	}
}

local providersResult = xmltool.toXml("provider", providers, '')
print(providersResult)

-- test add activites
local addActivity = {
	['android:name']="com.egls.ssrkr.gp.MainActivity1",
	['android:label']="@string/app_name",
    ['android:launchMode']="singleTask",
    ['android:screenOrientation']="sensorLandscape",
	['intent-filter'] = {
		{
			action = {
				{
					['android:name']="android.intent.action.VIEW"
				}
			},
			category = {
				{
					['android:name']="android.intent.category.DEFAULT"
				},
				{
					['android:name']="android.intent.category.BROWSABLE"
				}
			}
		}
	},
	['meta-data'] = {
		{
			['android:name']="unityplayer.ForwardNativeEventsToDalvik",
			['android:value']="true"
		}
	}
}

local activitiesResult = xmltool.add("activity", activities, addActivity, 'android:name')
print(xmltool.toXml("activity", activities, ''))


local testTemplate = {
	manifest = {
		{
			['xmlns:android']="http://schemas.android.com/apk/res/android",
    		['package']="com.icarry.sanguo",
    		['android:installLocation']="preferExternal",
    		['android:versionCode']="21",
    		['android:versionName']="1.2.1",
			["uses-sdk"] = {
				{
        			['android:minSdkVersion']="9",
        			['android:targetSdkVersion']="20"
				}
			},
			["uses-configuration"] = {},
			["uses-feature"] = {
				{
					['android:glEsVersion']="0x00020000"
				},
				{
        			['android:name']="android.hardware.touchscreen",
        			['android:required']="false"
				}
			},
			["uses-permission"] = {
				{
					['android:name']="android.permission.GET_TASKS"
				},
				{
					['android:name']="android.permission.INTERNET"
				},
				{
					['android:name']="android.permission.ACCESS_NETWORK_STATE"
				},
				{
					['android:name']="android.permission.WRITE_EXTERNAL_STORAGE"
				},
				{
					['android:name']="android.permission.READ_PHONE_STATE"
				}
			},
			permission = {},
			["permission-tree"] = {},
			["permission-group"] = {},
			instrumentation = {},
			["supports-screens"] = {
				{
					['android:anyDensity']="true",
			        ['android:largeScreens']="true",
			        ['android:normalScreens']="true",
			        ['android:smallScreens']="true",
			        ['android:xlargeScreens']="true",
				}
			},
			["compatible-screens"] = {},
			["supports-gl-texture"] = {},
			application = {
				{
				    ['android:icon']="@drawable/app_icon",
        			['android:label']="@string/app_name",
        			['android:theme']="@android:style/Theme.NoTitleBar.Fullscreen",

					activity = {
						{
							['android:name']="com.egls.ssrkr.gp.MainActivity",
							['android:label']="@string/app_name",
				            ['android:launchMode']="singleTask",
				            ['android:screenOrientation']="sensorLandscape",
				        	['intent-filter'] = {
				        		{
				        			action = {
				        				{
				        					['android:name']="android.intent.action.VIEW"
				        				}
				        			},
				        			category = {
				        				{
				        					['android:name']="android.intent.category.DEFAULT"
				        				},
				        				{
											['android:name']="android.intent.category.BROWSABLE"
				        				}
				        			}
				        		}
				        	},
							['meta-data'] = {
								{
									['android:name']="unityplayer.ForwardNativeEventsToDalvik",
									['android:value']="true"
								}
							}
						},
						{
							['android:name']="com.egls.socialization.google.play.GooglePlayActivity",
							['android:screenOrientation']="landscape",
				        	['intent-filter'] = {
				        		{
				        			action = {
				        			},
				        			category = {
				        			}
				        		}
				        	}
						}
					},
					["activity-alias"] = {},
					service = {
						{
							['android:name']="com.yunva.im.sdk.lib.service.VioceService"
						},
						{
							['android:name']="com.zeljkosassets.notifications.Notifier"
						}
					},
					receiver = {},
					provider = {
						{
							['android:name']="com.facebook.FacebookContentProvider",
							['android:authorities']="com.facebook.app.FacebookContentProvider255019441746143",
				            ['android:exported']="false",
				        	['path-permission'] = {
				        		{
				        			['android:path'] = 'com.test.demo'
				        		},
				        		{
				        			['android:path'] = 'com.test.demo1'
				        		}
				        	},
				        	['grant-uri-permission'] = {
				        		{
									['android:path']="com.test.demo"
				        		},
				        		{
									['android:path']="com.test.demow"
				        		}
				        	},
							['meta-data'] = {
								{
									['android:name']="unityplayer.ForwardNativeEventsToDalvik",
									['android:value']="true"
								}
							}
						}
					},
					["uses-library"] = {},
					["meta-data"] = {
						{
							['android:name']="android.max_aspect",
							['android:value']="2.2"
						},
						{
							['android:name']="com.huawei.hms.client.appid",
							['android:value']="appid=100341485"
						},
					}
				}
			}
		}
	}
}

setmetatable(testTemplate, {__index = template})
local testTemplateResult = xmltool.save(testTemplate)
print(testTemplateResult)

local testMergeTemplate1 = {
	manifest = {
		{
			['xmlns:android']="http://schemas.android.com/apk/res/android",
    		['package']="com.icarry.sanguo",
			["uses-sdk"] = {
				{
        			['android:minSdkVersion']="9",
        			['android:targetSdkVersion']="20"
				}
			},
			["uses-configuration"] = {},
			["uses-feature"] = {},
			["uses-permission"] = {
				{
					['android:name']="android.permission.GET_TASKS"
				},
				{
					['android:name']="android.permission.INTERNET"
				}
			},
			permission = {},
			["permission-tree"] = {},
			["permission-group"] = {},
			instrumentation = {},
			["supports-screens"] = {
				{
					['android:anyDensity']="true",
			        ['android:largeScreens']="true"
				}
			},
			["compatible-screens"] = {},
			["supports-gl-texture"] = {},
			application = {
				{
				    ['android:icon']="@drawable/app_icon",
        			['android:label']="@string/app_name",
        			['android:theme']="@android:style/Theme.NoTitleBar.Fullscreen",

					activity = {
						{
							['android:name']="com.egls.ssrkr.gp.MainActivity",
							['android:label']="@string/app_name",
				            ['android:launchMode']="singleTask",
				            ['android:screenOrientation']="sensorLandscape",
				        	['intent-filter'] = {
				        		{
				        			action = {
				        				{
				        					['android:name']="android.intent.action.VIEW"
				        				}
				        			},
				        			category = {
				        				{
				        					['android:name']="android.intent.category.DEFAULT"
				        				},
				        				{
											['android:name']="android.intent.category.BROWSABLE"
				        				}
				        			}
				        		}
				        	},
							['meta-data'] = {
								{
									['android:name']="unityplayer.ForwardNativeEventsToDalvik",
									['android:value']="true"
								}
							}
						},
					},
					["activity-alias"] = {},
					service = {
						{
							['android:name']="com.yunva.im.sdk.lib.service.VioceService"
						}
					},
					receiver = {},
					provider = {},
					["uses-library"] = {},
					["meta-data"] = {
						{
							['android:name']="android.max_aspect",
							['android:value']="2.2"
						}
					}
				}
			}
		}
	}
}

setmetatable(testMergeTemplate1, {__index = template})

local testMergeTemplate2 = {
	manifest = {
		{
    		['android:installLocation']="preferExternal",
    		['android:versionCode']="21",
    		['android:versionName']="1.2.1",
			["uses-sdk"] = {},
			["uses-configuration"] = {},
			["uses-feature"] = {
				{
					['android:glEsVersion']="0x00020000"
				},
				{
        			['android:name']="android.hardware.touchscreen",
        			['android:required']="false"
				}
			},
			["uses-permission"] = {
				{
					['android:name']="android.permission.ACCESS_NETWORK_STATE"
				},
				{
					['android:name']="android.permission.WRITE_EXTERNAL_STORAGE"
				},
				{
					['android:name']="android.permission.READ_PHONE_STATE"
				}
			},
			permission = {},
			["permission-tree"] = {},
			["permission-group"] = {},
			instrumentation = {},
			["supports-screens"] = {
				{
			        ['android:normalScreens']="true",
			        ['android:smallScreens']="true",
			        ['android:xlargeScreens']="true",
				}
			},
			["compatible-screens"] = {},
			["supports-gl-texture"] = {},
			application = {
				{
				    ['android:icon']="@drawable/app_icon",
        			['android:label']="@string/app_name",
        			['android:theme']="@android:style/Theme.NoTitleBar.Fullscreen",

					activity = {
						{
							['android:name']="com.egls.socialization.google.play.GooglePlayActivity",
							['android:screenOrientation']="landscape",
				        	['intent-filter'] = {
				        		{
				        			action = {
				        			},
				        			category = {
				        			}
				        		}
				        	}
						}
					},
					["activity-alias"] = {},
					service = {
						{
							['android:name']="com.zeljkosassets.notifications.Notifier"
						}
					},
					receiver = {},
					provider = {
						{
							['android:name']="com.facebook.FacebookContentProvider",
							['android:authorities']="com.facebook.app.FacebookContentProvider255019441746143",
				            ['android:exported']="false",
				        	['path-permission'] = {
				        		{
				        			['android:path'] = 'com.test.demo'
				        		},
				        		{
				        			['android:path'] = 'com.test.demo1'
				        		}
				        	},
				        	['grant-uri-permission'] = {
				        		{
									['android:path']="com.test.demo"
				        		},
				        		{
									['android:path']="com.test.demow"
				        		}
				        	},
							['meta-data'] = {
								{
									['android:name']="unityplayer.ForwardNativeEventsToDalvik",
									['android:value']="true"
								}
							}
						}
					},
					["uses-library"] = {},
					["meta-data"] = {
						{
							['android:name']="com.huawei.hms.client.appid",
							['android:value']="appid=100341485"
						},
					}
				}
			}
		}
	}
}

setmetatable(testMergeTemplate2, {__index = template})
xmltool.merge(testMergeTemplate1, testMergeTemplate2)
print(xmltool.save(testMergeTemplate1))

]]
return xmltool
