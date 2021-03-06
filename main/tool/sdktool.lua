local systemtool = require 'tool.systemtool'

local systemType = systemtool.getSystemType()
if systemType == SystemType.mac then
	package.cpath = "./tool/mac/?.so"
elseif systemType == SystemType.windows then
	package.cpath = "./tool/windows/?.dll"
end

require("lfs")
local xmltool = require 'tool.xmltool'
local filetool = require 'tool.filetool'

local sdktool = {}

sdkBuildType = {
	default = 1,
	eclipse = 2,
	gradle = 3
}

sdktool.mainPath = ""
sdktool.outputPathName = "output"
sdktool.outputProjectPathName = "demo"
sdktool.outputTmpPathName = "tmp" 

sdktool.buildType = sdkBuildType.default

function sdktool.init(outputPath)
	if outputPath and outputPath ~= '' then
		sdktool.outputProjectPathName = outputPath
	end

	sdktool.outputPath = sdktool.mainPath .. "/" .. sdktool.outputPathName
	sdktool.outputProjectPath = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputProjectPathName
	sdktool.outputProjectSmaliPath = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputProjectPathName .. '/smali'
	sdktool.outputTmpPath = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputTmpPathName
	sdktool.outputTmpLibsPath = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputTmpPathName .. "/libs"
	sdktool.outputTmpLibsAllJar = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputTmpPathName .. "/libs/*.jar"
	sdktool.outputTmpDexPath = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputTmpPathName .. "/classes.dex"
	sdktool.outputTmpSmaliPath = sdktool.mainPath .. "/" .. sdktool.outputPathName .. "/" .. sdktool.outputTmpPathName .. "/smali"

	sdktool.apktoolPath = sdktool.mainPath  .. "/tool/apktool_2.3.2.jar"
	sdktool.dexPath = sdktool.mainPath .. "/tool/dx.jar"
	sdktool.baksmaliPath = sdktool.mainPath .. "/tool/baksmali-2.2.2.jar"
end

function sdktool.createOutputPath()
	filetool.rmDir(sdktool.outputPath)

	filetool.mkDir(sdktool.outputPath)

	--local cmd = 'rm -d -f -R ' .. sdktool.outputPath
	--sdktool.execute(cmd)

	--cmd = 'mkdir -p ' .. sdktool.outputPath
	--sdktool.execute(cmd)
end

function sdktool.decodeApk(apkPath)
	filetool.rmDir(sdktool.outputProjectPath)

	--local cmd = 'rm -d -f -R ' .. sdktool.outputProjectPath
	--sdktool.execute(cmd)

	cmd = 'java -jar ' .. sdktool.apktoolPath ..' d ' .. apkPath .. ' -o ' .. sdktool.outputProjectPath
	systemtool.execute(cmd)
end

function sdktool.buildApk(newApkPath)
	local cmd = 'java -jar ' .. sdktool.apktoolPath ..' b ' .. sdktool.outputProjectPath .. ' -o ' .. newApkPath
	systemtool.execute(cmd)
end

function sdktool.createTmpPath()
	filetool.rmDir(sdktool.outputTmpPath)

	filetool.mkDir(sdktool.outputTmpLibsPath)
	filetool.mkDir(sdktool.outputTmpSmaliPath)

	--local cmd = 'rm -d -f -R ' .. sdktool.outputTmpPath
	--sdktool.execute(cmd)

	--cmd = 'mkdir -p ' .. sdktool.outputTmpLibsPath
	--sdktool.execute(cmd)

	--cmd = 'mkdir -p ' .. sdktool.outputTmpSmaliPath
	--sdktool.execute(cmd)
end

function sdktool.compileJars()
	local cmd = 'java -jar ' .. sdktool.dexPath .. ' --dex --output=' .. sdktool.outputTmpDexPath .. ' ' .. sdktool.outputTmpLibsAllJar
	systemtool.execute(cmd)

	cmd = 'java -jar ' .. sdktool.baksmaliPath .. ' disassemble -o ' .. sdktool.outputTmpSmaliPath .. ' ' .. sdktool.outputTmpDexPath
	systemtool.execute(cmd)
