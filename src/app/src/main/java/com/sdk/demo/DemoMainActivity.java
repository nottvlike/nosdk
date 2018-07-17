package com.sdk.demo;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.Switch;
import android.widget.TextView;

import com.common.sdktool.CustomMethodType;
import com.common.sdktool.IExitListener;
import com.common.sdktool.ILoginListener;
import com.common.sdktool.ILogoutListener;
import com.common.sdktool.IPayListener;
import com.common.sdktool.ISwitchAccountListener;
import com.common.sdktool.LoginInfo;
import com.common.sdktool.MainActivity;
import com.common.sdktool.PayInfo;
import com.common.sdktool.SDKManager;

public class DemoMainActivity extends MainActivity {

    enum LoginState {
        Logout, Logined
    }

    int _goldCount = 0;

    TextView _loginStateTextView;
    TextView _goldCountTextView;
    TextView _userNameTextVIew;

    Button _loginBtn;
    Button _payBtn;
    Button _logoutBtn;
    Button _bbsBtn;
    Button _centerBtn;

    boolean _sdkHasExit = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.demo_main);

        _loginBtn = (Button) findViewById(R.id.mainLogin);
        _loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().login("", new ILoginListener() {
                    public void OnLoginSuccess() {
                        LoginInfo loginInfo = SDKManager.getInstance().getLoginInfo();
                        setUserName(loginInfo.userName);

                        setLoginState(LoginState.Logined);
                    }

                    public void OnLoginFailed() {
                        setUserName("");

                        setLoginState(LoginState.Logout);
                    }

                    public void OnLoginCanceled() {
                        setUserName("");

                        setLoginState(LoginState.Logout);
                    }
                });
            }
        });

        Button switchAccountBtn = (Button) findViewById(R.id.mainSwitchAccount);
        switchAccountBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().switchAccount("", new ISwitchAccountListener() {
                    @Override
                    public void OnSwitchAccountSuccess() {
                        LoginInfo loginInfo = SDKManager.getInstance().getLoginInfo();
                        setUserName(loginInfo.userName);

                        setLoginState(LoginState.Logined);
                    }

                    @Override
                    public void OnSwitchAccountFailed() {

                    }

                    @Override
                    public void OnSwitchAccountCanceled() {

                    }
                });
            }
        });

        _logoutBtn = (Button) findViewById(R.id.mainLogout);
        _logoutBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().logout("", new ILogoutListener() {
                    @Override
                    public void OnLogoutSuccess() {
                        setUserName("");

                        setLoginState(LoginState.Logout);
                    }

                    @Override
                    public void OnLogoutFailed() {

                    }
                });
            }
        });

        _payBtn = (Button) findViewById(R.id.mainPay);
        _payBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().pay(6, "CNY", "1", "6 gold",
                        "6 gold", "123456", "", "", new IPayListener() {
                            @Override
                            public void OnPaySuccess() {
                                PayInfo payInfo = SDKManager.getInstance().getPayInfo();
                                addGoldCount(payInfo.amount);
                            }

                            @Override
                            public void OnPayFailed() {

                            }

                            @Override
                            public void OnPayCanceled() {

                            }
                        });
            }
        });

        _bbsBtn = (Button) findViewById(R.id.mainBBS);
        _bbsBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().callCustomMethod(CustomMethodType.ShowBBS.value(), "");
            }
        });

        _centerBtn = (Button) findViewById(R.id.mainCenter);
        _centerBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().callCustomMethod(CustomMethodType.ShowCenter.value(), "");
            }
        });

        Switch hasExitSwitch = (Switch) findViewById(R.id.mainHasExit);
        _sdkHasExit = hasExitSwitch.isChecked();
        hasExitSwitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                _sdkHasExit = b;
            }
        });

        Button exitBtn = (Button) findViewById(R.id.mainExit);
        exitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().setSDKHasExit(_sdkHasExit);

                SDKManager.getInstance().exit(new IExitListener() {
                    @Override
                    public void OnExitSuccess() {
                        finish();

                        android.os.Process.killProcess(android.os.Process.myPid());
                    }

                    @Override
                    public void OnExitCancel() {

                    }

                    @Override
                    public void OnExitFailed() {

                    }
                });
            }
        });

        _loginStateTextView = (TextView) findViewById(R.id.mainLoginState);
        _userNameTextVIew = (TextView) findViewById(R.id.mainAccountName);
        _goldCountTextView = (TextView) findViewById(R.id.mainGoldCount);

        setLoginState(LoginState.Logout);
        addGoldCount(0);
        setUserName("");
    }

    void setUserName(String userName) {
        _userNameTextVIew.setText(userName);
    }

    void setLoginState(LoginState loginState) {
        if (loginState == LoginState.Logout) {
            _loginStateTextView.setText("Logout");

            _loginBtn.setEnabled(true);

            _logoutBtn.setEnabled(false);
            _payBtn.setEnabled(false);
            _bbsBtn.setEnabled(false);
            _centerBtn.setEnabled(false);
        }
        else {
            _loginStateTextView.setText("Logined");

            _loginBtn.setEnabled(false);

            _logoutBtn.setEnabled(true);
            _payBtn.setEnabled(true);
            _bbsBtn.setEnabled(true);
            _centerBtn.setEnabled(true);
        }
    }

    void addGoldCount(int count) {
        _goldCount += count;

        _goldCountTextView.setText(String.valueOf(_goldCount));
    }
}
