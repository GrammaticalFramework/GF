package org.grammaticalframework.ui.android;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.app.ListActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
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
	    mShowLanguageView.setLanguages(mTranslator.getAvailableSourceLanguages());
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

	    ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, 
	    	android.R.layout.simple_list_item_1, 
	    	data) {
	    		public View getView(int position, View convertView, ViewGroup parent) {
	    			String item = getItem(position);
	    			
	    			LayoutInflater inflater = (LayoutInflater) getContext()
	    	                .getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
	    	        if (convertView == null) {
	    	            convertView = inflater.inflate(R.layout.lexical_item, null);
	    	        } 

	    	        TextView descView =
	    	        		(TextView) convertView.findViewById(R.id.lexical_desc);
	    	        descView.setText(item);

	    			return convertView;
	    	    }
	    };
	    
        setListAdapter(adapter);	
	}
}
