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

    // TODO: handle speak() calls before service connects
    public void speak(String language, String text) {


   	if (mAudioManager.getRingerMode() == AudioManager.RINGER_MODE_NORMAL) {

	    /* hack for missing TTS -- don't use for official release!
    		if (language.equals("bg-BG")) {
    			language = "ru-RU";  
    		}
    		if (language.equals("ca-ES")) {
		    language = "es-ES"; // hardly politically correct...
    		}
            */

	    /* Google Chinese speech input has a nonstandard code. In output, yue works for Chi in Google, but SVOX uses the standard zh-CN  */ 
	    	if (language.equals("cmn-Hans-CN")) {
	    		language = "zh-CN";
	    	}

	        Locale locale = LocaleUtils.parseJavaLocale(language.replace('-', '_'),
	                                                    Locale.getDefault());

	        int result = mTts.setLanguage(locale);
	        if (result == TextToSpeech.LANG_MISSING_DATA ||
	            result == TextToSpeech.LANG_NOT_SUPPORTED) {
	            Log.e(TAG, "Language is not available");
	        } else {
		        HashMap<String,String> params = new HashMap<String,String>();
		        mTts.speak(text, TextToSpeech.QUEUE_FLUSH, params);
	        }
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
