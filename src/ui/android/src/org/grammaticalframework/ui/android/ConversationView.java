package org.grammaticalframework.ui.android;

import android.content.Context;
import android.os.Bundle;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.view.KeyEvent;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

public class ConversationView extends ScrollView {

    private LayoutInflater mInflater;

    private ViewGroup mContent;
    
    private OnWordSelectedListener mWordListener;
    private ASR.Listener mSpeechListener;

    public ConversationView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);        
    }

    public ConversationView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public ConversationView(Context context) {
        super(context);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        mContent = (ViewGroup) findViewById(R.id.conversation_content);
        mInflater = LayoutInflater.from(getContext());
    }
    		
    private class EditorListener implements OnEditorActionListener, OnClickListener {
        @Override
        public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
            if ((actionId & EditorInfo.IME_MASK_ACTION) != 0) {
            	CharSequence text = v.getText();
            	InputMethodManager inputMethodManager = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
                if (inputMethodManager != null) {
                    inputMethodManager.toggleSoftInput(InputMethodManager.SHOW_IMPLICIT, 0);
                }
                v.setFocusable(false);
                mLastUtterance = (View) v.getParent();
                if (mSpeechListener != null)
                	mSpeechListener.onSpeechInput(text.toString().trim());
                return true;
            }
            return false;
        }

		@Override
		public void onClick(View v) {
			v.setFocusableInTouchMode(true);
			v.requestFocus();
	        InputMethodManager imm = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
	        imm.showSoftInput(v, InputMethodManager.SHOW_IMPLICIT);
		}
	};

    private EditorListener mEditorListener = new EditorListener();
    private View mLastUtterance = null;

    public void addFirstPersonUtterance(CharSequence text, boolean focused) {
        View view = 
        	mInflater.inflate(R.layout.first_person_utterance, mContent, false);
        EditText edittext = (EditText) view.findViewById(R.id.input_text);
        edittext.setText(text);
        edittext.setOnEditorActionListener(mEditorListener);
        edittext.setOnClickListener(mEditorListener);
        Bundle extras = edittext.getInputExtras(true);
        extras.putBoolean("show_language_toggle", false);
        mContent.addView(view);

        if (focused) {
	        edittext.requestFocus();
	        InputMethodManager imm = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
	        imm.showSoftInput(edittext, InputMethodManager.SHOW_IMPLICIT);
        } else {
        	edittext.setFocusable(false);
        }

        post(new Runnable() {
            public void run() {
                fullScroll(FOCUS_DOWN);
            }
        });
        
        mLastUtterance = view;
    }

    @SuppressWarnings("deprecation")
	public CharSequence addSecondPersonUtterance(CharSequence text) {
    	TextView view;
    	if (mLastUtterance != null && mLastUtterance.getTag() != null)
    		view = (TextView) mLastUtterance.getTag();
    	else {
    		view = (TextView) 
    			mInflater.inflate(R.layout.second_person_utterance, mContent, false);
        	mContent.addView(view);
            post(new Runnable() {
                public void run() {
                    fullScroll(FOCUS_DOWN);
                }
            });

    		mLastUtterance.setTag(view);
    	}

    	// parse by words, marked by %, darkest red colour
    	if (text.charAt(0) == '%') {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
    		text = text.subSequence(2, text.length()) ;
    	}

    	// parse error or unknown translations (in []) present, darkest red colour
    	else if (text.toString().contains("parse error:") || text.toString().contains("[")) {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
    	}

    	// parse by chunks, marked by *, red colour
    	else if (text.charAt(0) == '*') {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_chunk_utterance_bg));
    		text = text.subSequence(2, text.length()) ;
    	}

    	// parse by domain grammar, marked by +, green colour
    	else if (text.charAt(0) == '+') {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_best_utterance_bg));
    		text = text.subSequence(2, text.length()) ;
    	}

    	view.setText(text);
        return text ;
    }

    public void updateLastUtterance(CharSequence text, Object lexicon) {
    	if (mLastUtterance == null)
    		return;

        EditText textview = (EditText) mLastUtterance.findViewById(R.id.input_text);
        if (textview == null)
        	return;

        textview.setText(text);
        
        if (lexicon != null && mWordListener != null) {
        	ImageView showWordButton = (ImageView) mLastUtterance.findViewById(R.id.show_word);
        	showWordButton.setVisibility(VISIBLE);

        	final Object lexicon2 = lexicon;
	        showWordButton.setOnClickListener(new OnClickListener() {
	        	@Override
	        	public void onClick(View v) {
	        		if (mWordListener != null) {
	        			TextView textview = (TextView)
	        				((View) v.getParent()).findViewById(R.id.input_text);
	        			CharSequence text = textview.getText();
	        			mWordListener.onWordSelected(text, lexicon2);
	        		}
	        	}
	        });    	        
        }
    }

    public void setOnWordSelectedListener(OnWordSelectedListener listener) {
    	mWordListener = listener;
    }
    
    public void setSpeechInputListener(ASR.Listener listener) {
    	mSpeechListener = listener;
    }
    
    public interface OnWordSelectedListener {
    	public void onWordSelected(CharSequence word, Object lexicon);
    }
}
