package org.grammaticalframework.ui.android;

import java.io.Serializable;
import java.util.*;

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
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

import org.grammaticalframework.pgf.Expr;

public class ConversationView extends ScrollView {

    private LayoutInflater mInflater;

    private ViewGroup mContent;
    
    private OnClickListener mAlternativesListener;
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
                mLastUtterance = v;
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
    private TextView mLastUtterance = null;

    public void addFirstPersonUtterance(CharSequence text, boolean focused) {
    	EditText edittext = (EditText) 
        	mInflater.inflate(R.layout.first_person_utterance, mContent, false);
        edittext.setText(text);
        edittext.setOnEditorActionListener(mEditorListener);
        edittext.setOnClickListener(mEditorListener);
        edittext.setHorizontallyScrolling(false);
        edittext.setMaxLines(Integer.MAX_VALUE);
        Bundle extras = edittext.getInputExtras(true);
        extras.putBoolean("show_language_toggle", false);
        mContent.addView(edittext);

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
        
        mLastUtterance = edittext;
    }

    @SuppressWarnings("deprecation")
	public CharSequence addSecondPersonUtterance(String authority, CharSequence source, CharSequence target, List<Expr> alternatives) {
    	TextView view;
    	if (mLastUtterance != null && mLastUtterance.getTag() != null)
    		view = (TextView) mLastUtterance.getTag();
    	else {
    		view = (TextView)
    			mInflater.inflate(R.layout.second_person_utterance, mContent, false);
    		if (mAlternativesListener != null)
        		view.setOnClickListener(mAlternativesListener);
        	mContent.addView(view);
            post(new Runnable() {
                public void run() {
                    fullScroll(FOCUS_DOWN);
                }
            });

    		mLastUtterance.setTag(view);
    	}

    	view.setTag(R.string.authority_key, authority);
    	view.setTag(R.string.source_key, source);
    	view.setTag(R.string.target_key, target);
    	view.setTag(R.string.alternatives_key, alternatives);

    	// parse by words, marked by %, darkest red color
    	if (target.charAt(0) == '%') {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
    		target = target.subSequence(1, target.length()).toString().trim();
    	}

    	// parse by chunks, marked by *, red color
    	else if (target.charAt(0) == '*') {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_chunk_utterance_bg));
    		target = target.subSequence(1, target.length()).toString().trim();
    	}

    	// parse error: darkest red color
    	else if (target.toString().contains("parse error:")) {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
    	}

    	// unknown linearizations in output: darkest red color. But replace [ ] by spaces and remove _ for better speech synthesis
    	else if (target.toString().contains("[")) {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
    	}

    	// parse by domain grammar, marked by +, green color
    	else if (target.charAt(0) == '+') {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_best_utterance_bg));
    		target = target.subSequence(1, target.length()).toString().trim();
    	}
    	
    	else {
    		view.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_utterance_bg));
    	}

    	view.setText(target);
        return target;
    }

    public void updateLastUtterance(CharSequence text) {
    	if (mLastUtterance != null)
    		mLastUtterance.setText(text);
    }

    public void setOnAlternativesListener(final OnAlternativesListener listener) {
    	if (listener == null)
    		mAlternativesListener = null;
    	else
    		mAlternativesListener = new OnClickListener() {
	        	@Override
	        	public void onClick(View v) {
	        		String authority = v.getTag(R.string.authority_key).toString();
	        		String source = v.getTag(R.string.source_key).toString();
	        		List<Expr> alternatives = (List<Expr>) v.getTag(R.string.alternatives_key);
	        		listener.onAlternativesSelected(authority, source, alternatives);
	        	}
	        };
    }
    
    public void setSpeechInputListener(ASR.Listener listener) {
    	mSpeechListener = listener;
    }

    public interface OnAlternativesListener {
    	public void onAlternativesSelected(CharSequence authority, CharSequence word, List<Expr> althernatives);
    }

    public void saveConversation(Bundle state) {
    	ArrayList<String> authorities   = new ArrayList<String>();
    	ArrayList<String> firstPersonUtterances   = new ArrayList<String>();
    	ArrayList<String> secondPersonUtterances  = new ArrayList<String>();
    	ArrayList<Object> translationAlternatives = new ArrayList<Object>();

    	int childCount = mContent.getChildCount();
    	for (int i = 0; i < childCount; i++) {
    		View child = mContent.getChildAt(i);
    		if (child.getClass() == TextView.class) {
				authorities.add(child.getTag(R.string.authority_key).toString());
    			firstPersonUtterances.add(child.getTag(R.string.source_key).toString());
    			secondPersonUtterances.add(child.getTag(R.string.target_key).toString());
    			translationAlternatives.add(child.getTag(R.string.alternatives_key));
    		}
    	}

		state.putStringArrayList("authorities",  authorities);
    	state.putStringArrayList("first_person_uterances",  firstPersonUtterances);
		state.putStringArrayList("second_person_uterances", secondPersonUtterances);
		state.putSerializable("translation_alternatives",(Serializable) translationAlternatives);
    }

	public void restoreConversation(Bundle state) {
		ArrayList<String> authorities  = state.getStringArrayList("authorities");
		ArrayList<String> firstPersonUtterances  = state.getStringArrayList("first_person_uterances");
		ArrayList<String> secondPersonUtterances = state.getStringArrayList("second_person_uterances");
		ArrayList<List<Expr>> translationAlternatives= (ArrayList<List<Expr>>) state.getSerializable("translation_alternatives");

		int i = 0;
		while (i < authorities.size() && 
		       i < firstPersonUtterances.size() && 
			   i < Math.min(secondPersonUtterances.size(), translationAlternatives.size())) {
			String text = firstPersonUtterances.get(i);
			addFirstPersonUtterance(text, false);

			String authority  = authorities.get(i);
			String translation  = secondPersonUtterances.get(i);
			List<Expr> alternatives = translationAlternatives.get(i);
			addSecondPersonUtterance(authority, text, translation, alternatives);

			i++;
		}
	}
}
