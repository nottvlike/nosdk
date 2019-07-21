using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class DemoPanel : MonoBehaviour
{
    public Button initBtn;
    public Button loginBtn;
    public Button logoutBtn;
    public Button payBtn;
    public Button exitBtn;

    void Awake()
    {
        initBtn.onClick.AddListener(OnInitClick);
        loginBtn.onClick.AddListener(OnLoginClick);
        logoutBtn.onClick.AddListener(OnLogoutClick);
        payBtn.onClick.AddListener(OnPayClick);
        exitBtn.onClick.AddListener(OnExitClick);
    }

    void OnInitClick()
    {
        SDKManager.SharedInstance().Init("");
    }

    void OnLoginClick()
    {
        SDKManager.SharedInstance().Login("");
    }

    void OnLogoutClick()
    {
        SDKManager.SharedInstance().Logout("");
    }

    void OnPayClick()
    {
        SDKManager.SharedInstance().Pay(6, "11123213", "RNY", "1", "6元宝", "6元宝", "", "");
    }

    void OnExitClick()
    {
        SDKManager.SharedInstance().Exit();
    }
}
