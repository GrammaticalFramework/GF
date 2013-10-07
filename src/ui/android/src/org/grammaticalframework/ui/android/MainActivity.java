
package org.grammaticalframework.ui.android;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.speech.SpeechRecognizer;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;

import org.grammaticalframework.ui.android.ASR.State;
import org.grammaticalframework.ui.android.LanguageSelector.OnLanguageSelectedListener;

public class MainActivity extends Activity {

    private static final boolean DBG = true;
    private static final String TAG = "DemoActivity";

    private static final boolean FAKE_SPEECH = false;

    private ImageView mStartStopButton;

    private ConversationView mConversationView;

    private LanguageSelector mSourceLanguageView;

    private LanguageSelector mTargetLanguageView;

    private ImageView mSwitchLanguagesButton;

    private ASR mAsr;

    private TTS mTts;

    // mTranslator is static to ensure that the grammar
    // is loaded only once even if the activity has been recreated.
    private static Translator mTranslator;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mStartStopButton = (ImageView) findViewById(R.id.start_stop);
        mConversationView = (ConversationView) findViewById(R.id.conversation);
        mSourceLanguageView = (LanguageSelector) findViewById(R.id.source_language);
        mTargetLanguageView = (LanguageSelector) findViewById(R.id.target_language);
        mSwitchLanguagesButton = (ImageView) findViewById(R.id.switch_languages);

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

        mStartStopButton.setEnabled(SpeechRecognizer.isRecognitionAvailable(this));

        mAsr = new ASR(this);
        mAsr.setListener(new SpeechInputListener());

        mTts = new TTS(this);

        if (mTranslator == null) {
        	mTranslator = new Translator(this);
        }

        mSourceLanguageView.setLanguages(mTranslator.getAvailableSourceLanguages());
        mSourceLanguageView.setSelectedLanguage(mTranslator.getSourceLanguage());
        mSourceLanguageView.setOnLanguageSelectedListener(new OnLanguageSelectedListener() {
            @Override
            public void onLanguageSelected(Language language) {
                onSourceLanguageSelected(language);
            }
        });
        mTargetLanguageView.setLanguages(mTranslator.getAvailableTargetLanguages());
        mTargetLanguageView.setSelectedLanguage(mTranslator.getTargetLanguage());
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
    }

    void onTargetLanguageSelected(Language language) {
        mTranslator.setTargetLanguage(language);
    }

    public String getSourceLanguageCode() {
        return mTranslator.getSourceLanguage().getLangCode();
    }

    public String getTargetLanguageCode() {
        return mTranslator.getTargetLanguage().getLangCode();
    }

    void onSwitchLanguages() {
        Language newSource = mTranslator.getTargetLanguage();
        Language newTarget = mTranslator.getSourceLanguage();
        mSourceLanguageView.setSelectedLanguage(newSource);
        mTargetLanguageView.setSelectedLanguage(newTarget);
    }

    private void startRecognition() {
        mConversationView.addFirstPersonUtterance("...");

        if (FAKE_SPEECH) {
            handleSpeechInput("where is the hotel");
        } else {
            mAsr.setLanguage(getSourceLanguageCode());
            mAsr.startRecognition();
        }
    }

    private void stopRecognition() {
        mAsr.stopRecognition();
    }

    private void handlePartialSpeechInput(String input) {
        mConversationView.updateLastUtterance(input);
    }

    private void handleSpeechInput(final String input) {
        mConversationView.updateLastUtterance(input);
        new AsyncTask<Void,Void,String>() {
            @Override
            protected String doInBackground(Void... params) {
                return mTranslator.translate(input);
            }

            @Override
            protected void onPostExecute(String result) {
                outputText(result);
            }
        }.execute();
    }

    private void outputText(String text) {
        if (DBG) Log.d(TAG, "Speaking: " + text);
        mConversationView.addSecondPersonUtterance(text);
        if (!FAKE_SPEECH) {
            mTts.setLanguage(getTargetLanguageCode());
            mTts.speak(text);
        }
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
//            if (newState == ASR.State.IDLE) {
//                mStartStopButton.setImageResource(R.drawable.mic_idle);
//            } else {
//                mStartStopButton.setImageResource(R.drawable.mic_open);
//            }
        }
    }
}
