package org.grammaticalframework.ui.android;

import java.io.Serializable;

public class Language implements Serializable {
	private static final long serialVersionUID = 1L;

	private final String mLangCode;
    private final String mLangName;
    private final String mConcrete;
    private final int    mKeyboardPage1Resource;
    private final int    mKeyboardPage2Resource;

    public Language(String langCode, String langName, String concrete,
    		        int keyboardResource) {
        mLangCode = langCode;
        mLangName = langName;
        mConcrete = concrete;
        mKeyboardPage1Resource = keyboardResource;
        mKeyboardPage2Resource = keyboardResource;
    }

    public Language(String langCode, String langName, String concrete,
	                int keyboardPage1Resource, int keyboardPage2Resource) {
    	mLangCode = langCode;
    	mLangName = langName;
    	mConcrete = concrete;
    	mKeyboardPage1Resource = keyboardPage1Resource;
    	mKeyboardPage2Resource = keyboardPage2Resource;
    }

    public String getLangCode() {
        return mLangCode;
    }

    public String getLangName() {
        return mLangName;
    }
        
    public int getKeyboardPage1Resource() {
    	return mKeyboardPage1Resource;
    }

    public int getKeyboardPage2Resource() {
    	return mKeyboardPage2Resource;
    }

    String getConcrete() {
        return mConcrete;
    }

    @Override
    public String toString() {
        return getLangName();
    }
    
    @Override
    public boolean equals(Object o) {
        Language other = (Language) o;
        return mLangCode.equals(other.mLangCode); 
    }
}