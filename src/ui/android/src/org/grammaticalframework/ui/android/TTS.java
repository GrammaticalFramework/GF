package org.grammaticalframework.ui.android;

import android.content.Context;
import android.media.AudioManager;
import android.speech.tts.TextToSpeech;
import android.util.Log;

import java.util.HashMap;
import java.util.Locale;

public class TTS {

    private static final String TAG = "TTS";

    private TextToSpeech mTts;
    private AudioManager mAudioManager;

    public TTS(Context context) {
        mTts = new TextToSpeech(context, new InitListener());
        mAudioManager = (AudioManager)context.getSystemService(Context.AUDIO_SERVICE);
    }

    public void setLanguage(String language) {
        Locale locale = LocaleUtils.parseJavaLocale(language.replace('-', '_'),
                Locale.getDefault());

        int result = mTts.setLanguage(locale);
        if (result == TextToSpeech.LANG_MISSING_DATA ||
            result == TextToSpeech.LANG_NOT_SUPPORTED) {
            Log.e(TAG, "Language is not available");
        } else {
            // TODO: the language may be available for the locale,
            // but not for the specified country and variant.
        }
    }

    // TODO: handle speak() calls before service connects
    public void speak(String text) {
    	if (mAudioManager.getRingerMode() == AudioManager.RINGER_MODE_NORMAL) {
	        HashMap<String,String> params = new HashMap<String,String>();
	        // TODO: how can I get network / embedded fallback?
	        // Using both crashes the TTS engine if the offline data is not installed
	        // Using only one doesn't allow the other
	//        params.put(TextToSpeech.Engine.KEY_FEATURE_NETWORK_SYNTHESIS, "true");
	//        params.put(TextToSpeech.Engine.KEY_FEATURE_EMBEDDED_SYNTHESIS, "true");
	        mTts.speak(text, TextToSpeech.QUEUE_FLUSH, params);
    	}
    }

    public void destroy() {
        if (mTts != null) {
            mTts.stop();
            mTts.shutdown();
        }
    }

    private class InitListener implements TextToSpeech.OnInitListener {
        @Override
        public void onInit(int status) {
            if (status == TextToSpeech.SUCCESS) {
                Log.d(TAG, "Initialized TTS");
            } else {
                Log.e(TAG, "Failed to initialize TTS");
            }
        }

    }
}
