package org.grammaticalframework.ui.android;

import org.grammaticalframework.ui.android.TranslatorKeyboard;

import android.content.Context;
import android.inputmethodservice.Keyboard.Key;
import android.inputmethodservice.KeyboardView;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.PopupWindow;

public class TranslatorKeyboardView extends KeyboardView {

	private Translator mTranslator;

    public TranslatorKeyboardView(Context context, AttributeSet attrs) {
        super(context, attrs);
        mTranslator = ((GFTranslator) context.getApplicationContext()).getTranslator();
    }

    public TranslatorKeyboardView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        mTranslator = ((GFTranslator) context.getApplicationContext()).getTranslator();
    }

    private PopupWindow mLanguagesPopup = null;
    private Key mLanguagesKey = null;

    private void showLanguageOptions(Key popupKey) {
    	if (mLanguagesPopup == null) {
	    	LayoutInflater inflater = (LayoutInflater) getContext().getSystemService(
	                Context.LAYOUT_INFLATER_SERVICE);
	    	LinearLayout popupContainer = (LinearLayout)
	    		inflater.inflate(R.layout.keyboard_languages_options, null);
	
	    	int index = 0;
	    	for (Language lang : mTranslator.getAvailableLanguages()) {
	    		Button item = new Button(getContext());
	    		item.setText(TranslatorKeyboard.getLanguageKeyLabel(lang));
	    		item.setTag(index);
	    		item.setOnClickListener(this);
	    		popupContainer.addView(item, index++);
	    	}
	
	    	popupContainer.measure(
	                MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.AT_MOST), 
	                MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.AT_MOST));
	
	    	mLanguagesPopup = new PopupWindow(getContext());
	    	mLanguagesPopup.setWidth(popupContainer.getMeasuredWidth());
	    	mLanguagesPopup.setHeight(popupContainer.getMeasuredHeight());
	    	mLanguagesPopup.setContentView(popupContainer);
	
	    	int[] windowOffset = new int[2];
	        getLocationInWindow(windowOffset);
	        int popupX = popupKey.x + popupKey.width - popupContainer.getMeasuredWidth();
	        int popupY = popupKey.y - popupContainer.getMeasuredHeight();
	        final int x = popupX + popupContainer.getPaddingRight() + windowOffset[0];
	        final int y = popupY + popupContainer.getPaddingBottom() + windowOffset[1];
	        mLanguagesPopup.showAtLocation(this, Gravity.NO_GRAVITY, x, y);
	
	    	View closeButton = popupContainer.findViewById(R.id.closeButton);
	        if (closeButton != null) closeButton.setOnClickListener(this);
    	}
    	
    	mLanguagesKey = popupKey;
    }

    private void dismissLanguages() {
    	if (mLanguagesPopup != null) {
        	mLanguagesPopup.dismiss();
        	mLanguagesPopup = null;
        	mLanguagesKey   = null;
        }
    }

    @Override
    public void onClick(View v) {
        super.onClick(v);
        
        if (v.getTag() != null) {
	        if (mLanguagesKey.codes[0] == TranslatorKeyboard.KEYCODE_SOURCE_LANGUAGE ||
	        	mLanguagesKey.codes[0] == TranslatorKeyboard.KEYCODE_TARGET_LANGUAGE) {
	        	int keyCode = mLanguagesKey.codes[0] - ((Integer) v.getTag()) - 1;
	        	getOnKeyboardActionListener().onKey(keyCode, new int[] {keyCode});
	        }
        }

        dismissLanguages();
    }
    
    public void closing() {
    	super.closing();
    	dismissLanguages();
    }

    @Override
    protected boolean onLongPress(Key key) {
    	if (key.codes[0] == TranslatorKeyboard.KEYCODE_SOURCE_LANGUAGE ||
    		key.codes[0] == TranslatorKeyboard.KEYCODE_TARGET_LANGUAGE) {
    		showLanguageOptions(key);
    		return true; 
        } else {
            return super.onLongPress(key);
        }
    }    
}
