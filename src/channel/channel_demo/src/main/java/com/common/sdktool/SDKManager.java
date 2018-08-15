package com.common.sdktool;

import com.sdk.demo.DemoExitActivity;
import com.sdk.demo.DemoLoginActivity;
import com.sdk.demo.DemoPayActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;

public class SDKManager extends CommonSDKManager {
    static SDKManager _instance = null;

    boolean _sdkHasExit = true;
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

    public boolean getSDKHasExit() {
        return true;
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

        if (_sdkHasExit) {
            _activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Intent intent = new Intent(_activity, DemoExitActivity.class);
                    _activity.startActivity(intent);
                }
            });
        }
        else {
            _activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    new AlertDialog.Builder(_activity)
                            .setTitle("Warning")
                            .setMessage("Are you sure to exit!")
                            .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    _sdkCallback.onExitCancel();
                                }
                            })
                            .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    _sdkCallback.onExitSuccess();
                                }
                            })
                            .create().show();
                }
            });
        }
    }
}
