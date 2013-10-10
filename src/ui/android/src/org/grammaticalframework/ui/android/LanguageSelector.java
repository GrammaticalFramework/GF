package org.grammaticalframework.ui.android;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Spinner;

import java.util.List;

public class LanguageSelector extends Spinner {

    public LanguageSelector(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public LanguageSelector(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public LanguageSelector(Context context) {
        super(context);
    }

    public void setLanguages(List<Language> languages) {
        setAdapter(new LanguagesAdapter(getContext(), languages));
    }

    public void setSelectedLanguage(Language selected) {
        setSelection(((LanguagesAdapter) getAdapter()).getPosition(selected));
    }

    public Language getSelectedLanguage() {
    	return (Language) getSelectedItem();
    }

    public void setOnLanguageSelectedListener(final OnLanguageSelectedListener listener) {
        setOnItemSelectedListener(new OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                if (listener != null) {
                    listener.onLanguageSelected((Language) parent.getItemAtPosition(position));
                }
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
    }

    public interface OnLanguageSelectedListener {
        void onLanguageSelected(Language language);
    }

}
