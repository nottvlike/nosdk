package com.sdk.demo;

import android.content.res.Resources;
import android.os.Bundle;
import android.app.Activity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.common.sdktool.SDKManager;

public class DemoExitActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Resources res = getResources();
        setContentView(res.getIdentifier("demo_exit", "layout", getPackageName()));

        TextView titleTextView = (TextView) findViewById(res.getIdentifier("exitTitle", "id", getPackageName()));
        titleTextView.setText("Warning");

        TextView contentTextView = (TextView) findViewById(res.getIdentifier("exitContent", "id", getPackageName()));
        contentTextView.setText("Are you true to exit!");

        Button okBtn = (Button) findViewById(res.getIdentifier("exitGoExit", "id", getPackageName()));
        okBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
                SDKManager.getInstance().getSDKListener().onExitSuccess(true);
            }
        });

        Button cancelBtn = (Button) findViewById(res.getIdentifier("exitGoCancelExit", "id", getPackageName()));
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
                SDKManager.getInstance().getSDKListener().onExitCanceled();
            }
        });
    }
}
