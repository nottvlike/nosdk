#ifndef __SDKMANAGER_H__
#define __SDKMANAGER_H__

#include "cocos2d.h"
#include <jni.h>
#include "platform/android/jni/JniHelper.h"

NS_CC_BEGIN

static const char* JAVA_SDK_MANAGER_CLASS = "com/common/sdktool/SDKManager";

class SDKManager
{
public:
	static SDKManager* sharedInstance();

	void Init(const char* param);
	void Login(const char* param);
	void SwitchAccount(const char* param);
	void Logout(const char* param);
	void Pay(int amount, const char* currency, const char* productId, const char* productName, 
		const char* productDesc, const char* orderId, const char* extraData, const char* callbackURL);
	void UpdatePlayerInfo(const char* accountId, const char* playerId, const char* playerName, int playerLevel, const char* playerCreateTime, 
		int serverId, const char* serverName, int vipLevel, int gold, int coin, const char* gangId, const char* gangName);
	void TrackEvent(int eventType);
	const char* GetChannel();
	void Exit();

	void OnInitSuccess(const char* param);
	void OnInitFailed(const char* param);

	void OnLoginSuccess(const char* userId, const char* userName, const char* token, const char* channelName,
		const char* channelLabel, const char* custom1, const char* custom2, const char* custom3);
    void OnLoginFailed(const char* message);
    void OnLoginCanceled();

    void OnSwitchAccountSuccess(const char* userId, const char* userName, const char* token, const char* channelName,
		const char* channelLabel, const char* custom1, const char* custom2, const char* custom3);
    void OnSwitchAccountFailed(const char* message);
    void OnSwitchAccountCanceled();

    void OnLogoutSuccess(const char* param);
    void OnLogoutFailed(const char* message);

    void OnPaySuccess(int ammount, const char* productId, const char* orderId);
    void OnPayFailed(const char* message);
    void OnPayCanceled();

    void OnExitSuccess(bool sdkHasExit);
    void OnExitCancel();
    void OnExitFailed(const char* message);

private:
	static jobject getSDKManager()
	{
        cocos2d::JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, JAVA_SDK_MANAGER_CLASS, "getInstance", "()Lcom/common/sdktool/SDKManager;")) 
        {
            return t.env->CallStaticObjectMethod(t.classID, t.methodID);
        }

        return nullptr;
	};
	static void CallVoidMethod(const char* methodName)
	{
        jobject sdkManagerObj = getSDKManager();

        cocos2d::JniMethodInfo method;
        if (JniHelper::getMethodInfo(method, JAVA_SDK_MANAGER_CLASS, methodName, "()V"))
        {
        	method.env->CallVoidMethod(sdkManagerObj, method.methodID);
        }
	};
	static void CallVoidMethod(const char* methodName, const char* param)
	{
        jobject sdkManagerObj = getSDKManager();

        cocos2d::JniMethodInfo method;
        if (JniHelper::getMethodInfo(method, JAVA_SDK_MANAGER_CLASS, methodName, "(Ljava/lang/String;)V"))
        {
        	jstring jparam = method.env->NewStringUTF(param);
        	method.env->CallVoidMethod(sdkManagerObj, method.methodID, jparam);
        	method.env->DeleteLocalRef(jparam);
        }
	};
	static void CallVoidMethod(const char* methodName, int param)
	{
        jobject sdkManagerObj = getSDKManager();

        cocos2d::JniMethodInfo method;
        if (JniHelper::getMethodInfo(method, JAVA_SDK_MANAGER_CLASS, methodName, "(I)V"))
        {
        	method.env->CallVoidMethod(sdkManagerObj, method.methodID, param);
        }
	};
	static void CallVoidMethod(const char* methodName, int amount, const char* currency, 
		const char* productId, const char* productName, const char* productDesc, const char* orderId, 
		const char* extraData, const char* callbackURL)
	{
        jobject sdkManagerObj = getSDKManager();

        cocos2d::JniMethodInfo method;
        if (JniHelper::getMethodInfo(method, JAVA_SDK_MANAGER_CLASS, methodName, 
        	"(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V"))
        {
            jstring jcurrency = method.env->NewStringUTF(currency);
        	jstring jproductId = method.env->NewStringUTF(productId);
        	jstring jproductName = method.env->NewStringUTF(productName);
        	jstring jproductDesc = method.env->NewStringUTF(productDesc);
        	jstring jorderId = method.env->NewStringUTF(orderId);
        	jstring jextraData = method.env->NewStringUTF(extraData);
        	jstring jcallbackURL = method.env->NewStringUTF(callbackURL);

        	method.env->CallVoidMethod(sdkManagerObj, method.methodID, amount, jcurrency, jproductId, jproductName, 
        		jproductDesc, jorderId, jextraData, jcallbackURL);

        	method.env->DeleteLocalRef(jcurrency);
        	method.env->DeleteLocalRef(jproductId);
        	method.env->DeleteLocalRef(jproductName);
        	method.env->DeleteLocalRef(jproductDesc);
        	method.env->DeleteLocalRef(jorderId);
        	method.env->DeleteLocalRef(jextraData);
        	method.env->DeleteLocalRef(jcallbackURL);
        }
	};

	static void CallVoidMethod(const char* methodName, const char* accountId, const char* playerId, const char* playerName, int playerLevel, 
		const char* playerCreateTime, int serverId, const char* serverName, int vipLevel, int gold, int coin, const char* gangId, const char* gangName)
	{
        jobject sdkManagerObj = getSDKManager();

        cocos2d::JniMethodInfo method;
        if (JniHelper::getMethodInfo(method, JAVA_SDK_MANAGER_CLASS, methodName, 
        	"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;IIILjava/lang/String;Ljava/lang/String;)V"))
        {
        	jstring jaccountId = method.env->NewStringUTF(accountId);
        	jstring jplayerId = method.env->NewStringUTF(playerId);
        	jstring jplayerName = method.env->NewStringUTF(playerName);
			jstring jplayerCreateTime = method.env->NewStringUTF(playerCreateTime);
        	jstring jserverName = method.env->NewStringUTF(serverName);
        	jstring jgangId = method.env->NewStringUTF(gangId);
        	jstring jgangName = method.env->NewStringUTF(gangName);

        	method.env->CallVoidMethod(sdkManagerObj, method.methodID, jaccountId, jplayerId, jplayerName, playerLevel, 
				jplayerCreateTime, serverId, jserverName, vipLevel, gold, coin, jgangId, jgangName);

        	method.env->DeleteLocalRef(jaccountId);
        	method.env->DeleteLocalRef(jplayerId);
        	method.env->DeleteLocalRef(jplayerName);
			method.env->DeleteLocalRef(jplayerCreateTime);
        	method.env->DeleteLocalRef(jserverName);
        	method.env->DeleteLocalRef(jgangId);
        	method.env->DeleteLocalRef(jgangName);
        }
	};

	const char* CallStringMethod(const char* methodName)
	{
		jobject sdkManagerObj = getSDKManager();

        cocos2d::JniMethodInfo method;
        if (JniHelper::getMethodInfo(method, JAVA_SDK_MANAGER_CLASS, methodName, "()Ljava/lang/String;"))
        {
        	jstring jret = (jstring)method.env->CallObjectMethod(sdkManagerObj, method.methodID);
        	return JniHelper::jstring2string(jret).c_str();
        }

        return "";
	};
};

NS_CC_END

#endif // __SDKMANAGER_H__
