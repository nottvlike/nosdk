package com.common.sdktool;

public class SDKManager extends CommonSDKManager {
	static SDKManager instance = null;
	
	public static SDKManager getInstance()
	{
		if (instance == null)
		{
			instance = new SDKManager();
		}
		
		return instance;
	}
}
