package com.common.sdktool;

import com.sdk.demo.DemoExitActivity;
import com.sdk.demo.DemoLoginActivity;
import com.sdk.demo.DemoPayActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;

public class SDKManager extends CommonSDKManager {
    static SDKManager _instance = null;

    boolean _sdkHasExit = false;
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

    public void setSDKHasExit(boolean hasExit) {
        _sdkHasExit = hasExit;
    }

    @Override
    public void login(String param, ILoginListener loginListener) {
        super.login(param, loginListener);

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(_activity, DemoLoginActivity.class);
                _activity.startActivity(intent);
            }
        });
    }

    @Override
    public void switchAccount(String param, ISwitchAccountListener switchAccountListener)
    {
        super.switchAccount(param, switchAccountListener);

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(_activity, DemoLoginActivity.class);
                _activity.startActivity(intent);
            }
        });
    }

    @Override
    public void logout(String param, ILogoutListener logoutListener) {
        super.logout(param, logoutListener);

        _logoutListener.OnLogoutSuccess();
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
    public void exit(final IExitListener exitListener) {
        super.exit(exitListener);

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
            new AlertDialog.Builder(_activity)
                    .setTitle("Warning")
                    .setMessage("Are you sure to exit!")
                    .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            exitListener.OnExitCancel();
                        }
                    })
                    .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            exitListener.OnExitSuccess();
                        }
                    })
                    .create().show();
        }
    }
}
