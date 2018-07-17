package com.common.sdktool;

public interface ISwitchAccountListener {
    void OnSwitchAccountSuccess();

    void OnSwitchAccountFailed();

    void OnSwitchAccountCanceled();
}
