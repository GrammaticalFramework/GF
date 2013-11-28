package org.grammaticalframework.ui.android;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.webkit.WebView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import org.grammaticalframework.pgf.*;
import org.grammaticalframework.ui.android.LanguageSelector.OnLanguageSelectedListener;

public class LexicalEntryActivity extends ListActivity {

	private Translator mTranslator;
	private LanguageSelector mShowLanguageView;

	/** Called when the activity is first created. */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    setContentView(R.layout.activity_lexical_entry);

        mTranslator = ((GFTranslator) getApplicationContext()).getTranslator();

	    mShowLanguageView = (LanguageSelector) findViewById(R.id.show_language);
	    mShowLanguageView.setLanguages(mTranslator.getAvailableLanguages());
	    mShowLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(Language language) {
            	mTranslator.setTargetLanguage(language);
                updateTranslations();
            }
        });
	    
	    TextView descrView = (TextView) findViewById(R.id.lexical_desc);
	    descrView.setText(getIntent().getExtras().getString("source"));

	    updateTranslations();
      }

	@Override
	protected void onResume() {
		super.onResume();

		mShowLanguageView.setSelectedLanguage(mTranslator.getTargetLanguage());
	}

	private View expandedView;

	private void updateTranslations() {
	    @SuppressWarnings("unchecked")
		List<MorphoAnalysis> list = (List<MorphoAnalysis>)
	    	getIntent().getExtras().getSerializable("analyses");

		List<String> data = new ArrayList<String>();
	    for (MorphoAnalysis a : list) {
	    	if (!data.contains(a.getLemma())) {
		    	data.add(a.getLemma());
	    	}
	    }

        setListAdapter(new LexicalAdapter(this, data));
        expandedView = null;
	}
	
	private void collapse() {
		if (expandedView == null)
			return;
		
		ImageView arrow = (ImageView) expandedView.findViewById(R.id.arrow);
		arrow.setImageResource(R.drawable.open_arrow);

		WebView inflectionView = (WebView) expandedView.findViewById(R.id.lexical_inflection);
		((RelativeLayout) expandedView).removeView(inflectionView);

		expandedView = null;
	}

	private void expand(View view, String lemma) {
		String html = mTranslator.getInflectionTable(lemma);
		if (html == null)
			return;

		ImageView arrow = (ImageView) view.findViewById(R.id.arrow);
		arrow.setImageResource(R.drawable.close_arrow);
		
		WebView inflectionView = (WebView) view.findViewById(R.id.lexical_inflection);
		if (inflectionView == null) {
			inflectionView = new WebView(this);
			inflectionView.setId(R.id.lexical_inflection);
			RelativeLayout.LayoutParams params = 
					new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
			params.addRule(RelativeLayout.BELOW, R.id.lexical_desc);
			((RelativeLayout) view).addView(inflectionView, params);
		}

		inflectionView.loadData(html, "text/html; charset=UTF-8", null);

		expandedView = view;
	}

    private class LexicalAdapter extends ArrayAdapter<String> {
    	public LexicalAdapter(Context context, List<String> data) {
    		super(context, android.R.layout.simple_list_item_1, data);
    	}

    	public View getView(int position, View convertView, ViewGroup parent) {
			final String lemma = getItem(position);
			
			LayoutInflater inflater = (LayoutInflater) getContext()
	                .getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
	        if (convertView == null) {
	            convertView = inflater.inflate(R.layout.lexical_item, null);
	        }

	        TextView descView =
	        		(TextView) convertView.findViewById(R.id.lexical_desc);

	    	String phrase = mTranslator.generateLexiconEntry(lemma);
	        descView.setText(phrase);

	        convertView.setOnClickListener(new OnClickListener() {
				@Override
				public void onClick(View view) {
					if (expandedView == view)
						collapse();
					else if (expandedView == null)
						expand(view, lemma);
					else {
						collapse();
						expand(view, lemma);
					}					
				}
			});

			return convertView;
	    }
    }
}
