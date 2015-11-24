package org.grammaticalframework.ui.android;

import java.util.*;

import android.app.Activity;
import android.app.SearchManager;
import android.os.Bundle;
import android.os.AsyncTask;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.Toast;
import android.content.Intent;

import org.grammaticalframework.pgf.MorphoAnalysis;
import org.grammaticalframework.ui.android.LanguageSelector.OnLanguageSelectedListener;

public class SemanticGraphActivity extends Activity {
	private Translator mTranslator;

	private LanguageSelector mLanguageView;
	private View mProgressBarView = null;
	private ImageView mAddWordButton;
	private SemanticGraphView mGraphView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_semantic_graph);
        
        mTranslator = ((GFTranslator) getApplicationContext()).getTranslator();
        
        mLanguageView = (LanguageSelector) findViewById(R.id.show_language);
        mLanguageView.setLanguages(mTranslator.getAvailableLanguages());
	    mLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(final Language language) {
                new AsyncTask<Void,Void,Void>() {
                	@Override
                	protected void onPreExecute() {
                		showProgressBar();
                	}

                    @Override
                    protected Void doInBackground(Void... params) {
                        mTranslator.setSourceLanguage(language);
                        mTranslator.isTargetLanguageLoaded();
                        return null;
                    }

                    @Override
                    protected void onPostExecute(Void result) {
                        hideProgressBar();
                    }
                }.execute();
            }
        });

        mAddWordButton = (ImageView) findViewById(R.id.add_word);

        mGraphView = (SemanticGraphView) findViewById(R.id.semantic_graph);

        mAddWordButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
				onSearchRequested();
            }
        });
        
        mProgressBarView = findViewById(R.id.progressBarView);
    }

	@Override
	protected void onResume() {
		super.onResume();

		mLanguageView.setSelectedLanguage(mTranslator.getSourceLanguage());
	}

	private void showProgressBar() {
		mProgressBarView.setVisibility(View.VISIBLE);
	}
	
	private void hideProgressBar() {
		mProgressBarView.setVisibility(View.GONE);
	}

	@Override
    protected void onNewIntent (Intent intent) {
		if (Intent.ACTION_SEARCH.equals(intent.getAction())) {
			String query = intent.getStringExtra(SearchManager.QUERY);
			List<MorphoAnalysis> list = mTranslator.lookupMorpho(query);
			if (list == null || list.size() == 0) {
				Toast toast = Toast.makeText(this, "\""+query+"\" doesn't match", Toast.LENGTH_SHORT);
				toast.show();
			} else {
				mGraphView.getGraph().addNode(query, list);
				mGraphView.refresh();
			}
		}
	}	
}
