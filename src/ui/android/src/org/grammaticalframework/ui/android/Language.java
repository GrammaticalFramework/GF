package org.grammaticalframework.ui.android;

public class Language {
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

}