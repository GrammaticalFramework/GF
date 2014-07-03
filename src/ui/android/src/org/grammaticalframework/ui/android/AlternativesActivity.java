package org.grammaticalframework.ui.android;

import java.util.List;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.os.AsyncTask;
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

public class AlternativesActivity extends ListActivity {

	private Translator mTranslator;
	private LanguageSelector mShowLanguageView;
	private View mProgressBarView = null;
	
	/** Called when the activity is first created. */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    setContentView(R.layout.activity_lexical_entry);

        mTranslator = ((HLCompiler) getApplicationContext()).getTranslator();

	    mShowLanguageView = (LanguageSelector) findViewById(R.id.show_language);
	    mShowLanguageView.setLanguages(mTranslator.getAvailableLanguages());
	    mShowLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(final Language language) {
                new AsyncTask<Void,Void,Void>() {
                	@Override
                	protected void onPreExecute() {
                		showProgressBar();
                	}

                    @Override
                    protected Void doInBackground(Void... params) {
                        mTranslator.setTargetLanguage(language);
                        mTranslator.isTargetLanguageLoaded();
                        return null;
                    }

                    @Override
                    protected void onPostExecute(Void result) {
                        updateTranslations();
                        hideProgressBar();
                    }
                }.execute();
            }
        });
	    
	    TextView descrView = (TextView) findViewById(R.id.lexical_desc);
	    descrView.setText(getIntent().getExtras().getString("source"));

	    mProgressBarView = findViewById(R.id.progressBarView);
	    
	    updateTranslations();
     }

	@Override
	protected void onResume() {
		super.onResume();

		mShowLanguageView.setSelectedLanguage(mTranslator.getTargetLanguage());
	}

	private void showProgressBar() {
		mProgressBarView.setVisibility(View.VISIBLE);
	}
	
	private void hideProgressBar() {
		mProgressBarView.setVisibility(View.GONE);
	}

	private View expandedView;

	private void updateTranslations() {
	    @SuppressWarnings("unchecked")
		List<Object> list = (List<Object>)
	    	getIntent().getExtras().getSerializable("analyses");

        setListAdapter(new AlternativesAdapter(this, list));
        expandedView = null;
	}
	
	private void collapse() {
		if (expandedView == null)
			return;
		
		ImageView arrow = (ImageView) expandedView.findViewById(R.id.arrow);
		arrow.setImageResource(R.drawable.open_arrow);

		View view = (View) expandedView.findViewById(R.id.desc_details);
		((RelativeLayout) expandedView).removeView(view);

		expandedView = null;
	}

	private void expand(View view, String lemma) {
		String html = mTranslator.getInflectionTable(lemma);
		if (html == null)
			return;

		ImageView arrow = (ImageView) view.findViewById(R.id.arrow);
		arrow.setImageResource(R.drawable.close_arrow);
		
		WebView inflectionView = (WebView) view.findViewById(R.id.desc_details);
		if (inflectionView == null) {
			inflectionView = new WebView(this);
			inflectionView.setId(R.id.desc_details);
			RelativeLayout.LayoutParams params = 
					new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
			params.addRule(RelativeLayout.BELOW, R.id.lexical_desc);
			((RelativeLayout) view).addView(inflectionView, params);
		}

		inflectionView.loadData(html, "text/html; charset=UTF-8", null);

		expandedView = view;
	}

	private void expandExpr(View view, ExprProb ep) {
		ImageView arrow = (ImageView) view.findViewById(R.id.arrow);
		arrow.setImageResource(R.drawable.close_arrow);
		
		ParseTreeView parseView = (ParseTreeView) view.findViewById(R.id.desc_details);
		if (parseView == null) {
			parseView = new ParseTreeView(this);
			parseView.setId(R.id.desc_details);
			RelativeLayout.LayoutParams params = 
					new RelativeLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
			params.addRule(RelativeLayout.BELOW, R.id.alternative_desc);
			((RelativeLayout) view).addView(parseView, params);
		}

		Object[] brackets = mTranslator.bracketedLinearize(ep.getExpr());
		if (brackets[0] instanceof Bracket) {
			Bracket b = (Bracket) brackets[0];
			if (b.children[0].equals("*") ||
				b.children[0].equals("+")) {
				Object[] children = new Object[b.children.length-1];
				for (int i = 1; i < b.children.length; i++)
					children[i-1] = b.children[i];
				b = new Bracket(b.cat, b.fun, b.fid, b.lindex, children);
				brackets[0] = b;
			}
		}
		parseView.setBrackets(brackets); 

		expandedView = view;
	}

    private class AlternativesAdapter extends ArrayAdapter<Object> {
    	public AlternativesAdapter(Context context, List<Object> data) {
    		super(context, android.R.layout.simple_list_item_1, data);
    	}

    	public View getView(int position, View convertView, ViewGroup parent) {
			Object item = getItem(position);

			if (item instanceof MorphoAnalysis) {
				if (convertView == null) {
					LayoutInflater inflater = (LayoutInflater) 
							getContext().getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
		            convertView = inflater.inflate(R.layout.lexical_item, null);
		        }

		        TextView descView = (TextView)
		        	convertView.findViewById(R.id.lexical_desc);

				final String lemma = ((MorphoAnalysis) item).getLemma();

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
			} else if (item instanceof ExprProb) {
				final ExprProb ep = (ExprProb) item;
	
				if (convertView == null) {
					LayoutInflater inflater = (LayoutInflater) 
							getContext().getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
		            convertView = inflater.inflate(R.layout.alternative_item, null);
		        }

		        TextView descView = (TextView)
		        	convertView.findViewById(R.id.alternative_desc);

		    	String phrase = mTranslator.linearize(ep.getExpr());

		    	// parse by words, marked by %, darkest red color
		    	if (phrase.charAt(0) == '%') {
		    		descView.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
		    		phrase = phrase.substring(2);
		    	}

		    	// parse by chunks, marked by *, red color
		    	else if (phrase.charAt(0) == '*') {
		    		descView.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_chunk_utterance_bg));
		    		phrase = phrase.substring(2);
		    	}

		    	// parse error or unknown translations (in []) present, darkest red color
		    	else if (phrase.contains("parse error:") || phrase.contains("[")) {
		    		descView.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_worst_utterance_bg));
		    	}

		    	// parse by domain grammar, marked by +, green color
		    	else if (phrase.charAt(0) == '+') {
		    		descView.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_best_utterance_bg));
		    		phrase = phrase.substring(2);
		    	}
		    	
		    	else {
		    		descView.setBackgroundDrawable(getResources().getDrawable(R.drawable.second_person_utterance_bg));
		    	}

		        descView.setText(phrase);

		        convertView.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View view) {
						if (expandedView == view)
							collapse();
						else if (expandedView == null)
							expandExpr(view, ep);
						else {
							collapse();
							expandExpr(view, ep);
						}
					}
				});
			}

			return convertView;
	    }
    }
}
