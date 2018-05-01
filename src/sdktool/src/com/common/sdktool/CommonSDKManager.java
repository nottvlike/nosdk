package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;

public class CommonSDKManager {

	Activity activity = null;
	
	public final String TAG = "SDKTool";
	
	public String CHANNEL = "Default";

	LoginData loginData = new LoginData();
	RoleData roleData = new RoleData();
	PayData payData = new PayData();

	public final LoginData getLoginData() {
		return loginData;
	}

	public final RoleData getRoleData() {
		return roleData;
	}

	public final PayData getPayData() {
		return payData;
	}

	public void init(String custom, InitListener listener) {
	}

	public void login(String custom, LoginListener listener) {
	}

	public void switchAccount(Activity activity,
			SwitchAccountListener listener, String custom) {
	}

	public void logout(String custom, LogoutListener listener) {
	}

	public void pay(int amount, String currency,
			String productId, String productName, String productDescription,
			String orderId, String extraData, String CallbackUrl, PayListener listener) {
		payData.amount = amount;
		payData.currency = currency;
		payData.productId = productId;
		payData.productName = productName;
		payData.productDescription = productDescription;
		payData.orderId = orderId;
		payData.extra = extraData;
		payData.callbackUrl = CallbackUrl;
		
		payImpl();
	}
	
	void payImpl()
	{
		
	}
	
	public void sendExtraData(int dataType, long playerId, String playerName, int serverId,
			String serverName, int playerLevel, int vipLevel, int gold,
			int coin, String gangId, String gangName) {
		roleData.dataType = ExtraDataType.valueOf(dataType);
		roleData.playerId = playerId;
		roleData.playerName = playerName;
		roleData.playerLevel = playerLevel;
		roleData.serverId = serverId;
		roleData.serverName = serverName;
		roleData.vipLevel = vipLevel;
		roleData.gold = gold;
		roleData.coin = coin;
		roleData.gangId = gangId;
		roleData.gangName = gangName;
		
		sendExtraDataImpl();
	}
	
	void sendExtraDataImpl()
	{
	}
	
	public String getChannel() {
		return CHANNEL;
	}
	
	public void CallOtherMethod(OtherMethodType methodType, String param)
	{
	}
	
	// MainActivity callback begin

	public void onCreate(Activity activity)
	{
		this.activity = activity;
	}
	
	public void onDestroy()
	{
		this.activity = null;
	}
	
	public void onNewIntent(Intent intent)
	{
	}
	
	public void onPause()
	{
	}
	
    public void onResume()
    {
    }

    public void onStart()
    {
    }

    public void onStop()
    {
    }
    
    public void onActivityResult(int requestCode, int resultCode, Intent data)
    {
    }
    
    public void onWindowFocusChanged(boolean hasFocus)
    {
    }
    
    // MainActivity callback end
}