end

function sdktool.mergeSmali()
	filetool.rmDir(sdktool.outputProjectSmaliPath .. '/com/common/sdktool')
	filetool.copy(sdktool.outputTmpSmaliPath .. '/*', sdktool.outputProjectSmaliPath)
	--local cmd = 'cp -r ' .. sdktool.outputTmpSmaliPath .. '/* ' .. sdktool.outputProjectSmaliPath
	--sdktool.execute(cmd)
end

local mainManifest = {}
function sdktool.loadAndroidManifest()
      local manifestFileName = sdktool.outputProjectPath .. '/' .. 'AndroidManifest.xml'
      mainManifest = xmltool.prase(manifestFileName)
end

function sdktool.saveAndroidManifest()
    local manifestFileName = sdktool.outputProjectPath .. '/' .. 'AndroidManifest.xml'
    local file = io.output(manifestFileName)

	xmltool.remove('uses-sdk', mainManifest['manifest'][1])

    local output = xmltool.save(mainManifest)
	io.write(output)
	
	-- 关闭文件
	file:close()
end

local function mergeLuaConfig(luaConfigPath)
      local manifestFileName = luaConfigPath .. '/' .. 'AndroidManifest.xml'
      
      local tmpManifest = xmltool.prase(manifestFileName, "rb")
	  xmltool.merge(mainManifest, tmpManifest)
	  
	  local luaconfig = dofile(luaConfigPath .. '/luaconfig.lua')

	  mainManifest['manifest'][1]["package"] = (luaconfig and luaconfig.packageName) or mainManifest['manifest'][1]["package"]

	  if sdktool.buildType ~= sdkBuildType.default then
			mainManifest['manifest'][1]["android:versionCode"] = (luaconfig and luaconfig.versionCode) or mainManifest['manifest'][1]["android:versionCode"]
			mainManifest['manifest'][1]["android:versionName"] = (luaconfig and luaconfig.versionName) or mainManifest['manifest'][1]["android:versionName"] 
	  end
end

