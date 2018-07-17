package com.common.sdktool;

public interface IExitListener {
    void OnExitSuccess();

    void OnExitCancel();

    void OnExitFailed();
}
