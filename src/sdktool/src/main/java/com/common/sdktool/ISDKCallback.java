package com.common.sdktool;

public interface ISDKCallback {
    void onInitSuccess();
    void onInitFailed(String message);

    void onLoginSuccess();
    void onLoginFailed(String message);
    void onLoginCanceled();

    void onSwitchAccountSuccess();
    void onSwitchAccountFailed(String message);
    void onSwitchAccountCanceled();

    void onLogoutSuccess();
    void onLogoutFailed(String message);

    void onPaySuccess();
    void onPayFailed(String message);
    void onPayCanceled();

    void onExitSuccess(boolean sdkHasExit);
    void onExitFailed(String message);
    void onExitCanceled();
}
