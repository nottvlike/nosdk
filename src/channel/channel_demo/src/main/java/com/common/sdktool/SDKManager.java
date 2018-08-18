package com.common.sdktool;

import com.sdk.demo.DemoExitActivity;
import com.sdk.demo.DemoLoginActivity;
import com.sdk.demo.DemoPayActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;

public class SDKManager extends CommonSDKManager {
    static SDKManager _instance = null;

    boolean _isLogined = false;

    public SDKManager() {
        _channelName = "demo";
    }

    public boolean getIsLogined() {
        return _isLogined;
    }

    public void setIsLogined(boolean isLogined) {
        _isLogined = isLogined;
    }

    public static SDKManager getInstance() {
        if (_instance == null) {
            _instance = new SDKManager();
        }

        return _instance;
    }

    @Override
    public void login(String param) {
        super.login(param);

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(_activity, DemoLoginActivity.class);
                _activity.startActivity(intent);
            }
        });
    }

    @Override
    public void switchAccount(String param)
    {
        super.switchAccount(param);

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(_activity, DemoLoginActivity.class);
                _activity.startActivity(intent);
            }
        });
    }

    @Override
    public void logout(String param) {
        super.logout(param);

        _sdkCallback.onLogoutSuccess();
    }
    @Override
    protected void payImpl() {
        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(_activity, DemoPayActivity.class);
                _activity.startActivity(intent);
            }
        });
    }

    @Override
    public void exit() {
        super.exit();

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(_activity, DemoExitActivity.class);
                _activity.startActivity(intent);
            }
        });
    }
}
