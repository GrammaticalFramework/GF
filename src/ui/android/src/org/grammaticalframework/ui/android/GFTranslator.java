package org.grammaticalframework.ui.android;

import android.app.Application;

public class GFTranslator extends Application {
	private Translator mTranslator;
	private static GFTranslator instance;

	@Override
	public void onCreate() {
		mTranslator = new Translator(this);
		instance = this;
	}
	
	public Translator getTranslator() {
		return mTranslator;
	}
	
	public static GFTranslator get() {
		return instance;
	}
}
