LuaS �

xV           (w@@sdktool.lua         T    @ A@  $� G�@ d�� ��@ � A�� � ��@A ��A�@���@ � B�� @ ��@A �@B�� @ �� �@ � @ �� �� � @  �   K�  J�C�JAD�J�D�@��
AE�
�E�
AF�
�F�FAC G��
A�l  
A��lA  
A�l�  
A��l�  
A�l 
A��lA 
A�l� 
A��K  �� 
��� 
����A � 
���� 
���� 
���A 
���� 
���� 
���� 
���A 
���� 
���� 
���� 
��& & � 1   requiretool.systemtoolgetSystemTypeSystemTypemacpackagecpath./tool/mac/?.sowindows./tool/windows/?.dlllfstool.xmltooltool.filetoolsdkBuildTypedefault       eclipse       gradle       	mainPathoutputPathNameoutputoutputProjectPathNamedemooutputTmpPathNametmp
buildTypeinitcreateOutputPath
decodeApk	buildApkcreateTmpPathcompileJarsmergeSmaliloadAndroidManifestsaveAndroidManifestaddSDKTooladdPlatformaddChannel
addPlugin
addCustomcurrentDirsignsetBuildTypesetEclipseParamsbuildEclipsehelp           .    M   "   � �_ @   � ��F�@ �  �@A ]�� @ �F�@ �  �@A  FA@ ]@� @ �F�@ �  �@A  FA@ � ]�� @��F�@ �  �@A  F�B ]@� @��F�@ �  �@A  F�B � ]�� @��F�@ �  �@A  F�B �� ]�� @��F�@ �  �@A  F�B � ]�� @��F�@ �  �@A  F�B � ]�� @��F�@ �� ]�� @ �F�@ �@ ]�� @ �F�@ �� ]�� @ �& �    outputProjectPathNameoutputPath	mainPath/outputPathNameoutputProjectPathoutputProjectSmaliPath/smalioutputTmpPathoutputTmpPathNameoutputTmpLibsPath/libsoutputTmpLibsAllJar/libs/*.jaroutputTmpDexPath/classes.dexoutputTmpSmaliPathapktoolPath/tool/apktool_2.3.2.jardexPath/tool/dx.jarbaksmaliPath/tool/baksmali-2.2.2.jar       M                  "   "   "   "   "   #   #   #   #   #   #   #   $   $   $   $   $   $   $   $   %   %   %   %   %   %   %   &   &   &   &   &   &   &   &   '   '   '   '   '   '   '   '   (   (   (   (   (   (   (   (   )   )   )   )   )   )   )   )   +   +   +   +   ,   ,   ,   ,   -   -   -   -   .      outputPath    M      sdktool 0   :         @ F@� $@ �@ F@� $@ & �    rmDiroutputPathmkDir          1   1   1   3   3   3   :          	filetoolsdktool <   D       F @ �@� d@ A�  � � �@    A� �A� ]�� �@ �F����@d@ & �    rmDiroutputProjectPathcmdjava -jar apktoolPath d  -o execute             =   =   =   B   B   B   B   B   B   B   B   C   C   C   D      apkPath          	filetoolsdktool_ENVsystemtool F   I       A   �@@ ��  �@ A �  ]�� �@� � � �@ & �    java -jar apktoolPath b outputProjectPath -o execute           G   G   G   G   G   G   G   H   H   H   I      newApkPath       cmd         sdktoolsystemtool K   Y     
    @ F@� $@ �@ F�� $@ �@ F � $@ & �    rmDiroutputTmpPathmkDiroutputTmpLibsPathoutputTmpSmaliPath       
   L   L   L   N   N   N   O   O   O   Y          	filetoolsdktool [   a           F@@ ��  ��@  FAA @ F�� �   d@ A   ��A �  AB A ��@ �� F�� �   d@ & � 
   java -jar dexPath --dex --output=outputTmpDexPath outputTmpLibsAllJarexecutebaksmaliPath disassemble -o outputTmpSmaliPath           \   \   \   \   \   \   \   ]   ]   ]   _   _   _   _   _   _   _   `   `   `   a      cmd         sdktoolsystemtool c   h         @ F@� ��  ]�� $@ �@ F � �@ ]�� �@� $@�& �    rmDiroutputProjectSmaliPath/com/common/sdktoolcopyoutputTmpSmaliPath/*          d   d   d   d   d   e   e   e   e   e   e   h          	filetoolsdktool k   n     	    @ A@  ��  �  F�@�   d� I � & �    outputProjectPath/AndroidManifest.xmlprase       	   l   l   l   l   m   m   m   m   n      manifestFileName   	      sdktoolmainManifestxmltool p   {         @ A@  ��  �  F�� G � �   d� �@A�� ��B�@��@B� ��� ��� ǀ�  �@ ��� �@ & �    outputProjectPath/AndroidManifest.xmliooutputremove	uses-sdk	manifest       savewriteclose            q   q   q   q   r   r   r   r   t   t   t   t   t   v   v   v   w   w   w   w   z   z   {      manifestFileName      file      output         sdktool_ENVxmltoolmainManifest }   �    8   @   �   �@  ]�� ��@ � � �  ���� A � @ �@��@A   A� A� �� B�   � �G��bA  � �F�� G�GA�
A����FCGA�_@@��� B�   � �G��bA  � �F�� G�G��
A��� B�   � �GA�bA  � �F�� G�G�
A�& �    /AndroidManifest.xmlpraserbmergedofile/luaconfig.lua	manifest       packagepackageName
buildTypesdkBuildTypedefaultandroid:versionCodeversionCodeandroid:versionNameversionName         8   ~   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      luaConfigPath    8   manifestFileName   8   tmpManifest   8   
luaconfig   8      xmltoolmainManifest_ENVsdktool �   �         @ A@  @  F�@ �   d@ & �    	mainPath	/sdktool
addCustom          �   �   �   �   �   �   �      platformPath         sdktool �   �       F @ �@  �   ]�� ��@ � � �@ & �    	mainPath/platform/
addCustom          �   �   �   �   �   �   �   �      name       platformPath         sdktool �   #      F @ �@  �   ]�� ��@ � � �@ & �    	mainPath
/channel/
addCustom          �   �   �   �   �   �   �   #     name       channelPath         sdktool %  U      F @ �@  �   ]�� ��@ � � �@ & �    	mainPath	/plugin/
addCustom          &  &  &  &  '  '  '  U     name       pluginPath         sdktool W  �   o   F @ G@� �   d ��_�@ �_�@��@  � � ]���@ �AA���� ǁA����_ B@�_@B��_�B@����  �FC� � ]�A��A�  �A� BFC� �  ]��A��� B ���CD BD ����A�  �A� BF�D�A�@��A�  �A� BFC� ]���A� 
�@B� ��� ��A ���B����CD BD � ��A�  �A� BFC�B ]���A����A�  �A� BFC� ]���A�@�ƁE� @�B�A � ��A�  �FC�A�i@  ��& �    lfsdir.../attributesmode
directoryjars
luaconfiglibsmkDiroutputProjectPathcopy/*
buildTypesdkBuildTypedefault/*.jaroutputTmpLibsPath/libs/liblogskip channel path           o   X  X  X  X  X  Y  Y  Y  Y  Z  Z  Z  Z  [  [  [  [  \  \  \  ]  ]  ]  ]  ]  ]  ^  ^  ^  ^  ^  ^  ^  _  _  _  _  _  _  _  _  _  _  _  d  d  f  f  f  f  f  g  g  g  g  g  g  g  j  j  j  j  j  j  j  j  l  n  n  o  o  o  o  p  p  q  q  q  q  q  r  r  r  r  r  r  r  r  r  u  u  u  u  u  u  u  u  w  y  y  y  y  y  {  }  }  }  }  X  X  �     path    o   (for generator)   n   (for state)   n   (for control)   n   file   l   f   l   attr   l      _ENV	filetoolsdktoolmergeLuaConfigsystemtool �  �        @ @@ % � &   & �    lfscurrentdir            �  �  �  �  �         _ENV �  �   !   �   A@ F�� G��@�� GAA �� ��A  @ �B �� C G�B �@��� GAA � ��A  @ �B �� C G�B �@AC@�$A & �    systemTypeSystemTypemacecho "	password"" | jarsigner -verbose -keystore 	keystore -signedjar  aliasecho |jarsigner -verbose -keystore execute          !   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     signParams    !   apkName    !   signApkName    !   cmd   !      	filetool_ENVsystemtool �  �      F @ G@� _@  @�F @ G�� _@  @�F @ G�� _@  @�F � �@ �   � � d@ F @ G@� �@��  �� ��& �    sdkBuildTypedefaulteclipsegradlelogFailed find buildType  set buildType default
buildType             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     
buildType          _ENVsystemtoolsdktool �  �        �G�@ @��F�@ d@� F � �@ d@ F � ��A d@ F�AG � ��A d� b    ��@� �@ � � �  @ ��   �  & � 
   eclipseParamsoutputProjectPathNameprojectNameinitlog
---------outputProjectPathioopenclose             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     params       file         sdktoolsystemtool_ENV �  �      F @ �@  d@ & �    logbuildEclipse not support now!           �  �  �  �     outputName          systemtool �  �          F@@ �   d@ & �    ��      		sdktool.rootPath : main目录的所在路径名
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
print            �  �  �  �  �     help         _ENVT                                                         
   
   
                                                            .      :   0   D   <   I   F   Y   K   a   [   h   c   j   n   k   {   p   �   �   �   �   �   #  �   U  %  �  W  �  �  �  �  �  �  �  �  �  �  �  �  �  �     systemtool   T   systemType   T   xmltool   T   	filetool   T   sdktool   T   mainManifest7   T   mergeLuaConfig<   T      _ENV