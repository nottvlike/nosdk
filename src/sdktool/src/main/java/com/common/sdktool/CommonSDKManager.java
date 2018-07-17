package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;

public class CommonSDKManager {

    public final String TAG = "SDKTool";

    Activity _activity = null;
    String _channelName = "Default";

    LoginInfo _loginInfo = new LoginInfo();
    PlayerInfo _playerInfo = new PlayerInfo();
    PayInfo _payInfo = new PayInfo();

    IInitListener _initListener;
    ILoginListener _loginListener;
    ILogoutListener _logoutListener;
    ISwitchAccountListener _switchAccountListener;
    IExitListener _exitListener;
    IPayListener _payListener;

    public final LoginInfo getLoginInfo() {
        return _loginInfo;
    }

    public final PlayerInfo getPlayerInfo() {
        return _playerInfo;
    }

    public final PayInfo getPayInfo() {
        return _payInfo;
    }

    public ILoginListener getLoginListener() {
        return _loginListener;
    }

    public ISwitchAccountListener getSwitchAccountListener() {
        return _switchAccountListener;
    }

    public IExitListener getExitListener() {
        return _exitListener;
    }

    public IPayListener getPayListener() {
        return _payListener;
    }

    public void init(String custom, IInitListener listener) {
        _initListener = listener;
    }

    public void login(String custom, ILoginListener listener) {
        _loginListener = listener;
    }

    public void switchAccount(String custom,
                              ISwitchAccountListener listener) {
        _switchAccountListener = listener;
    }

    public void logout(String custom, ILogoutListener listener) {
        _logoutListener = listener;
    }

    public void pay(int amount, String currency,
                    String productId, String productName, String productDescription,
                    String orderId, String extraData, String CallbackUrl, IPayListener listener) {
        _payInfo.amount = amount;
        _payInfo.currency = currency;
        _payInfo.productId = productId;
        _payInfo.productName = productName;
        _payInfo.productDescription = productDescription;
        _payInfo.orderId = orderId;
        _payInfo.extra = extraData;
        _payInfo.callbackUrl = CallbackUrl;

        _payListener = listener;

        payImpl();
    }

    protected void payImpl() {

    }

    public void updatePlayerInfo(long playerId, String playerName, int serverId,
                                 String serverName, int playerLevel, int vipLevel, int gold,
                                 int coin, String gangId, String gangName) {
        _playerInfo.playerId = playerId;
        _playerInfo.playerName = playerName;
        _playerInfo.playerLevel = playerLevel;
        _playerInfo.serverId = serverId;
        _playerInfo.serverName = serverName;
        _playerInfo.vipLevel = vipLevel;
        _playerInfo.gold = gold;
        _playerInfo.coin = coin;
        _playerInfo.gangId = gangId;
        _playerInfo.gangName = gangName;
    }

    public void trackEvent(int trackEventType) {
    }

    public String getChannel() {
        return _channelName;
    }

    public void callCustomMethod(int methodType, String param) {
    }

    public void exit(IExitListener exitListener) {
        _exitListener = exitListener;
    }

    // MainActivity callback begin

    public void onCreate(Activity activity) {
        this._activity = activity;
    }

    public void onDestroy() {
        this._activity = null;
    }

    public void onNewIntent(Intent intent) {
    }

    public void onPause() {
    }

    public void onResume() {
    }

    public void onStart() {
    }

    public void onStop() {
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
    }

    public void onWindowFocusChanged(boolean hasFocus) {
    }

    // MainActivity callback end
}
