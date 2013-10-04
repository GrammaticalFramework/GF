package org.grammaticalframework.ui.android;

import android.content.Context;
import android.widget.ArrayAdapter;
import android.widget.SpinnerAdapter;


import java.util.List;

public class LanguagesAdapter extends ArrayAdapter<Language> implements SpinnerAdapter {

    public LanguagesAdapter(Context context, List<Language> objects) {
        super(context, R.layout.languages_item, objects);
    }

}
