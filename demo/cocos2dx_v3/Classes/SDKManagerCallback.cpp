#include <stdlib.h>
#include <jni.h>
#include <android/log.h>
#include "platform/android/jni/JniHelper.h"

#include "SDKManager.h"

NS_CC_BEGIN

extern "C" {

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnInitSuccess(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnInitSuccess(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnInitFailed(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnInitFailed(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnLoginSuccess(JNIEnv*  env, jobject thiz, jstring userId, 
        jstring userName, jstring token, jstring channelName, jstring channelLabel, jstring custom1, jstring custom2, jstring custom3) {
        SDKManager::sharedInstance()->OnLoginSuccess(JniHelper::jstring2string(userId).c_str(), JniHelper::jstring2string(userName).c_str(), JniHelper::jstring2string(token).c_str(),
            JniHelper::jstring2string(channelName).c_str(), JniHelper::jstring2string(channelLabel).c_str(), JniHelper::jstring2string(custom1).c_str(), JniHelper::jstring2string(custom2).c_str(),
            JniHelper::jstring2string(custom3).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnLoginFailed(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnLoginFailed(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnLoginCanceled(JNIEnv*  env, jobject thiz) {
        SDKManager::sharedInstance()->OnLoginCanceled();
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnSwitchAccountSuccess(JNIEnv*  env, jobject thiz, jstring userId, 
        jstring userName, jstring token, jstring channelName, jstring channelLabel, jstring custom1, jstring custom2, jstring custom3) {
        SDKManager::sharedInstance()->OnSwitchAccountSuccess(JniHelper::jstring2string(userId).c_str(), JniHelper::jstring2string(userName).c_str(), JniHelper::jstring2string(token).c_str(),
            JniHelper::jstring2string(channelName).c_str(), JniHelper::jstring2string(channelLabel).c_str(), JniHelper::jstring2string(custom1).c_str(), JniHelper::jstring2string(custom2).c_str(),
            JniHelper::jstring2string(custom3).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnSwitchAccountFailed(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnSwitchAccountFailed(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnSwitchAccountCanceled(JNIEnv*  env, jobject thiz) {
        SDKManager::sharedInstance()->OnSwitchAccountCanceled();
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnLogoutSuccess(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnLogoutSuccess(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnLogoutFailed(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnLogoutFailed(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnPaySuccess(JNIEnv*  env, jobject thiz, jint amount, jstring productId, jstring orderId) {
        SDKManager::sharedInstance()->OnPaySuccess(amount, JniHelper::jstring2string(productId).c_str(), JniHelper::jstring2string(orderId).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnPayFailed(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnPayFailed(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnPayCanceled(JNIEnv*  env, jobject thiz) {
        SDKManager::sharedInstance()->OnPayCanceled();
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnExitSuccess(JNIEnv*  env, jobject thiz, jboolean sdkHasExit) {
        SDKManager::sharedInstance()->OnExitSuccess(sdkHasExit == JNI_TRUE);
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnExitFailed(JNIEnv*  env, jobject thiz, jstring param) {
        SDKManager::sharedInstance()->OnExitFailed(JniHelper::jstring2string(param).c_str());
    }

    JNIEXPORT void JNICALL Java_com_common_sdktool_MainActivity_nativeOnExitCancel(JNIEnv*  env, jobject thiz) {
        SDKManager::sharedInstance()->OnExitCancel();
    }
}

NS_CC_END