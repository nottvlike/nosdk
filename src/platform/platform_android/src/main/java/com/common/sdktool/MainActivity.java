package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

public class MainActivity extends Activity implements ISDKCallback {
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

    @Override
    public void onInitSuccess() {

    }

    @Override
    public void onInitFailed() {

    }

    @Override
    public void onLoginSuccess(){

    }

    @Override
    public  void onLoginFailed() {

    }

    @Override
    public void onLoginCanceled() {

    }

    @Override
    public void onSwitchAccountSuccess() {

    }

    @Override
    public void onSwitchAccountFailed() {

    }

    @Override
    public void onSwitchAccountCanceled() {

    }

    @Override
    public void onLogoutSuccess() {

    }

    @Override
    public void onLogoutFailed() {

    }

    @Override
    public  void onPaySuccess() {

    }

    @Override
    public void onPayFailed() {

    }

    @Override
    public void onPayCanceled() {

    }

    @Override
    public void onExitSuccess() {
        finish();
        android.os.Process.killProcess(android.os.Process.myPid());
    }

    @Override
    public void onExitCancel() {

    }

    @Override
    public void onExitFailed() {

    }
}
