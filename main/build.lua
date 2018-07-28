package.cpath = "./tool/?.so"

local sdktool = require 'tool.sdktool'

sdktool.rootPath = sdktool.currentDir() .. '/..'

function buildChannel(sourceApk, platformName, channelName, pluginTable, targetApk)
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

      sdktool.testLogManifest()
      sdktool.buildApk(targetApk)
end

sdktool.help()
buildChannel('demo.apk', 'android', 'uc', nil, 'demo_new.apk')

--sdktool.init()
--sdktool.buildApk('demo_new.apk')