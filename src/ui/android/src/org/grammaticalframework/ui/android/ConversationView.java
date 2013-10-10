package org.grammaticalframework.ui.android;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;

public class ConversationView extends ScrollView {

    private LayoutInflater mInflater;

    private ViewGroup mContent;
    
    private OnWordSelectedListener mListener;

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

    public void addSecondPersonUtterance(CharSequence text) {
        TextView view = (TextView) 
        	mInflater.inflate(R.layout.second_person_utterance, mContent, false);
        view.setText(text);
        mContent.addView(view);
        post(new Runnable() {
            public void run() {
                fullScroll(FOCUS_DOWN);
            }
        });
    }

    public void updateLastUtterance(CharSequence text, Object lexicon) {
        int count = mContent.getChildCount();
        if (count > 0) {
            View view = mContent.getChildAt(count - 1);
            TextView textview = (TextView) view.findViewById(R.id.text);
            textview.setText(text);
            
            if (lexicon != null && mListener != null) {
            	ImageView showWordButton = (ImageView) view.findViewById(R.id.show_word);
            	showWordButton.setVisibility(VISIBLE);

            	final Object lexicon2 = lexicon;
    	        showWordButton.setOnClickListener(new OnClickListener() {
    	        	@Override
    	        	public void onClick(View v) {
    	        		mListener.onWordSelected(lexicon2);
    	        	}
    	        });    	        
            }
        }
    }

    public void setOnWordSelectedListener(OnWordSelectedListener listener) {
    	mListener = listener;
    }
    
    public interface OnWordSelectedListener {
    	public void onWordSelected(Object lexicon);
    }
}
