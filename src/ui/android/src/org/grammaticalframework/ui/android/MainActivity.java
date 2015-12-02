package org.grammaticalframework.ui.android;

import java.io.*;
import java.util.*;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.speech.SpeechRecognizer;
import android.net.Uri;
import android.util.Log;
import android.util.Pair;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnTouchListener;
import android.widget.ImageView;

import org.grammaticalframework.ui.android.ASR.State;
import org.grammaticalframework.ui.android.LanguageSelector.OnLanguageSelectedListener;
import org.grammaticalframework.ui.android.ConversationView.OnAlternativesListener;
import org.grammaticalframework.pgf.*;

public class MainActivity extends Activity {

    private static final boolean DBG = true;
    private static final String TAG = "MainActivity";

    private ImageView mStartStopButton;

    private ConversationView mConversationView;

    private LanguageSelector mSourceLanguageView;

    private LanguageSelector mTargetLanguageView;

    private ImageView mSwitchLanguagesButton;

    private ASR mAsr;

    private TTS mTts;

    private Translator mTranslator;
    
    private boolean input_mode;

    private SpeechInputListener mSpeechListener;
    
	private View mProgressBarView = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mStartStopButton = (ImageView) findViewById(R.id.start_stop);
        mConversationView = (ConversationView) findViewById(R.id.conversation);
        mSourceLanguageView = (LanguageSelector) findViewById(R.id.source_language);
        mTargetLanguageView = (LanguageSelector) findViewById(R.id.target_language);
        mSwitchLanguagesButton = (ImageView) findViewById(R.id.switch_languages);
        mProgressBarView = findViewById(R.id.progressBarView);

        mStartStopButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mAsr.isRunning()) {
                    stopRecognition();
                } else {
                    startRecognition();
                }
            }
        });

        SharedPreferences pref = getPreferences(MODE_PRIVATE);
        input_mode = pref.getBoolean("input_mode", true);
        if (!SpeechRecognizer.isRecognitionAvailable(this)) {
        	input_mode = false;
        }
        mStartStopButton.setImageResource(input_mode ? R.drawable.ic_mic : R.drawable.ic_keyboard);

        mSpeechListener = new SpeechInputListener();
        
        mConversationView.setOnAlternativesListener(new OnAlternativesListener() {
            @Override
            public void onAlternativesSelected(CharSequence authority, CharSequence input, List<Expr> alternatives) {
				Uri.Builder builder = new Uri.Builder();
				builder.scheme("gf-translator");
				builder.authority(authority.toString());
				builder.appendQueryParameter("source", input.toString());
				for (Expr e : alternatives) {
					builder.appendQueryParameter("alternative", e.toString());
				}

            	Intent myIntent = new Intent(Intent.ACTION_VIEW, builder.build());
            	MainActivity.this.startActivity(myIntent);
            }
        });
        mConversationView.setSpeechInputListener(mSpeechListener);

        mAsr = new ASR(this);
        mAsr.setListener(mSpeechListener);

        mTts = new TTS(this);

        mTranslator = ((GFTranslator) getApplicationContext()).getTranslator();

        mSourceLanguageView.setLanguages(mTranslator.getAvailableLanguages());
        mSourceLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(Language language) {
                onSourceLanguageSelected(language);
            }
        });
        mTargetLanguageView.setLanguages(mTranslator.getAvailableLanguages());
        mTargetLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(Language language) {
                onTargetLanguageSelected(language);
            }
        });

        mSwitchLanguagesButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                onSwitchLanguages();
            }
        });
        
		if (savedInstanceState != null) {
			mConversationView.restoreConversation(savedInstanceState);
		}
    }

	@Override
	protected void onResume() {
		super.onResume();

		mSourceLanguageView.setSelectedLanguage(mTranslator.getSourceLanguage());
		mTargetLanguageView.setSelectedLanguage(mTranslator.getTargetLanguage());
	}

	private void showProgressBar() {
		mProgressBarView.setVisibility(View.VISIBLE);
	}
	
	private void hideProgressBar() {
		mProgressBarView.setVisibility(View.GONE);
	}

	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		mConversationView.saveConversation(outState);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
	    MenuInflater inflater = getMenuInflater();
	    inflater.inflate(R.menu.main, menu);

	    menu.getItem(0).setTitle(input_mode ? R.string.keyboard_input : R.string.mic_input);

	    if (!SpeechRecognizer.isRecognitionAvailable(this)) {
	    	menu.getItem(0).setEnabled(false);
	    }
	    return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
	    // Handle item selection
	    switch (item.getItemId()) {
	        case R.id.input_mode:
	        	if (input_mode) {
	        		item.setTitle(R.string.mic_input);
	        		mStartStopButton.setImageResource(R.drawable.ic_keyboard);
	        		input_mode = false;
	        	} else {
	        		item.setTitle(R.string.keyboard_input);
	        		mStartStopButton.setImageResource(R.drawable.ic_mic);
	        		input_mode = true;
	        	}

	        	SharedPreferences.Editor editor = getPreferences(MODE_PRIVATE).edit();
	        	editor.putBoolean("input_mode", input_mode);
	        	editor.commit();

	            return true;
	        case R.id.topics: {
	        	Intent myIntent = new Intent(MainActivity.this, AlternativesActivity.class);
            	MainActivity.this.startActivity(myIntent);
	        	return true;
	        }
	        case R.id.help: {
	        	Intent myIntent = new Intent(MainActivity.this, HelpActivity.class);
            	MainActivity.this.startActivity(myIntent);
	        	return true;
	        }
	        default:
	            return super.onOptionsItemSelected(item);
	    }
	}

    @Override
    protected void onDestroy() {
        if (mAsr != null) {
            mAsr.destroy();
            mAsr = null;
        }
        if (mTts != null) {
            mTts.destroy();
            mTts = null;
        }
        super.onDestroy();
    }

    void onSourceLanguageSelected(Language language) {
        mTranslator.setSourceLanguage(language);
        if (TranslatorInputMethodService.getInstance() != null) {
        	TranslatorInputMethodService.getInstance().handleChangeSourceLanguage(language);
        }
    }

    void onTargetLanguageSelected(Language language) {
        mTranslator.setTargetLanguage(language);
        if (TranslatorInputMethodService.getInstance() != null) {
        	TranslatorInputMethodService.getInstance().handleChangeTargetLanguage(language);
        }
    }

    public String getSourceLanguageCode() {
        return mTranslator.getSourceLanguage().getLangCode();
    }

    public String getTargetLanguageCode() {
        return mTranslator.getTargetLanguage().getLangCode();
    }

    void onSwitchLanguages() {
    	mTranslator.switchLanguages();
        mSourceLanguageView.setSelectedLanguage(mTranslator.getSourceLanguage());
        mTargetLanguageView.setSelectedLanguage(mTranslator.getTargetLanguage());

        if (TranslatorInputMethodService.getInstance() != null) {
        	TranslatorInputMethodService.getInstance().handleSwitchLanguages();
        }
    }

    private void startRecognition() {
    	if (input_mode) {
    		mConversationView.addFirstPersonUtterance("...", false);
            mAsr.setLanguage(getSourceLanguageCode());
            mAsr.startRecognition();
    	} else {
    		mConversationView.addFirstPersonUtterance("", true);
    	}
    }

    private void stopRecognition() {
        mAsr.stopRecognition();
    }

    private void handlePartialSpeechInput(String input) {
        mConversationView.updateLastUtterance(input);
    }

    private void handleSpeechInput(final String input) {
    	final List<MorphoAnalysis> list = mTranslator.lookupMorpho(input);

        mConversationView.updateLastUtterance(input);
        new AsyncTask<Void,Void,Pair<String,List<ExprProb>>>() {
        	@Override
        	protected void onPreExecute() {
        		showProgressBar();
        	}

            @Override
            protected Pair<String,List<ExprProb>> doInBackground(Void... params) {
                return mTranslator.translate(input);
            }

            @Override
            protected void onPostExecute(Pair<String,List<ExprProb>> res) {
            	String text = res.first;
            	List<ExprProb> transl = res.second;

            	List<Expr> alts = null;
				String authority = null;

            	// filter out duplicates
            	int i = 0;
            	if (list.size() > 0) {
					alts = new ArrayList(list.size());
					authority = Translator.WORDS;

	            	while (i < list.size()) {
	            		MorphoAnalysis an = list.get(i);
	            		boolean found = false;
	            		for (int j = 0; j < i; j++) {
	            			if (list.get(j).getLemma().equals(an.getLemma())) {
	            				found = true;
	            				break;
	            			}
	            		}
	            		
	            		if (!found) {
	         				alts.add(Expr.readExpr(an.getLemma()));
	         			}

	         			i++;
	            	}
            	} else {
					alts = new ArrayList(transl.size());
					authority = Translator.SENTENCES;

            		Set<String> strings = new HashSet<String>();
            		while (i < transl.size()) {
            			String s = mTranslator.linearize(transl.get(i).getExpr());
            		   	if (s.length() > 0 && 
            		   	    (s.charAt(0) == '%' || s.charAt(0) == '*' || s.charAt(0) == '+')) {
    			    		s = s.substring(2);
    			    	}

	            		if (!strings.contains(s)) {
	            			strings.add(s);
							alts.add(transl.get(i).getExpr());
	         			}

	         			i++;
	            	}
	           	}

                if (DBG) Log.d(TAG, "Speaking: " + res.first);
            	CharSequence text2 = 
            		mConversationView.addSecondPersonUtterance(authority, input, text, alts);
            	text2 = text2.toString().replace('[',' ').replace(']',' ').replaceAll("_","").trim();
                mTts.speak(getTargetLanguageCode(), text2.toString());

                hideProgressBar();
            }
        }.execute();
    }

    private class SpeechInputListener implements ASR.Listener {

        @Override
        public void onPartialInput(String input) {
            handlePartialSpeechInput(input);
        }

        @Override
        public void onSpeechInput(String input) {
            handleSpeechInput(input);
        }

        @Override
        public void onStateChanged(State newState) {
            if (newState == ASR.State.IDLE) {
				//clear the overlay
	            mStartStopButton.getDrawable().clearColorFilter();
            } else {
	            mStartStopButton.getDrawable().setColorFilter(0xffff0000,android.graphics.PorterDuff.Mode.SRC_ATOP);
            }
            mStartStopButton.invalidate();
        }
    }
}
