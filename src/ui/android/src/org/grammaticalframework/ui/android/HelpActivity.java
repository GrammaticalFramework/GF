package org.grammaticalframework.ui.android;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

public class HelpActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_help);
        WebView wv = (WebView) findViewById(R.id.help_content);  
        wv.loadUrl("file:///android_asset/help_content.html");
    }
}