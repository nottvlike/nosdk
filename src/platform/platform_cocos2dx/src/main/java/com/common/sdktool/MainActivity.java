package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import org.cocos2dx.lib.Cocos2dxActivity;

public class MainActivity extends Cocos2dxActivity implements ISDKCallback {
    // Setup activity layout
    @Override protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        SDKManager.getInstance().setSDKCallback(this);
        SDKManager.getInstance().onCreate(this);
    }

    @Override protected void onNewIntent(Intent intent)
    {
        super.onNewIntent(intent);
    	SDKManager.getInstance().onNewIntent(intent);
    	
        setIntent(intent);
    }

    // Quit Unity
    @Override protected void onDestroy ()
    {
    	SDKManager.getInstance().onDestroy();
    	
        super.onDestroy();
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

    public native static void nativeOnInitSuccess(String param);
    public native static void nativeOnInitFailed(String param);

    public native static void nativeOnLoginSuccess(String userId, String userName, String token, String channelName,
                                            String channelLabel, String custom1, String custom2, String custom3);
    public native static void nativeOnLoginFailed(String param);
    public native static void nativeOnLoginCanceled();

    public native static void nativeOnSwitchAccountSuccess(String userId, String userName, String token, String channelName,
                                            String channelLabel, String custom1, String custom2, String custom3);
    public native static void nativeOnSwitchAccountFailed(String param);
    public native static void nativeOnSwitchAccountCanceled();

    public native static void nativeOnLogoutSuccess(String param);
    public native static void nativeOnLogoutFailed(String param);

    public native static void nativeOnPaySuccess(int amount, String productId, String orderId);
    public native static void nativeOnPayFailed(String param);
    public native static void nativeOnPayCanceled();

    public native static void nativeOnExitSuccess(boolean sdkHasExit);
    public native static void nativeOnExitFailed(String param);
    public native static void nativeOnExitCancel();

    @Override
    public void onInitSuccess() {
        nativeOnInitSuccess("");
    }

    @Override
    public void onInitFailed() {
        nativeOnInitFailed("");
    }

    @Override
    public void onLoginSuccess(){
        nativeOnLoginSuccess("", "", "", "",
                "", "", "", "");
    }

    @Override
    public  void onLoginFailed() {
        nativeOnLoginFailed("");
    }

    @Override
    public void onLoginCanceled() {
        nativeOnLoginCanceled();
    }

    @Override
    public void onSwitchAccountSuccess() {
        nativeOnSwitchAccountSuccess("", "", "", "",
                "", "", "", "");
    }

    @Override
    public void onSwitchAccountFailed() {
        nativeOnSwitchAccountFailed("");
    }

    @Override
    public void onSwitchAccountCanceled() {
        nativeOnSwitchAccountCanceled();
    }

    @Override
    public void onLogoutSuccess() {
        nativeOnLogoutSuccess("");
    }

    @Override
    public void onLogoutFailed() {
        nativeOnLogoutFailed("");
    }

    @Override
    public  void onPaySuccess() {
        nativeOnPaySuccess(6, "", "");
    }

    @Override
    public void onPayFailed() {
        nativeOnPayFailed("");
    }

    @Override
    public void onPayCanceled() {
        nativeOnPayCanceled();
    }

    @Override
    public void onExitSuccess() {
        nativeOnExitSuccess(SDKManager.getInstance().getSDKHasExit());
    }

    @Override
    public void onExitCancel() {
        nativeOnExitCancel();
    }

    @Override
    public void onExitFailed() {
        nativeOnExitFailed("");
    }
}
