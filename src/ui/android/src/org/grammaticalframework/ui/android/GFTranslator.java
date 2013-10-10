package org.grammaticalframework.ui.android;

import android.app.Application;

public class GFTranslator extends Application {
	private Translator mTranslator;

	@Override
	public void onCreate() {
		mTranslator = new Translator(this);
	}
	
	public Translator getTranslator() {
		return mTranslator;
	}
}
