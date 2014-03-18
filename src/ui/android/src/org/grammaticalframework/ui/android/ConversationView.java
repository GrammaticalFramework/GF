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

    public void addFirstPersonUtterance(CharSequence text) {
        View view = 
        	mInflater.inflate(R.layout.first_person_utterance, mContent, false);
        TextView textview = (TextView) view.findViewById(R.id.text);
        textview.setText(text);
        mContent.addView(view);
        post(new Runnable() {
            public void run() {
                fullScroll(FOCUS_DOWN);
            }
        });
    }

    public void addInputBox() {
        final View view = 
        	mInflater.inflate(R.layout.input_box, mContent, false);
        EditText edittext = (EditText) view.findViewById(R.id.input_text);
        edittext.setOnEditorActionListener(new OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if ((actionId & EditorInfo.IME_MASK_ACTION) != 0) {
                	CharSequence text = v.getText();
                	mContent.removeView(view);
                	addFirstPersonUtterance("...");
                	InputMethodManager inputMethodManager = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
                    if (inputMethodManager != null) {
                        inputMethodManager.toggleSoftInput(InputMethodManager.SHOW_IMPLICIT, 0);
                    }
                    if (mSpeechListener != null)
                    	mSpeechListener.onSpeechInput(text.toString().trim());
                    return true;
                }
                return false;
            }
        });
        Bundle extras = edittext.getInputExtras(true);
        extras.putBoolean("show_language_toggle", false);

        mContent.addView(view);
        
        edittext.requestFocus();
        InputMethodManager imm = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.showSoftInput(edittext, InputMethodManager.SHOW_IMPLICIT);

        post(new Runnable() {
            public void run() {
                fullScroll(FOCUS_DOWN);
            }
        });
    }

    public CharSequence addSecondPersonUtterance(CharSequence text) {

	TextView view ;

	// parse by words, marked by %, darkest red colour
	if (text.charAt(0) == '%') {
                 view = (TextView) 
                	mInflater.inflate(R.layout.second_person_worst_utterance, mContent, false) ;
	     		text = text.subSequence(2, text.length()) ;
	}
	// parse by chunks, marked by *, red colour
	else if (text.charAt(0) == '*') {
                 view = (TextView) 
                	mInflater.inflate(R.layout.second_person_chunk_utterance, mContent, false) ;
		 text = text.subSequence(2, text.length()) ;
	}
	// parse error or unknown translations (in []) present, red colour
	else if (text.toString().contains("parse error:") || text.toString().contains("[")) {
                 view = (TextView) 
                	mInflater.inflate(R.layout.second_person_worst_utterance, mContent, false) ;
	}
	// parse by domain grammar, marked by +, green colour
	else 	if (text.charAt(0) == '+') {
                 view = (TextView) 
                	mInflater.inflate(R.layout.second_person_best_utterance, mContent, false) ;
		 text = text.subSequence(2, text.length()) ;
	}
	// parse by resource grammar, no mark, yellow colour
	else
                 view = (TextView) 
          	       mInflater.inflate(R.layout.second_person_utterance, mContent, false);

        view.setText(text);
        mContent.addView(view);
        post(new Runnable() {
            public void run() {
                fullScroll(FOCUS_DOWN);
            }
        });
	return text ;
    }

    public void updateLastUtterance(CharSequence text, Object lexicon) {
        int count = mContent.getChildCount();
        if (count > 0) {
            View view = mContent.getChildAt(count - 1);
            TextView textview = (TextView) view.findViewById(R.id.text);
            textview.setText(text);
            
            if (lexicon != null && mWordListener != null) {
            	ImageView showWordButton = (ImageView) view.findViewById(R.id.show_word);
            	showWordButton.setVisibility(VISIBLE);

            	final Object lexicon2 = lexicon;
    	        showWordButton.setOnClickListener(new OnClickListener() {
    	        	@Override
    	        	public void onClick(View v) {
    	        		if (mWordListener != null) {
    	        			TextView textview = (TextView)
    	        				((View) v.getParent()).findViewById(R.id.text);
    	        			CharSequence text = textview.getText();
    	        			mWordListener.onWordSelected(text, lexicon2);
    	        		}
    	        	}
    	        });    	        
            }
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
