package org.grammaticalframework.ui.android;

import java.util.ArrayList;
import java.util.List;

import android.app.ListActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;

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
	    mShowLanguageView.setLanguages(mTranslator.getAvailableSourceLanguages());
	    mShowLanguageView.setSelectedLanguage(mTranslator.getTargetLanguage());
	    mShowLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(Language language) {
            	mTranslator.setTargetLanguage(language);
                updateTranslations();
            }
        });

	    updateTranslations();
      }
	
	private void updateTranslations() {
	    @SuppressWarnings("unchecked")
		List<MorphoAnalysis> list = (List<MorphoAnalysis>)
	    	getIntent().getExtras().getSerializable("analyses");

		List<String> data = new ArrayList<String>();
	    for (MorphoAnalysis a : list) {
	    	Expr e = Expr.readExpr(a.getLemma());
	    	String phrase = mTranslator.linearize(e);
	    	
	    	if (!data.contains(phrase)) {
		    	data.add(phrase);
	    	}
	    }

	    ArrayAdapter adapter = new ArrayAdapter(this, 
	    	android.R.layout.simple_list_item_1, 
	    	data);
        setListAdapter(adapter);	
	}
}
