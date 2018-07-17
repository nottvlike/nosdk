package com.sdk.demo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.common.sdktool.PayInfo;
import com.common.sdktool.SDKManager;

import nottvlike.channel_default.R;

public class DemoPayActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.demo_pay);

        PayInfo payInfo = SDKManager.getInstance().getPayInfo();

        TextView productName = (TextView) findViewById(R.id.payTitle);
        productName.setText(payInfo.productName);

        TextView amount = (TextView) findViewById(R.id.payAmount);
        amount.setText(String.valueOf(payInfo.amount));

        TextView description = (TextView) findViewById(R.id.payDescription);
        amount.setText(String.valueOf(payInfo.productDescription));

        Button buyBtn = (Button) findViewById(R.id.payGoPay);
        buyBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().getPayListener().OnPaySuccess();
                finish();
            }
        });

        Button cancelBtn = (Button) findViewById(R.id.payGoCancelPay);
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SDKManager.getInstance().getPayListener().OnPayCanceled();
                finish();
            }
        });
    }
}