function sdktool.addSDKTool()
	local platformPath = sdktool.mainPath .. "/sdktool"
	sdktool.addCustom(platformPath)
	
	--[[
	for file in lfs.dir(platformPath) do
            if file ~= "." and file ~= ".." then
       		local f = platformPath .. '/' .. file
       		local attr = lfs.attributes (f)
       		if attr.mode == "directory" then
				if file ~= 'jars' and file ~= 'luaconfig' and file ~= 'libs' then
					filetool.copy(f, sdktool.outputProjectPath .. '/' .. file)
					   
					--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath .. '/' .. file
       				--sdktool.execute(cmd)
       			else
					 if file == 'jars' then
						local cmd = ''
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*.jar', sdktool.outputTmpLibsPath)
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputTmpLibsPath
						else
							filetool.copy(f .. '/*.jar', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
       					--sdktool.execute(cmd)
       				elseif file == 'luaconfig' then
						mergeLuaConfig(f)
					elseif file == 'libs' then
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/lib')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/lib'
						else
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
						--sdktool.execute(cmd)
                    else
       					print("skip channel path " .. f)
       				end
       			end
			else
				filetool.copy(f, sdktool.outputProjectPath)

       			--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath
       			--sdktool.execute(cmd)
       		end
		end
	end
	]]
end

function sdktool.addPlatform(name)
	local platformPath = sdktool.mainPath .. "/platform/" .. name
	sdktool.addCustom(platformPath)
	--[[
	for file in lfs.dir(platformPath) do
            if file ~= "." and file ~= ".." then
       		local f = platformPath .. '/' .. file
       		local attr = lfs.attributes (f)
       		if attr.mode == "directory" then
				if file ~= 'jars' and file ~= 'luaconfig' and file ~= 'libs' then
					filetool.copy(f, sdktool.outputProjectPath .. '/' .. file)
					   
					--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath .. '/' .. file
       				--sdktool.execute(cmd)
       			else
					if file == 'jars' then
						local cmd = ''
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*.jar', sdktool.outputTmpLibsPath)
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputTmpLibsPath
						else
							filetool.copy(f .. '/*.jar', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
       					--sdktool.execute(cmd)
                    elseif file == 'luaconfig' then
						mergeLuaConfig(f)
					elseif file == 'libs' then
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/lib')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/lib'
						else
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
                    else
       					print("skip channel path " .. f)
       				end
       			end
       		else
       			--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath
				--sdktool.execute(cmd)
				
				filetool.copy(f, sdktool.outputProjectPath)
       		end
		end
	end
	]]
end

function sdktool.addChannel(name)
	local channelPath = sdktool.mainPath .. "/channel/" .. name
	sdktool.addCustom(channelPath)
	--[[
	for file in lfs.dir(channelPath) do
    	if file ~= "." and file ~= ".." then
       		local f = channelPath .. '/' .. file
       		local attr = lfs.attributes (f)
       		if attr.mode == "directory" then
       			if file ~= 'jars' and file ~= 'luaconfig' and file ~= 'libs' then
       				--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath .. '/' .. file
					--sdktool.execute(cmd)
					   
					filetool.copy(f, sdktool.outputProjectPath .. '/' .. file)
       			else
					 if file == 'jars' then
						--local cmd = ''
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*.jar', sdktool.outputTmpLibsPath)
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputTmpLibsPath
						else
							filetool.copy(f .. '/*.jar', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
       					--sdktool.execute(cmd)
                    elseif file == 'luaconfig' then
						mergeLuaConfig(f)
					elseif file == 'libs' then
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/lib')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/lib'
						else
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
                    else
       					print("skip channel path " .. f)
       				end
       			end
			else
				filetool.copy(f, sdktool.outputProjectPath)

       			--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath
       			--sdktool.execute(cmd)
       		end
		end
	end
	]]
end

function sdktool.addPlugin(name)
	local pluginPath = sdktool.mainPath .. "/plugin/" .. name
	sdktool.addCustom(pluginPath)
	--[[
	for file in lfs.dir(pluginPath) do
            if file ~= "." and file ~= ".." then
       		local f = pluginPath .. '/' .. file
       		local attr = lfs.attributes (f)
       		if attr.mode == "directory" then
       			if file ~= 'jars' and file ~= 'luaconfig' then
					filetool.copy(f, sdktool.outputProjectPath .. '/' .. file)

					--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath .. '/' .. file
       				--sdktool.execute(cmd)
       			else
					 if file == 'jars' then
						--local cmd = ''
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*.jar', sdktool.outputTmpLibsPath)
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputTmpLibsPath
						else
							filetool.copy(f .. '/*.jar', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
       					--sdktool.execute(cmd)
                    elseif file == 'luaconfig' then
						mergeLuaConfig(f)
					elseif file == 'libs' then
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/lib')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/lib'
						else
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
                    else
       					print("skip channel path " .. f)
       				end
       			end
			else
				filetool.copy(f, sdktool.outputProjectPath)

       			--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath
       			--sdktool.execute(cmd)
       		end
		end
	end
	]]
end

function sdktool.addCustom(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path .. '/' .. file
            local attr = lfs.attributes (f)
            if attr.mode == "directory" then
                if file ~= 'jars' and file ~= 'luaconfig' and file ~= 'libs' then
					filetool.mkDir(f, sdktool.outputProjectPath .. '/' .. file)
					filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/' .. file .. '/')

					--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath .. '/' .. file
					--sdktool.execute(cmd)
				else
                	if file == 'jars' then
						--local cmd = ''
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*.jar', sdktool.outputTmpLibsPath)
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputTmpLibsPath
						else
							filetool.copy(f .. '/*.jar', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
                    	--sdktool.execute(cmd)
                	elseif file == 'luaconfig' then
						mergeLuaConfig(f)
					elseif file == 'libs' then
						if sdktool.buildType == sdkBuildType.default then
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/lib')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/lib'
						else
							filetool.copy(f .. '/*', sdktool.outputProjectPath .. '/libs')
							--cmd = 'cp -r ' .. f .. '/*.jar ' .. sdktool.outputProjectPath .. '/libs'
						end
                	else
                    	systemtool.log("skip channel path " .. f)
					end
				end
			else
				filetool.copy(f, sdktool.outputProjectPath)
				--local cmd = 'cp -r ' .. f .. ' ' .. sdktool.outputProjectPath
				--sdktool.execute(cmd)
            end
        end
    end
end

function sdktool.currentDir()
      return lfs.currentdir()
end

function sdktool.sign(signParams, apkName, signApkName)
	local cmd = ''
	if filetool.systemType == SystemType.mac then
		cmd = 'echo "' .. signParams.password .. '" | jarsigner -verbose -keystore ' ..  signParams.keystore  .. ' -signedjar ' .. signApkName .. ' ' .. apkName .. ' ' .. signParams.alias
	else
		cmd = 'echo ' .. signParams.password .. '|jarsigner -verbose -keystore ' ..  signParams.keystore  .. ' -signedjar ' .. signApkName .. ' ' .. apkName .. ' ' .. signParams.alias
	end
	systemtool.execute(cmd)
end

function sdktool.setBuildType(buildType)
	if buildType ~= sdkBuildType.default and buildType ~= sdkBuildType.eclipse
		and buildType ~= sdkBuildType.gradle then
		systemtool.log("Failed find buildType " .. buildType .. " set buildType default")
		sdktool.buildType = sdkBuildType.default
	else
		sdktool.buildType = buildType
	end
end

function sdktool.setEclipseParams(params)
	sdktool.eclipseParams = params
	sdktool.outputProjectPathName = params.projectName
	
	sdktool.init()
	systemtool.log("---------")
	systemtool.log(sdktool.outputProjectPath)
	local file =  io.open(sdktool.outputProjectPath)
	if file then
		file:close()
		return true
	else
		return false
	end
end

function sdktool.buildEclipse(outputName)
	systemtool.log("buildEclipse not support now!")
end

function sdktool.help()
    local help = [[
		sdktool.rootPath : main目录的所在路径名
		sdktool.outputPathName : 输出目录名
		sdktool.outputProjectPathName : 解包apk的输出路径
		sdktool.outputTmpPathName : 编译jar包，生成smali文件用到的临时目录名
		sdktool.init() : 设置完rootPath后，调用此方法可以重新初始化sdktool用到的路径
		sdktool.createOutputPath() : 删除旧的输出目录，重新创建一个新的空输出目录
		sdktool.decodeApk(apkPath) : 解包，apkPath是输入apk文件的路径名
		sdktool.buildApk(newApkPath) : 重新生成apk，newApkPath是输出的apk文件的路径名
		sdktool.createTmpPath() : 临时目录，用来存放编译jar包后生成的dex文件和smali文件
		sdktool.compileJars() : 编译jar包，生成smali文件
		sdktool.mergeSmali() : 合并smail文件，将编译jar包生成的smali文件合并到解包apk目录里
		sdktool.addSDKTool() : 合并main/sdktool/default目录到解包工程，其中的jars和luaconfig目录不会拷贝，jars/*.jar会在生成smali后再合并到sdktool.outputProjectPathName目录
		sdktool.addPlatform(name) : 拷贝main/sdktool/platform的平台工程，name是平台名，拷贝方式同sdktool.addSDKTool()相同
		sdktool.addChannel(name) : 拷贝main/channel的渠道工程，name是平台名，拷贝方式同sdktool.addSDKTool()相同
		sdktool.addPlugin(name) : 拷贝main/plugin的插件工程，name是插件名，拷贝方式同sdktool.addSDKTool()相同
		sdktool.addCustom(path) : 拷贝用户自定义的工程，path是工程路径，拷贝方式同sdktool.addSDKTool()相同
		sdktool.currentDir() : 脚本的执行路径
		sdktool.help() : 帮助文档
]]
    print(help)
end

return sdktool