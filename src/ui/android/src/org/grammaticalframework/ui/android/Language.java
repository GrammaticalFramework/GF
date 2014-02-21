package org.grammaticalframework.ui.android;

import java.io.Serializable;

public class Language implements Serializable {
	private static final long serialVersionUID = 1L;

	private final String mLangCode;
    private final String mLangName;
    private final String mConcrete;
    private final int    mKeyboardResource;

    public Language(String langCode, String langName, String concrete,
    		        int keyboardResource) {
        mLangCode = langCode;
        mLangName = langName;
        mConcrete = concrete;
        mKeyboardResource = keyboardResource;
    }

    public String getLangCode() {
        return mLangCode;
    }

    public String getLangName() {
        return mLangName;
    }
        
    public int getKeyboardResource() {
    	return mKeyboardResource;
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