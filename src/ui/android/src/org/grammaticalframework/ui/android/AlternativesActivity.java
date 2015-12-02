package org.grammaticalframework.ui.android;

import java.util.*;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.*;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.view.MenuItem;
import android.view.LayoutInflater;
import android.webkit.WebView;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ListView;
import android.widget.AdapterView;
import android.util.Log;
import android.support.v4.widget.DrawerLayout;
import android.support.v4.app.ActionBarDrawerToggle;

import org.grammaticalframework.pgf.*;
import org.grammaticalframework.ui.android.LanguageSelector.OnLanguageSelectedListener;

public class AlternativesActivity extends ListActivity {

	private Translator mTranslator;
	private LanguageSelector mShowLanguageView;
	private View mProgressBarView = null;
	private AlternativesAdapter mAdapter = null;
	private DrawerLayout mDrawerLayout;
	private ListView mDrawerList;
	private ActionBarDrawerToggle mDrawerToggle;

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
                        mAdapter.notifyDataSetChanged();
                        expandedView = null;
                        hideProgressBar();
                    }
                }.execute();
            }
        });

		mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
		mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
		                                          R.drawable.ic_drawer,
		                                          R.string.topics_open,
		                                          R.string.topics_close);
		mDrawerLayout.setDrawerListener(mDrawerToggle);

		getActionBar().setDisplayHomeAsUpEnabled(true);
        getActionBar().setHomeButtonEnabled(true);

	    TextView descrView = (TextView) findViewById(R.id.lexical_desc);

	    if (getIntent().getData() != null) {
			String authority = getIntent().getData().getAuthority();
			String source = getIntent().getData().getQueryParameter("source");

			List analyses = new ArrayList();
			for (String an : getIntent().getData().getQueryParameters("alternative")) {
				analyses.add(Expr.readExpr(an));
			}
			descrView.setText(source);
			
			mAdapter = new AlternativesAdapter(this, authority, analyses);
		} else {
	        mDrawerLayout.openDrawer(Gravity.LEFT);

	        mAdapter = new AlternativesAdapter(this, Translator.WORDS);
		}

		expandedView = null;
		setListAdapter(mAdapter);

		mDrawerList = (ListView) findViewById(R.id.topics_list);
		mDrawerList.setAdapter(mAdapter.getTopicsAdapter());

	    mProgressBarView = findViewById(R.id.progressBarView);
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

	private void collapse() {
		if (expandedView == null)
			return;
		
		ImageView arrow = (ImageView) expandedView.findViewById(R.id.arrow);
		arrow.setImageResource(R.drawable.open_arrow);

		View view = (View) expandedView.findViewById(R.id.desc_details);
		((RelativeLayout) expandedView).removeView(view);

		TextView textView = (TextView) expandedView.findViewById(R.id.abstract_tree);
		if (textView != null)
			((RelativeLayout) expandedView).removeView(textView);

		expandedView = null;
	}

	private void expandWord(View view, Expr lemma) {
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

	private void expandSentence(View view, Expr expr) {
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

		Object[] brackets = mTranslator.bracketedLinearize(expr);
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
		
		TextView textView = (TextView) view.findViewById(R.id.abstract_tree);
		if (textView == null) {
			textView = new TextView(this);
			textView.setId(R.id.abstract_tree);
			textView.setTextSize(15);
			RelativeLayout.LayoutParams params = 
				new RelativeLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
			params.addRule(RelativeLayout.BELOW, R.id.desc_details);
			((RelativeLayout) view).addView(textView, params);
		}
		textView.setText(expr.toString());

		expandedView = view;
	}

	private class Topic {
		public String name;
		public Expr expr;
		public boolean isChecked;
		public boolean isAvailable;
		
		public Topic(String name, Expr expr) {
			this.name        = name;
			this.expr        = expr;
			this.isChecked   = false;
			this.isAvailable = true;
		}
	}

	private class AlternativesAdapter extends BaseAdapter implements ListAdapter {
		/**
		 * Contains the list of objects that represent the alternatives
		 */
		private List<Expr> mAlternatives;

		private Context mContext;

		// A copy of the original mAlternatives array, initialized from and then used instead as soon as
		// a topic filtering is applied. mAlternatives will then only contain the filtered values.
		private ArrayList<Expr> mOriginalAlternatives;

		private LayoutInflater mInflater;

		private String mAuthority;
		
		/**
		 * A list of lists of topics. Each element in this list contains
		 * the list of topics for the correponding item in 
		 * mAlternatives/mOriginalAlternatives
		 */
		private List<List<Topic>> mTopics;

		private Map<String,Topic> mTopicMap;
		private Topic[] mAllTopics;
		private Topic[] mOriginalAllTopics;

		private Topic mOtherTopic;
		private Topic mSourceTopic;

		private TopicsAdapter mTopicsAdapter;

		public AlternativesAdapter(Context context, String authority, List<Expr> alternatives) {
			mContext = context;
			mAuthority = authority;
			mInflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
			mAlternatives = alternatives;

			boolean addOther = false;
			mTopics = new ArrayList<List<Topic>>();
			mTopicMap = new TreeMap<String,Topic>();
			for (Expr e : mAlternatives) {
				List<Topic> topics = new ArrayList<Topic>();
				for (Expr topicExpr : mTranslator.getTopicsOf(e)) {
					String name = mTranslator.linearizeSource(topicExpr);
					String key  = name.toLowerCase();
					Topic topic = mTopicMap.get(key);
					if (topic == null) {
						topic = new Topic(name, topicExpr);
						mTopicMap.put(key,topic);
					}
					topics.add(topic);
				}
				mTopics.add(topics);

				if (topics.size() == 0)
					addOther = true;
			}

			int i = 0;
			mAllTopics = new Topic[mTopicMap.size() + (addOther ? 1 : 0)];
			for (Map.Entry<String,Topic> entry : mTopicMap.entrySet()) {
				mAllTopics[i++] = entry.getValue();
			}
			if (addOther) {
				Expr topicExpr = Expr.readExpr("other_1_A");
				String name = mTranslator.linearizeSource(topicExpr);
				mOtherTopic = new Topic(name, topicExpr);
				mAllTopics[i++] = mOtherTopic;
			}

			mOriginalAllTopics = mAllTopics;

			mTopicsAdapter = new TopicsAdapter();
		}

		public AlternativesAdapter(Context context, String authority) {
			mContext = context;
			mAuthority = authority;
			mInflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
			mAlternatives = null;

			mTopics = null;

			int i = 0;
			mTopicMap = new TreeMap<String,Topic>();
			for (Expr topicExpr : mTranslator.getTopicsOf(null)) {
				String name = mTranslator.linearizeSource(topicExpr);
				String key  = name.toLowerCase();
				Topic topic = mTopicMap.get(key);
				if (topic == null) {
					topic = new Topic(name, topicExpr);
					mTopicMap.put(key,topic);
				}
			}
			mAllTopics = new Topic[mTopicMap.size()];
			for (Map.Entry<String,Topic> entry : mTopicMap.entrySet()) {
				mAllTopics[i++] = entry.getValue();
			}

			mOriginalAllTopics = mAllTopics;

			mTopicsAdapter = new TopicsAdapter();
		}

		/**
		 * Returns the context associated with this array adapter. The context is used
		 * to create views from the resource passed to the constructor.
		 *
		 * @return The Context associated with this adapter.
		 */
		public Context getContext() {
			return mContext;
		}

		public String getAuthority() {
			return mAuthority;
		}

		/**
		 * {@inheritDoc}
		 */
		public int getCount() {
			if (mAlternatives == null)
				return 0;
			else
				return mAlternatives.size();
		}

		/**
		 * {@inheritDoc}
		 */
		public Expr getItem(int position) {
			return mAlternatives.get(position);
		}

		/**
		 * Returns the position of the specified item in the array.
		 *
		 * @param item The item to retrieve the position of.
		 *
		 * @return The position of the specified item.
		 */
		public int getPosition(Expr item) {
			if (mAlternatives == null)
				return -1;
			else
				return mAlternatives.indexOf(item);
		}

		/**
		 * {@inheritDoc}
		 */
		public long getItemId(int position) {
			return position;
		}

    	public View getView(int position, View convertView, ViewGroup parent) {
			final Expr expr = getItem(position);

			if (mAuthority.equals(Translator.WORDS)) {
				if (convertView == null) {
		            convertView = mInflater.inflate(R.layout.lexical_item, null);
		        }

		        TextView descView = (TextView)
		        	convertView.findViewById(R.id.lexical_desc);

		    	String phrase = mTranslator.generateLexiconEntry(expr);
		        descView.setText(phrase);

		        convertView.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View view) {
						if (expandedView == view)
							collapse();
						else if (expandedView == null)
							expandWord(view, expr);
						else {
							collapse();
							expandWord(view, expr);
						}
					}
				});
			} else if (mAuthority.equals(Translator.SENTENCES)) {
				if (convertView == null) {
		            convertView = mInflater.inflate(R.layout.alternative_item, null);

		            View treeView = (View) convertView.findViewById(R.id.desc_details);
		    		((RelativeLayout) convertView).removeView(treeView);

		    		TextView textView = (TextView) convertView.findViewById(R.id.abstract_tree);
		    		((RelativeLayout) convertView).removeView(textView);
		        }

		        TextView descView = (TextView)
		        	convertView.findViewById(R.id.alternative_desc);

		    	String phrase = mTranslator.linearize(expr);

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
							expandSentence(view, expr);
						else {
							collapse();
							expandSentence(view, expr);
						}
					}
				});
			}

			return convertView;
	    }
	    
	    public boolean areAllItemsEnabled() {
			return true;
		}
		
		public boolean isEnabled(int position) {
			return true;
		}
		
		public TopicsAdapter getTopicsAdapter() {
			return mTopicsAdapter;
		}
		
		void filterOnTopics(List<Topic> selected_topics) {
			if (mSourceTopic != null && !selected_topics.contains(mSourceTopic))
				mAlternatives = null;

			if (mAlternatives == null) {
				if (selected_topics.size() == 0)
					return;

				mSourceTopic = selected_topics.get(0);
				mAlternatives = mTranslator.getTopicWords(mSourceTopic.expr);
				
				mTopics = new ArrayList<List<Topic>>();
				for (Expr e : mAlternatives) {
					List<Topic> topics = new ArrayList<Topic>();
					for (Expr topicExpr : mTranslator.getTopicsOf(e)) {
						String name = mTranslator.linearizeSource(topicExpr);
						String key  = name.toLowerCase();
						topics.add(mTopicMap.get(key));
					}
					mTopics.add(topics);
				}
			}

			if (mOriginalAlternatives == null) {
				mOriginalAlternatives = new ArrayList<Expr>(mAlternatives);
            }

			mAlternatives = new ArrayList<Expr>();
			List<List<Expr>> topics = new ArrayList<List<Expr>>();

			for (Topic topic : mOriginalAllTopics) {
				topic.isAvailable = false;
			}

			int count = 0;
            for (int i = 0; i < mOriginalAlternatives.size(); i++) {
				boolean match = true;
				for (Topic topic : selected_topics) {
					if (topic == mOtherTopic) {
						if (mTopics.get(i).size() > 0) {
							match = false;
							break;
						}
					} else if (!mTopics.get(i).contains(topic)) {
						match = false;
						break;
					}
				}
				if (match) {
					mAlternatives.add(mOriginalAlternatives.get(i));
					if (mTopics.get(i).size() == 0) {
						if (!mOtherTopic.isAvailable)
							count++;
						mOtherTopic.isAvailable = true;
					} else {
						for (Topic topic : mTopics.get(i)) {
							if (!topic.isAvailable)
								count++;
							topic.isAvailable = true;
						}
					}
				}
			}

			int i = 0;
			mAllTopics = new Topic[count];
			for (Topic topic : mOriginalAllTopics) {
				if (topic.isAvailable)
					mAllTopics[i++] = topic;
			}

			notifyDataSetChanged();
		}
	}

    private class TopicsAdapter extends BaseAdapter implements ListAdapter {
    	public TopicsAdapter() {
    	}

		public Context getContext() {
			return mAdapter.getContext();
		}

		public int getCount() {
			return mAdapter.mAllTopics.length;
		}

		public Topic getItem(int position) {
			return mAdapter.mAllTopics[position];
		}

		public int getPosition(Topic topic) {
			for (int i = 0; i < mAdapter.mAllTopics.length; i++) {
				if (mAdapter.mAllTopics[i] == topic)
					return i;
			}
			return -1;
		}

		public long getItemId(int position) {
			return position;
		}

		// Shame on you Google this class should not have been here
		// but unfortuantely CheckBox.setChecked doesn't work and here
		// we need a workarround. Since the class is there now it is also
		// used to implement OnClickListener.
		private class TopicCheckBox extends CheckBox implements OnClickListener {
			private Topic mTopic;
			
			public TopicCheckBox(Context context, Topic topic) {
				super(context);
				mTopic = topic;
				setOnClickListener(this);
			}

			@Override
			public boolean isChecked() {
				if (mTopic == null)
					return false;
				else
					return mTopic.isChecked;
			}

			@Override
			public void onClick(View view) {
				mTopic.isChecked = !mTopic.isChecked;
				filterOnTopics();
				notifyDataSetChanged();
			}
		}

		private void filterOnTopics() {
			List<Topic> selected_topics = new ArrayList<Topic>();
			for (int i = 0; i < getCount(); i++) {
				Topic topic = getItem(i);
				if (topic.isChecked)
					selected_topics.add(topic);
			}
			mAdapter.filterOnTopics(selected_topics);
		}

    	public View getView(int position, View convertView, ViewGroup parent) {
			Topic entry = getItem(position);

			CheckBox checkBox = new TopicCheckBox(getContext(), entry);
			checkBox.setText(entry.name);
			checkBox.setTextSize(25);
			checkBox.setTextColor(android.graphics.Color.parseColor("#808080"));
			return checkBox;
	    }
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        // Sync the toggle state after onRestoreInstanceState has occurred.
        mDrawerToggle.syncState();
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        mDrawerToggle.onConfigurationChanged(newConfig);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Pass the event to ActionBarDrawerToggle, if it returns
        // true, then it has handled the app icon touch event
        if (mDrawerToggle.onOptionsItemSelected(item)) {
          return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
