package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.widget.Toast;

import java.util.HashMap;
import java.util.Map;

import cn.uc.gamesdk.UCGameSdk;
import cn.uc.gamesdk.even.SDKEventKey;
import cn.uc.gamesdk.even.SDKEventReceiver;
import cn.uc.gamesdk.even.Subscribe;
import cn.uc.gamesdk.exception.AliLackActivityException;
import cn.uc.gamesdk.exception.AliNotInitException;
import cn.uc.gamesdk.open.GameParamInfo;
import cn.uc.gamesdk.open.OrderInfo;
import cn.uc.gamesdk.open.UCOrientation;
import cn.uc.gamesdk.param.SDKParamKey;
import cn.uc.gamesdk.param.SDKParams;
import cn.uc.gamesdk.unity3d.UCSdkConfig;

public class SDKManager extends CommonSDKManager {
    static SDKManager _instance = null;

    boolean _isLogined = false;

    SDKEventReceiver receiver = new SDKEventReceiver() {

        @Subscribe(event = SDKEventKey.ON_INIT_SUCC)
        private void onInitSucc() {
            _sdkCallback.onInitSuccess();
        }

        @Subscribe(event = SDKEventKey.ON_INIT_FAILED)
        private void onInitFailed(String data) {
            //初始化失败
            _sdkCallback.onInitFailed(data);
        }

        @Subscribe(event = SDKEventKey.ON_LOGIN_SUCC)
        private void onLoginSucc(String sid) {
            LoginInfo loginInfo = SDKManager.getInstance().getLoginInfo();
            loginInfo.userId = sid;

            _sdkCallback.onLoginSuccess();
        }

        @Subscribe(event = SDKEventKey.ON_LOGIN_FAILED)
        private void onLoginFailed(String desc) {
            _sdkCallback.onLoginFailed(desc);
        }

        @Subscribe(event = SDKEventKey.ON_CREATE_ORDER_SUCC)
        private void onCreateOrderSucc(OrderInfo orderInfo) {
            _sdkCallback.onPaySuccess();
        }

        @Subscribe(event = SDKEventKey.ON_PAY_USER_EXIT)
        private void onPayUserExit(OrderInfo orderInfo) {
            _sdkCallback.onPayCanceled();
        }


        @Subscribe(event = SDKEventKey.ON_LOGOUT_SUCC)
        private void onLogoutSucc() {
            Toast.makeText(_activity, "logout succ", Toast.LENGTH_SHORT).show();
            _sdkCallback.onLogoutSuccess();
        }

        @Subscribe(event = SDKEventKey.ON_LOGOUT_FAILED)
        private void onLogoutFailed() {
            _sdkCallback.onLogoutFailed("");
        }

        @Subscribe(event = SDKEventKey.ON_EXIT_SUCC)
        private void onExit(String desc) {
            _sdkCallback.onExitSuccess(true);
        }

        @Subscribe(event = SDKEventKey.ON_EXIT_CANCELED)
        private void onExitCanceled(String desc) {
            _sdkCallback.onExitCanceled();
        }
    };

    String _pullUpInfo = "";

    public SDKManager() {
        _channelName = "uc";
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
    public void init(String param) {
        super.init(param);

        GameParamInfo gameParamInfo = new GameParamInfo();
        //gameParamInfo.setCpId(UCSdkConfig.cpId);已废用
        gameParamInfo.setGameId(UCSdkConfig.gameId);
        //gameParamInfo.setServerId(UCSdkConfig.serverId);已废用
        gameParamInfo.setOrientation(UCOrientation.PORTRAIT);

        SDKParams sdkParams = new SDKParams();

        sdkParams.put(SDKParamKey.GAME_PARAMS, gameParamInfo);
        sdkParams.put(SDKParamKey.PULLUP_INFO, _pullUpInfo);

        //联调环境已经废用
        //  sdkParams.put(SDKParamKey.DEBUG_MODE, UCSdkConfig.debugMode);
        try {
            UCGameSdk.defaultSdk().initSdk(_activity, sdkParams);

        } catch (AliLackActivityException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void login(String param) {
        super.login(param);

        try {
            UCGameSdk.defaultSdk().login(_activity, null);
        } catch (AliLackActivityException e) {
            e.printStackTrace();
        } catch (AliNotInitException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void switchAccount(String param)
    {
        super.switchAccount(param);

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
            }
        });
    }

    @Override
    public void logout(String param) {
        super.logout(param);

        try {
            UCGameSdk.defaultSdk().logout(_activity, null);
        } catch (AliLackActivityException e) {
            e.printStackTrace();
        } catch (AliNotInitException e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void payImpl() {
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put(SDKParamKey.CALLBACK_INFO, _payInfo.extra);
        paramMap.put(SDKParamKey.NOTIFY_URL, _payInfo.callbackUrl);
        paramMap.put(SDKParamKey.AMOUNT, String.valueOf(_payInfo.amount));
        paramMap.put(SDKParamKey.CP_ORDER_ID, _payInfo.orderId);
        paramMap.put(SDKParamKey.ACCOUNT_ID, _playerInfo.accountId);
        paramMap.put(SDKParamKey.SIGN_TYPE, "MD5");

        SDKParams sdkParams = new SDKParams();

        Map<String, Object> map = new HashMap<String, Object>();
        map.putAll(paramMap);
        sdkParams.putAll(map);

        String sign = "71a67060ea322937a4be242709978a93";
        sdkParams.put(SDKParamKey.SIGN, sign);
        try {
            UCGameSdk.defaultSdk().pay(_activity, sdkParams);
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(_activity, "charge failed - Exception: "+e.toString(), Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void exit() {
        super.exit();

        try {
            UCGameSdk.defaultSdk().exit(_activity, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void trackEvent(int trackEventType) {
        super.trackEvent(trackEventType);

        TrackEventType eventType = TrackEventType.valueOf(trackEventType);

        if (eventType == TrackEventType.CreatePlayer || eventType == TrackEventType.EnterGame
                || eventType == TrackEventType.LevelUp) {
            SDKParams sdkParams = new SDKParams();
            sdkParams.put(SDKParamKey.STRING_ROLE_ID, _playerInfo.playerId);
            sdkParams.put(SDKParamKey.STRING_ROLE_NAME, _playerInfo.playerName);
            sdkParams.put(SDKParamKey.LONG_ROLE_LEVEL, _playerInfo.playerLevel);
            sdkParams.put(SDKParamKey.LONG_ROLE_CTIME, System.currentTimeMillis() / 1000);
            sdkParams.put(SDKParamKey.STRING_ZONE_ID, _playerInfo.serverId);
            sdkParams.put(SDKParamKey.STRING_ZONE_NAME, _playerInfo.serverName);

            try {
                UCGameSdk.defaultSdk().submitRoleData(_activity, sdkParams);
                Toast.makeText(_activity, "数据已提交，查看数据是否正确，请到开放平台接入联调工具查看", Toast.LENGTH_SHORT).show();
            } catch (AliNotInitException e) {
                e.printStackTrace();
            } catch (AliLackActivityException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onCreate(Activity activity) {
        super.onCreate(activity);

        Intent intent = activity.getIntent();
        _pullUpInfo = intent.getDataString();
        if (TextUtils.isEmpty(_pullUpInfo)) {
            _pullUpInfo = intent.getStringExtra("data");
        }

        UCGameSdk.defaultSdk().registerSDKEventReceiver(receiver);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        UCGameSdk.defaultSdk().unregisterSDKEventReceiver(receiver);
        receiver = null;
    }

}
