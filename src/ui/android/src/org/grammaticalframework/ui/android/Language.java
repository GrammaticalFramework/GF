package org.grammaticalframework.ui.android;

import java.io.Serializable;

public class Language implements Serializable {
	private static final long serialVersionUID = 1L;

	private final String mLangCode;
    private final String mLangName;
    private final String mConcrete;

    public Language(String langCode, String langName, String concrete) {
        mLangCode = langCode;
        mLangName = langName;
        mConcrete = concrete;
    }

    public String getLangCode() {
        return mLangCode;
    }

    public String getLangName() {
        return mLangName;
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