package com.common.sdktool;

import com.unity3d.player.UnityPlayer;
import com.unity3d.player.UnityPlayerActivity;

import android.content.Intent;
import android.os.Bundle;

public class MainActivity extends UnityPlayerActivity implements ISDKCallback {

    final String UNITY_OBJECT = "SDKManager";
    final char SEPARATE_CHAR = '#';

    // Setup activity layout
    @Override protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        SDKManager.getInstance().setSDKCallback(this);
        SDKManager.getInstance().onCreate(this);
    }

    @Override protected void onNewIntent(Intent intent)
    {
    	SDKManager.getInstance().onNewIntent(intent);
    	
        // To support deep linking, we need to make sure that the client can get access to
        // the last sent intent. The clients access this through a JNI api that allows them
        // to get the intent set on launch. To update that after launch we have to manually
        // replace the intent with the one caught here.
        setIntent(intent);
    }

    // Quit Unity
    @Override protected void onDestroy ()
    {
        super.onDestroy();

    	SDKManager.getInstance().onDestroy();
    }

    // Pause Unity
    @Override protected void onPause()
    {
        super.onPause();

        SDKManager.getInstance().onPause();
    }

    // Resume Unity
    @Override protected void onResume()
    {
        super.onResume();

        SDKManager.getInstance().onResume();
    }

    @Override protected void onStart()
    {
        super.onStart();

        SDKManager.getInstance().onStart();
    }

    @Override protected void onStop()
    {
        super.onStop();

        SDKManager.getInstance().onStop();
    }

    // Notify Unity of the focus change.
    @Override public void onWindowFocusChanged(boolean hasFocus)
    {
        super.onWindowFocusChanged(hasFocus);

        SDKManager.getInstance().onWindowFocusChanged(hasFocus);
    }

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		super.onActivityResult(requestCode, resultCode, data);
		
		SDKManager.getInstance().onActivityResult(requestCode, resultCode, data);
	}

    @Override
    public void onInitSuccess() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnInitSuccess", "");
    }

    @Override
    public void onInitFailed(String message) {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnInitFailed", message);
    }

    @Override
    public void onLoginSuccess() {
        LoginInfo info  = SDKManager.getInstance().getLoginInfo();
        StringBuilder strBuilder = new StringBuilder();
        String loginResult = strBuilder.append(info.userName).append(SEPARATE_CHAR)
                .append(info.userId).append(SEPARATE_CHAR)
                .append(info.token).append(SEPARATE_CHAR)
                .append(info.channelLabel).append(SEPARATE_CHAR)
                .append(info.channelName).append(SEPARATE_CHAR)
                .append(info.custom1).append(SEPARATE_CHAR)
                .append(info.custom2).append(SEPARATE_CHAR)
                .append(info.custom3).append(SEPARATE_CHAR).toString();

        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnLoginSuccess", loginResult);
    }

    @Override
    public void onLoginFailed(String message) {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnLoginFailed", "");
    }

    @Override
    public void onLoginCanceled() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnLoginCanceled", "");
    }

    @Override
    public void onSwitchAccountSuccess() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnSwitchAccountSuccess", "");
    }

    @Override
    public void onSwitchAccountFailed(String message) {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnSwitchAccountFailed", message);
    }

    @Override
    public void onSwitchAccountCanceled() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnSwitchAccountCanceled", "");
    }

    @Override
    public void onLogoutSuccess() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnLogout", "");
    }

    @Override
    public void onLogoutFailed(String message) {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnLogoutFailed", message);
    }

    @Override
    public void onPaySuccess() {
        PayInfo info  = SDKManager.getInstance().getPayInfo();
        StringBuilder strBuilder = new StringBuilder();
        String payResult = strBuilder.append(info.amount).append(SEPARATE_CHAR)
                .append(info.productId).append(SEPARATE_CHAR)
                .append(info.orderId).append(SEPARATE_CHAR)
                .append(info.currency).append(SEPARATE_CHAR).toString();

        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnPaySuccess", payResult);
    }

    @Override
    public void onPayFailed(String message) {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnPayFailed", "");
    }

    @Override
    public void onPayCanceled() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnPayCanceled", "");
    }

    @Override
    public void onExitSuccess(boolean sdkHasExit) {
        int result = sdkHasExit ? 1 : 0;
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnExit", String.valueOf(result));
    }

    @Override
    public void onExitCancel() {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnExitCancel", "");
    }

    @Override
    public void onExitFailed(String message) {
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, "OnExitFailed", message);
    }
}
