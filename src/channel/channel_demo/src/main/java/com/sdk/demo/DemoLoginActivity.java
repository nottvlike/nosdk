package com.sdk.demo;

import android.app.Activity;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.common.sdktool.LoginInfo;
import com.common.sdktool.SDKManager;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import nottvlike.channel_default.R;

public class DemoLoginActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Resources res = getResources();
        setContentView(res.getIdentifier("demo_login", "layout", getPackageName()));

        final TextView accountTextView = (TextView) findViewById(res.getIdentifier("loginAccount", "id", getPackageName()));
        final TextView passwordTextView = (TextView) findViewById(res.getIdentifier("loginPassword", "id", getPackageName()));
        final TextView descriptionTextView = (TextView) findViewById(res.getIdentifier("loginDescription", "id", getPackageName()));
        final TextView titleTextView = (TextView) findViewById(res.getIdentifier("loginTitle", "id", getPackageName()));
        titleTextView.setText("DemoLogin");

        final Activity tmpActivity = this;

        Button goLoginBtn = (Button) findViewById(res.getIdentifier("loginGo", "id", getPackageName()));
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
                    final String userName = accountTextView.getText().toString();
                    final String passwad = passwordTextView.getText().toString();

                    new Thread(new Runnable(){
                        @Override
                        public void run() {
                            Log.d(SDKManager.getInstance().TAG, "Begin HttpURLConnection");

                            String result = "";
                            URL url;
                            try {
                                url = new URL(String.format("http://192.168.1.116:8080/nosdk/%s_login?username=%s&passwad=%s",
                                        SDKManager.getInstance().getChannel(), userName, passwad));
                                HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();  //创建一个HTTP连接
                                InputStreamReader in = new InputStreamReader(
                                        urlConn.getInputStream()); // 获得读取的内容
                                BufferedReader buffer = new BufferedReader(in); // 获取输入流对象
                                String inputLine = null;
                                //通过循环逐行读取输入流中的内容
                                while ((inputLine = buffer.readLine()) != null) {
                                    result += inputLine;
                                }
                                in.close(); //关闭字符输入流对象
                                urlConn.disconnect();   //断开连接

                                JSONObject object = new JSONObject(result);
                                final String loginResult = object.optString("result");
                                final String loginMessage = object.optString("message");

                                tmpActivity.runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (loginResult.compareTo("0") == 0) {
                                            SDKManager.getInstance().getSDKListener().onLoginSuccess();
                                            Log.d(SDKManager.getInstance().TAG, "Login success!");

                                            finish();
                                        }
                                        else {
                                            SDKManager.getInstance().getSDKListener().onLogoutFailed();
                                            String loginFailedMessage = String.format("Login failed: %s", loginMessage);
                                            Log.d(SDKManager.getInstance().TAG, loginFailedMessage);
                                            descriptionTextView.setText(loginFailedMessage);
                                        }
                                    }
                                });
                            } catch (MalformedURLException e) {
                                e.printStackTrace();
                            } catch (IOException e) {
                                e.printStackTrace();
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                        }
                    }).start();
                }
                else {
                    descriptionTextView.setText(tips);
                }
            }
        });

        Button cancelBtn = (Button) findViewById(res.getIdentifier("loginCancel", "id", getPackageName()));
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

    }
}
