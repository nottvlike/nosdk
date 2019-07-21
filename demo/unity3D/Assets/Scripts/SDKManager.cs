using UnityEngine;
using System.Collections;

public class SDKManager : MonoBehaviour
{
    public enum TrackEventType
    {
        CreatePlayer = 0,
        EnterGame = 1,
        LevelUp = 2,
        VipLevelUp = 3,
        ExitGame = 4
    }

    public enum CustomMethodType
    {
        ShowCenter = 0,
        ShowBBS = 1
    }

    public struct LoginInfo
    {
        public string userId;
        public string userName;
        public string token;
        public string channelName;
        public string channelLabel;
        public string custom1;
        public string custom2;
        public string custom3;
    }

    const string SDK_OBJECT_NAME = "SDKManager";
    const char SEPRATE_FLAG = '#';

    static SDKManager _instance = null;

    LoginInfo _loginInfo = new LoginInfo();

    public static SDKManager SharedInstance()
    {
        if (_instance == null)
        {
            var sdkObject = new GameObject(SDK_OBJECT_NAME);
            _instance = sdkObject.AddComponent<SDKManager>();
        }

        return _instance;
    }

    public void Init(string param)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("init", param);
            }
        }
#endif
    }

    public void Login(string param)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("login", param);
            }
        }
#endif
    }

    public void Logout(string param)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("logout", param);
            }
        }
#endif
    }

    public void Pay(int amount, string orderId, string currency, string productId, string productName, string productDescription, string extraInfo, string callbackURL)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("pay", amount, currency, productId, productName, productDescription, orderId, extraInfo, callbackURL);
            }
        }
#endif
    }

    public void Exit()
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("exit");
            }
        }
#endif
    }

    public void UpdatePlayerInfo(string accountId, string playerId, string playerName, int playerLevel, string playerCreateTime, 
        int serverId, string serverName,  int vipLevel, int gold, int coin, string gangId, string gangName)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("updatePlayerInfo", accountId, playerId, playerName, playerLevel, playerCreateTime, serverId, serverName, vipLevel, gold, coin, gangId, gangName);
            }
        }
#endif
    }

    public void TrackEvent(TrackEventType eventType)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("trackEvent", (int)eventType);
            }
        }
#endif
    }

    public void CallCustomMethod(CustomMethodType methodType, string param)
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                jo.Call("callCustomMethod", (int)methodType, param);
            }
        }
#endif
    }

    public string GetChannel()
    {
#if UNITY_ANDROID
        using (var jc = new AndroidJavaClass("com.common.sdktool.SDKManager"))
        {
            using (var jo = jc.CallStatic<AndroidJavaObject>("getInstance"))
            {
                return jo.Call<string>("getChannel");
            }
        }
#endif

        return "default";
    }

    void OnInitSuccess(string messsage)
    {

    }

    void OnInitFailed(string message)
    {

    }

    void OnLoginSuccess(string message)
    {
        var paramList = message.Split(SEPRATE_FLAG);
        if (paramList.Length < 8)
        {
            Debug.LogWarning("OnLoginSuccess : wrong param count!");
            return;
        }

        _loginInfo.userName = paramList[0];
        _loginInfo.userId = paramList[1];
        _loginInfo.token = paramList[2];
        _loginInfo.channelLabel = paramList[3];
        _loginInfo.channelName = paramList[4];
        _loginInfo.custom1 = paramList[5];
        _loginInfo.custom2 = paramList[6];
        _loginInfo.custom3 = paramList[7];

        Debug.Log(string.Format("Login success, userName : {0}, userId : {1}, token : {2}, channelLabel : {3}, channelName : {4}", 
            _loginInfo.userName, _loginInfo.userId, _loginInfo.token, _loginInfo.channelLabel, _loginInfo.channelName));
    }

    void OnLoginFailed(string message)
    {
        Debug.Log("Login failed " + message);
    }

    void OnLoginCanceled(string message)
    {

    }

    void OnSwitchAccountSuccess(string message)
    {
        var paramList = message.Split(SEPRATE_FLAG);
        if (paramList.Length < 8)
        {
            Debug.LogWarning("OnLoginSuccess : wrong param count!");
            return;
        }

        _loginInfo.userName = paramList[0];
        _loginInfo.userId = paramList[1];
        _loginInfo.token = paramList[2];
        _loginInfo.channelLabel = paramList[3];
        _loginInfo.channelName = paramList[4];
        _loginInfo.custom1 = paramList[5];
        _loginInfo.custom2 = paramList[6];
        _loginInfo.custom3 = paramList[7];

        Debug.Log(string.Format("SwitchAccount success, userName : {0}, userId : {1}, token : {2}, channelLabel : {3}, channelName : {4}",
            _loginInfo.userName, _loginInfo.userId, _loginInfo.token, _loginInfo.channelLabel, _loginInfo.channelName));
    }

    void OnSwitchAccountFailed(string message)
    {
        Debug.Log("SwitchAccount failed " + message);
    }

    void OnSwitchAccountCanceled(string message)
    {

    }

    void OnLogoutSuccess(string message)
    {
        Debug.Log("OnLogoutSuccess");
    }

    void OnLogoutFailed(string message)
    {
        Debug.Log("OnLogoutFailed");
    }

    void OnPaySuccess(string message)
    {
        var paramList = message.Split(SEPRATE_FLAG);
        if (paramList.Length < 4)
        {
            Debug.LogWarning("OnLoginSuccess : wrong param count!");
            return;
        }

        Debug.Log(string.Format("Pay success, amount : {0}, productId : {1}, orderId : {2}, currency : {3}",
            paramList[0], paramList[1], paramList[2], paramList[3]));
    }

    void OnPayFailed(string message)
    {
        Debug.Log("Pay failed " + message);
    }

    void OnPayCanceled(string message)
    {
        Debug.Log("Pay canceled ");
    }

    void OnExitSuccess(string message)
    {
        if (message.CompareTo("1") == 0)
        {
            // 保存进度，退出游戏。
        }
        else
        {
            // 游戏需要自己处理退出逻辑，例如弹出退出界面等。
        }

        Debug.Log("OnExitSuccess");
    }

    void OnExitFailed(string message)
    {
        Debug.Log("OnExitFailed");
    }

    void OnExitCanceled(string message)
    {
        Debug.Log("OnExitCanceled");
    }
}
