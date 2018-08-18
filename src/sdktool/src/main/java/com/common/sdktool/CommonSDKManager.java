package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

public class CommonSDKManager {

    public final String TAG = "SDKTool";

    Activity _activity = null;
    String _channelName = "Default";

    LoginInfo _loginInfo = new LoginInfo();
    PlayerInfo _playerInfo = new PlayerInfo();
    PayInfo _payInfo = new PayInfo();

    ISDKCallback _sdkCallback;

    public final LoginInfo getLoginInfo() {
        return _loginInfo;
    }

    public final PlayerInfo getPlayerInfo() {
        return _playerInfo;
    }

    public final PayInfo getPayInfo() {
        return _payInfo;
    }

    public ISDKCallback getSDKListener() {
        return _sdkCallback;
    }
    public void setSDKCallback(ISDKCallback sdkListener) {
        _sdkCallback = sdkListener;
    }

    public void init(String param) {
        Log.d(TAG, "init " + param);
    }

    public void login(String param) {
        Log.d(TAG, "login " + param);
    }

    public void switchAccount(String param) {
        Log.d(TAG, "switchAccount " + param);
    }

    public void logout(String custom) { }

    public void pay(int amount, String currency,
                    String productId, String productName, String productDescription,
                    String orderId, String extraData, String CallbackUrl) {
        _payInfo.amount = amount;
        _payInfo.currency = currency;
        _payInfo.productId = productId;
        _payInfo.productName = productName;
        _payInfo.productDescription = productDescription;
        _payInfo.orderId = orderId;
        _payInfo.extra = extraData;
        _payInfo.callbackUrl = CallbackUrl;

        Log.d(TAG, "pay amount : " + amount + " productId : " + productId);

        payImpl();
    }

    protected void payImpl() {

    }

    public void updatePlayerInfo(String accountId, String playerId, String playerName, int playerLevel,
                                 String playerCreateTime, int serverId, String serverName, int vipLevel,
                                 int gold, int coin, String gangId, String gangName) {
        _playerInfo.accountId = accountId;
        _playerInfo.playerId = playerId;
        _playerInfo.playerName = playerName;
        _playerInfo.playerLevel = playerLevel;
        _playerInfo.playerCreateTime = playerCreateTime;
        _playerInfo.serverId = serverId;
        _playerInfo.serverName = serverName;
        _playerInfo.vipLevel = vipLevel;
        _playerInfo.gold = gold;
        _playerInfo.coin = coin;
        _playerInfo.gangId = gangId;
        _playerInfo.gangName = gangName;

        Log.d(TAG, "updatePlayerInfo");
    }

    public void trackEvent(int trackEventType) {
        Log.d(TAG, "trackEvent " + TrackEventType.valueOf(trackEventType).toString());
    }

    public String getChannel() {
        return _channelName;
    }

    public void callCustomMethod(int methodType, String param) {
        Log.d(TAG, "callCustomMethod " + CustomMethodType.valueOf(methodType).toString());
    }

    public void exit() {
        Log.d(TAG, "exit");
    }

    // MainActivity callback begin

    public void onCreate(Activity activity) {
        Log.d(TAG, "MainActivity onCreate");

        this._activity = activity;
    }

    public void onDestroy() {
        Log.d(TAG, "MainActivity onDestroy");

        this._activity = null;
    }

    public void onNewIntent(Intent intent) {
        Log.d(TAG, "MainActivity onNewIntent");
    }

    public void onPause() {
        Log.d(TAG, "MainActivity onPause");
    }

    public void onResume() {
        Log.d(TAG, "MainActivity onResume");
    }

    public void onStart() {
        Log.d(TAG, "MainActivity onStart");
    }

    public void onStop() {
        Log.d(TAG, "MainActivity onStop");
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        Log.d(TAG, "MainActivity onActivityResult " + requestCode);
    }

    public void onWindowFocusChanged(boolean hasFocus) {
        Log.d(TAG, "MainActivity onWindowFocusChanged");
    }

    // MainActivity callback end
}
