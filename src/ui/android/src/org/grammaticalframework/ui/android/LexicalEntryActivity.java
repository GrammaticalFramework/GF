package org.grammaticalframework.ui.android;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.content.res.XmlResourceParser;
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
import org.xmlpull.v1.XmlPullParserException;

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
		String tag = null;
		if (lemma.endsWith("_N") || lemma.endsWith("_N2"))
			tag = "noun";
		else if (lemma.endsWith("_V")  || lemma.endsWith("_V2")  || 
				 lemma.endsWith("_V3") || lemma.endsWith("_V2V") ||
				 lemma.endsWith("_VV") || lemma.endsWith("_VS"))
			tag = "verb";
		else if (lemma.endsWith("_A") || lemma.endsWith("_A2")) 
			tag = "adjective";
		else if (lemma.endsWith("_Prep")) 
			tag = "prep";
		else if (lemma.endsWith("_Adv")) 
			tag = "adverb";

		if (tag == null)
			return;
		
		int res = mTranslator.getTargetLanguage().getInflectionResource();
		if (res == 0)
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

		Expr expr = Expr.readExpr(lemma);
		Map<String,String> lins = mTranslator.tabularLinearize(expr);
		XmlResourceParser parser = getResources().getXml(res);
		StringBuilder builder = new StringBuilder();
		builder.append("<html><head><meta charset=\"UTF-8\"/></head><body>");
		
		try {
			boolean emit = false;
			boolean form = false;
			int event = parser.next();
			while (event != XmlResourceParser.END_DOCUMENT) {
				switch (event) {
				case XmlResourceParser.START_TAG:
					if (tag.equals(parser.getName())) {
						emit = true;
					} if ("form".equals(parser.getName())) {
						form = true;
					} else if (emit) {
						builder.append("<"+parser.getName());
						int n_attrs = parser.getAttributeCount();
						for (int i = 0; i < n_attrs; i++) {
							builder.append(' ');
							builder.append(parser.getAttributeName(i));
							builder.append("=\"");
							builder.append(parser.getAttributeValue(i));
							builder.append("\"");
						}
						builder.append(">");
					}
					break;
				case XmlResourceParser.END_TAG:
					if (tag.equals(parser.getName())) {
						emit = false;
					} else if ("form".equals(parser.getName())) {
						form = false;
					} else if (emit) {
						builder.append("</"+parser.getName()+">");
					}
					break;
				case XmlResourceParser.TEXT:
					if (emit) {
						if (form) {
							String s = lins.get(parser.getText());
							if (s != null)
								builder.append(s);
						} else {
							builder.append(parser.getText());
						}
					}
					break;
				}
				event = parser.next();
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} finally {
			parser.close();
		}
		
		builder.append("</body>");
		inflectionView.loadData(builder.toString(), "text/html; charset=UTF-8", null);

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

	    	String phrase = mTranslator.generateTranslationEntry(lemma);
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
