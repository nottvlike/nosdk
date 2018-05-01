package com.common.sdktool;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class MainActivity extends Activity {
    // Setup activity layout
    @Override protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        
        SDKManager.getInstance().onCreate(this);
    }

    @Override protected void onNewIntent(Intent intent)
    {
    	SDKManager.getInstance().onNewIntent(intent);
    	
        setIntent(intent);
    }

    // Quit Unity
    @Override protected void onDestroy ()
    {
    	SDKManager.getInstance().onDestroy();
    	
        super.onDestroy();
    }

    // Pause Unity
    @Override protected void onPause()
    {
        super.onPause();
        
        SDKManager.getInstance().onPause();
    }

    // Resume Unity
    @Override protected void onResume()
    {
        super.onResume();

        SDKManager.getInstance().onResume();
    }

    @Override protected void onStart()
    {
        super.onStart();

        SDKManager.getInstance().onStart();
    }

    @Override protected void onStop()
    {
        super.onStop();

        SDKManager.getInstance().onStop();
    }

    // Notify Unity of the focus change.
    @Override public void onWindowFocusChanged(boolean hasFocus)
    {
        super.onWindowFocusChanged(hasFocus);

        SDKManager.getInstance().onWindowFocusChanged(hasFocus);
    }

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		super.onActivityResult(requestCode, resultCode, data);
		
		SDKManager.getInstance().onActivityResult(requestCode, resultCode, data);
	}
}
