#include "SDKManager.h"

NS_CC_BEGIN

#define  LOG_TAG    "SDKManager"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)

static SDKManager* instance = nullptr;

SDKManager* SDKManager::sharedInstance()
{
    if (instance == nullptr)
    {
        instance = new SDKManager();
    }

    return instance;
}

void SDKManager::Init(const char* param)
{
    CallVoidMethod("init", param);
}

void SDKManager::Login(const char* param)
{
    CallVoidMethod("login", param);
}

void SDKManager::SwitchAccount(const char* param)
{
    CallVoidMethod("switchAccount", param);
}

void SDKManager::Logout(const char* param)
{
    CallVoidMethod("logout", param);
}

void SDKManager::Pay(int amount, const char* currency, const char* productId, const char* productName, 
    const char* productDesc, const char* orderId, const char* extraData, const char* callbackURL)
{
    CallVoidMethod("pay", amount, currency, productId, productName, productDesc, orderId, extraData, callbackURL);
}

void SDKManager::UpdatePlayerInfo(const char* accountId, const char* playerId, const char* playerName, int playerLevel, const char* playerCreateTime, 
    int serverId, const char* serverName, int vipLevel, int gold, int coin, const char* gangId, const char* gangName)
{
    CallVoidMethod("updatePlayerInfo", accountId, playerId, playerName, playerLevel, playerCreateTime, serverId, serverName, vipLevel, gold, coin, gangId, gangName);
}

void SDKManager::TrackEvent(int eventType)
{
    CallVoidMethod("trackEvent", eventType);
}

const char* SDKManager::GetChannel()
{
    return CallStringMethod("getChannel");
}

void SDKManager::Exit()
{
    CallVoidMethod("exit");
}

void SDKManager::OnInitSuccess(const char* param)
{
    LOGD("OnInitSuccess");
}

void SDKManager::OnInitFailed(const char* param)
{
    LOGD("OnInitFailed");
}

void SDKManager::OnLoginSuccess(const char* userId, const char* userName, const char* token, const char* channelName,
    const char* channelLabel, const char* custom1, const char* custom2, const char* custom3)
{
    LOGD("OnLoginSuccess");
}

void SDKManager::OnLoginFailed(const char* message)
{
    LOGD("OnLoginFailed");
}

void SDKManager::OnLoginCanceled()
{
    LOGD("OnLoginCanceled");
}

void SDKManager::OnSwitchAccountSuccess(const char* userId, const char* userName, const char* token, const char* channelName,
    const char* channelLabel, const char* custom1, const char* custom2, const char* custom3)
{
    LOGD("OnSwitchAccountSuccess");
}

void SDKManager::OnSwitchAccountFailed(const char* message)
{
    LOGD("OnSwitchAccountFailed");
}

void SDKManager::OnSwitchAccountCanceled()
{
    LOGD("OnSwitchAccountCanceled");
}

void SDKManager::OnLogoutSuccess(const char* param)
{
    LOGD("OnLogoutSuccess");
}

void SDKManager::OnLogoutFailed(const char* message)
{
    LOGD("OnLogoutFailed");
}

void SDKManager::OnPaySuccess(int ammount, const char* productId, const char* orderId)
{
    LOGD("OnPaySuccess");
}

void SDKManager::OnPayFailed(const char* message)
{
    LOGD("OnPayFailed");
}

void SDKManager::OnPayCanceled()
{
    LOGD("OnPayCanceled");
}

void SDKManager::OnExitSuccess(bool sdkHasExit)
{
    LOGD("OnExitSuccess");
}

void SDKManager::OnExitCancel()
{
    LOGD("OnExitCancel");
}

void SDKManager::OnExitFailed(const char* message)
{
    LOGD("OnExitFailed");
}

NS_CC_END