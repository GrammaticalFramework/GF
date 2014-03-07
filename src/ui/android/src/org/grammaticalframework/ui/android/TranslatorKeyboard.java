package org.grammaticalframework.ui.android;

import java.util.Locale;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.view.inputmethod.EditorInfo;
import android.inputmethodservice.Keyboard;

public class TranslatorKeyboard extends Keyboard {

    private Key mEnterKey;
    private Key mSourceLanguageKey;
    private Key mTargetLanguageKey;

    static final int KEYCODE_PAGE_CHANGE     = -10;
    static final int KEYCODE_SOURCE_LANGUAGE = -100;
    static final int KEYCODE_TARGET_LANGUAGE = -200;
    static final int MAX_LANGUAGE_KEYCODES = 99;

    private Translator mTranslator;
    
    public TranslatorKeyboard(Context context, int xmlLayoutResId, int modeId) {
    	super(context, xmlLayoutResId, modeId);

    	mTranslator = ((GFTranslator) context.getApplicationContext()).getTranslator();
    	updateLanguageKeyLabels();
    }

	public void updateLanguageKeyLabels() {
		if (mSourceLanguageKey != null)
    		mSourceLanguageKey.label = getLanguageKeyLabel(mTranslator.getSourceLanguage());
    	
    	if (mTargetLanguageKey != null)
    		mTargetLanguageKey.label = getLanguageKeyLabel(mTranslator.getTargetLanguage());
	}

    public static String getLanguageKeyLabel(Language lang) {
    	if ("cmn-hans-cn".equalsIgnoreCase(lang.getLangCode())) // this one has no ISO code 
    		return "chi";
    	else
	    	return
	    		LocaleUtils.parseJavaLocale(lang.getLangCode(), Locale.getDefault())
	    		           .getISO3Language();
    }
    
    @Override
    protected Key createKeyFromXml(Resources res, Row parent, int x, int y, 
            XmlResourceParser parser) {
        Key key = new Key(res, parent, x, y, parser);
        if (key.codes[0] == 10) {
            mEnterKey = key;
        } else if (key.codes[0] == KEYCODE_SOURCE_LANGUAGE) {
        	mSourceLanguageKey = key;
        } else if (key.codes[0] == KEYCODE_TARGET_LANGUAGE) {
        	mTargetLanguageKey = key;
        }
        return key;
    }

    /**
     * This looks at the ime options given by the current editor, to set the
     * appropriate label on the keyboard's enter key (if it has one).
     */
    void setImeOptions(Resources res, int options) {
        if (mEnterKey == null) {
            return;
        }

        switch (options&(EditorInfo.IME_MASK_ACTION|EditorInfo.IME_FLAG_NO_ENTER_ACTION)) {
        	case EditorInfo.IME_ACTION_DONE:
        		mEnterKey.iconPreview = null;
        		mEnterKey.icon = null;
        		mEnterKey.label = res.getText(R.string.label_done_key);
        		break;
            case EditorInfo.IME_ACTION_GO:
                mEnterKey.iconPreview = null;
                mEnterKey.icon = null;
                mEnterKey.label = res.getText(R.string.label_go_key);
                break;
            case EditorInfo.IME_ACTION_NEXT:
                mEnterKey.iconPreview = null;
                mEnterKey.icon = null;
                mEnterKey.label = res.getText(R.string.label_next_key);
                break;
            case EditorInfo.IME_ACTION_PREVIOUS:
                mEnterKey.iconPreview = null;
                mEnterKey.icon = null;
                mEnterKey.label = res.getText(R.string.label_previous_key);
                break;
            case EditorInfo.IME_ACTION_SEARCH:
                mEnterKey.icon = res.getDrawable(R.drawable.sym_keyboard_search);
                mEnterKey.label = null;
                break;
            case EditorInfo.IME_ACTION_SEND:
                mEnterKey.iconPreview = null;
                mEnterKey.icon = null;
                mEnterKey.label = res.getText(R.string.label_send_key);
                break;
            default:
                mEnterKey.icon = res.getDrawable(R.drawable.sym_keyboard_return);
                mEnterKey.label = null;
                break;
        }
    }
}