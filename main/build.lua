
SystemType = {
      mac = 1,
      windows = 2
}

local function setSystemType(systemType)
      if systemType == SystemType.mac then
            package.cpath = "./tool/mac/?.so"
      elseif systemType == SystemType.windows then
            package.cpath = "./tool/windows/?.dll"
      end
end

local systemType = SystemType.windows
setSystemType(systemType)

local sdktool = require 'tool.sdktool'
sdktool.mainPath = sdktool.currentDir()

local function buildDefault(sourceApk, platformName, channelName, pluginTable, targetApk, signParams, signApk)
      sdktool.init(systemType, 'test')

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

      sdktool.testLogManifest()
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