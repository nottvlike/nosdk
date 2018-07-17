package com.common.sdktool;

public interface IPayListener {
    void OnPaySuccess();

    void OnPayFailed();

    void OnPayCanceled();
}
