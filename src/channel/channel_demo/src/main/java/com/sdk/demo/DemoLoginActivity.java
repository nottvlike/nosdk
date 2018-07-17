package com.sdk.demo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.common.sdktool.LoginInfo;
import com.common.sdktool.SDKManager;

import nottvlike.channel_default.R;

public class DemoLoginActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.demo_login);

        final TextView accountTextView = (TextView) findViewById(R.id.loginAccount);
        final TextView passwordTextView = (TextView) findViewById(R.id.loginPassword);
        final TextView descriptionTextView = (TextView) findViewById(R.id.loginDescription);
        final TextView titleTextView = (TextView) findViewById(R.id.loginTitle);
        titleTextView.setText("DemoLogin");

        Button goLoginBtn = (Button) findViewById(R.id.loginGo);
        goLoginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                String tips = "";

                if (accountTextView.getText().length() == 0) {
                    tips = "Account should not be empty!";
                }
                else if (passwordTextView.getText().length() == 0) {
                    tips = "Password should not be empty!";
                }

                if (tips.length() == 0) {

                    LoginInfo loginInfo = SDKManager.getInstance().getLoginInfo();
                    loginInfo.userName = accountTextView.getText().toString();

                    if (SDKManager.getInstance().getIsLogined()) {
                        SDKManager.getInstance().getSwitchAccountListener().OnSwitchAccountSuccess();
                    }
                    else {
                        SDKManager.getInstance().getLoginListener().OnLoginSuccess();
                    }

                    finish();
                }
                else {
                    descriptionTextView.setText(tips);
                }
            }
        });

        Button cancelBtn = (Button) findViewById(R.id.loginCancel);
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

    }
}
