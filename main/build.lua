local sdktool = require 'tool.sdktool'
sdktool.mainPath = sdktool.currentDir()

local function buildDefault(sourceApk, platformName, channelName, pluginTable, targetApk, signParams, signApk)
      
      sdktool.outputPathName = "output"         -- 输出目录名
      sdktool.outputProjectPathName = "demo"    -- 输出目录里工程目录名
      sdktool.outputTmpPathName = "tmp"         -- 输出目录里的临时目录

      sdktool.init()

      sdktool.createOutputPath()
      sdktool.decodeApk(sourceApk)

      sdktool.createTmpPath()

      sdktool.loadAndroidManifest()

      sdktool.addSDKTool()
      sdktool.addPlatform(platformName)

      if channelName ~= nil and channelName ~= '' then
            sdktool.addChannel(channelName)
      end

      if pluginTable ~= nil then
            for i,v in pairs(pluginTable) do
                  sdktool.addPlugin(v)
            end
      end

      sdktool.compileJars()
      sdktool.mergeSmali()

      sdktool.saveAndroidManifest()

      sdktool.buildApk(targetApk)

      sdktool.sign(signParams, targetApk, signApk)
end

function buildEclipse(source, platformName, channelName, pluginTable, outputName)
      local eclipseParams = {
            projectName = source,
            sdkPath = "",
            ndkPath = "",
            antPath = ""
      }

      if not sdktool.setEclipseParams(eclipseParams) then
            print ("Could not find the eclipse project " .. source)
            return
      end

      sdktool.loadAndroidManifest()

      sdktool.addSDKTool()
      sdktool.addPlatform(platformName)

      if channelName ~= nil and channelName ~= '' then
            sdktool.addChannel(channelName)
      end

      if pluginTable ~= nil then
            for i,v in pairs(pluginTable) do
                  sdktool.addPlugin(v)
            end
      end

      sdktool.saveAndroidManifest()
      sdktool.buildEclipse(outputName)
end

--sdktool.help()

sdktool.setBuildType(sdkBuildType.default)
buildDefault('demo.apk', 'android', 'uc', nil, 'demo_new.apk', {
      keystore = './tool/nosdk.keystore',
      alias = 'nosdk',
      password = 'nosdk123' 
}, 'demo_sign.apk')

sdktool.setBuildType(sdkBuildType.eclipse)
buildEclipse('demo', 'android', 'uc', nil, 'demo_new.apk')

sdktool.setBuildType(sdkBuildType.gradle)
--buildEclipse('demo', 'android', 'uc', nil, 'demo_new.apk')