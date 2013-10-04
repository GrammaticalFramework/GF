package org.grammaticalframework.ui.android;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ScrollView;
import android.widget.TextView;

public class ConversationView extends ScrollView {

    private LayoutInflater mInflater;

    private ViewGroup mContent;

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
        addUtterance(R.layout.first_person_utterance, text);
    }

    public void addSecondPersonUtterance(CharSequence text) {
        addUtterance(R.layout.second_person_utterance, text);
    }

    private void addUtterance(int res, CharSequence text) {
        TextView view = (TextView) mInflater.inflate(res, mContent, false);
        view.setText(text);
        mContent.addView(view);
        post(new Runnable() {
            public void run() {
                fullScroll(FOCUS_DOWN);
            }
        });
    }

    public void updateLastUtterance(CharSequence text) {
        int count = mContent.getChildCount();
        if (count > 0) {
            TextView view = (TextView) mContent.getChildAt(count - 1);
            view.setText(text);
        }
    }

}
