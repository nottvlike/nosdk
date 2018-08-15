package com.common.sdktool;

public interface ISDKCallback {
    void onInitSuccess();
    void onInitFailed();

    void onLoginSuccess();
    void onLoginFailed();
    void onLoginCanceled();

    void onSwitchAccountSuccess();
    void onSwitchAccountFailed();
    void onSwitchAccountCanceled();

    void onLogoutSuccess();
    void onLogoutFailed();

    void onPaySuccess();
    void onPayFailed();
    void onPayCanceled();

    void onExitSuccess();
    void onExitCancel();
    void onExitFailed();
}
