package com.sdk.demo;

import android.os.Bundle;
import android.app.Activity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.common.sdktool.SDKManager;

import org.w3c.dom.Text;

import nottvlike.channel_default.R;

public class DemoExitActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.demo_exit);

        TextView titleTextView = (TextView) findViewById(R.id.exitTitle);
        titleTextView.setText("Warning");

        TextView contentTextView = (TextView) findViewById(R.id.exitContent);
        contentTextView.setText("Are you true to exit!");

        Button okBtn = (Button) findViewById(R.id.exitGoExit);
        okBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
                SDKManager.getInstance().getExitListener().OnExitSuccess();
            }
        });

        Button cancelBtn = (Button) findViewById(R.id.exitGoCancelExit);
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
                SDKManager.getInstance().getExitListener().OnExitCancel();
            }
        });
    }
}
