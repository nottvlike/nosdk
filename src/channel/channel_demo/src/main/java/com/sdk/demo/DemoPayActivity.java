package com.sdk.demo;

import android.app.Activity;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.common.sdktool.PayInfo;
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

public class DemoPayActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Resources res = getResources();
        setContentView(res.getIdentifier("demo_pay", "layout", getPackageName()));

        PayInfo payInfo = SDKManager.getInstance().getPayInfo();

        TextView productName = (TextView) findViewById(res.getIdentifier("payTitle", "id", getPackageName()));
        productName.setText(payInfo.productName);

        TextView amount = (TextView) findViewById(res.getIdentifier("payAmount", "id", getPackageName()));
        amount.setText(String.valueOf(payInfo.amount));

        TextView description = (TextView) findViewById(res.getIdentifier("payDescription", "id", getPackageName()));
        description.setText(String.valueOf(payInfo.productDescription));

        final Activity tmpActivity = this;

        Button buyBtn = (Button) findViewById(res.getIdentifier("payGoPay", "id", getPackageName()));
        buyBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new Thread(new Runnable(){
                    @Override
                    public void run() {
                        Log.d(SDKManager.getInstance().TAG, "Begin HttpURLConnection");

                        String result = "";
                        URL url;
                        try {
                            final PayInfo payInfo = SDKManager.getInstance().getPayInfo();
                            url = new URL(String.format("http://192.168.1.116:8080/nosdk/%s_pay?amount=%s&currency=%s&productid=%s&orderid=%s&extradata=%s",
                                    SDKManager.getInstance().getChannel(), payInfo.amount, payInfo.currency, payInfo.productId, payInfo.orderId, payInfo.extra));
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
                            final String payResult = object.optString("result");
                            final String payMessage = object.optString("message");
                            final String payExtraData = object.optString("extradata");

                            tmpActivity.runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    if (payResult.compareTo("0") == 0) {
                                        Log.d(SDKManager.getInstance().TAG, "Pay success!");

                                        SDKManager.getInstance().getSDKListener().onPaySuccess();
                                    }
                                    else {
                                        Log.d(SDKManager.getInstance().TAG, String.format("Pay failed: ", payMessage));

                                        SDKManager.getInstance().getSDKListener().onPayFailed();
                                    }

                                    finish();
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
        });

        Button cancelBtn = (Button) findViewById(res.getIdentifier("payGoCancelPay", "id", getPackageName()));
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().getSDKListener().onPayCanceled();
                finish();
            }
        });
    }
}
