package com.common.sdktool;

public interface ILoginListener {
    void OnLoginSuccess();

    void OnLoginFailed();

    void OnLoginCanceled();
}
