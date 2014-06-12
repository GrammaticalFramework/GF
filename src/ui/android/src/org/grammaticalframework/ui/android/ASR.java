
package org.grammaticalframework.ui.android;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.text.TextUtils;
import android.util.Log;

import java.util.ArrayList;

/**
 * Convenience wrapper around the {@link SpeechRecognizer} API.
 */
public class ASR {

    private static final boolean DBG = false;
    private static final String TAG = "ASR";

    private final Context mContext;

    private SpeechRecognizer mSpeechRecognizer;

    private String mLanguage = null;

    private State mState = State.IDLE;

    private Listener mListener;

    public static enum State {
        IDLE, INITIALIZING, WAITING_FOR_SPEECH, RECORDING, WAITING_FOR_RESULTS;
    }

    public ASR(Context context) {
        mContext = context;
        if (SpeechRecognizer.isRecognitionAvailable(context)) {
            mSpeechRecognizer = SpeechRecognizer.createSpeechRecognizer(context);
            mSpeechRecognizer.setRecognitionListener(new MyRecognitionListener());
        }
    }

    public void setListener(Listener listener) {
        mListener = listener;
    }

    public void setLanguage(String language) {
        mLanguage = language;
    }

    public void startRecognition() {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        if (!TextUtils.isEmpty(mLanguage)) {
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, mLanguage);
        }
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        intent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 2);
        intent.putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, true);
        // Weird, this shouldn't be required, but on ICS it seems to be
        intent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE,
                mContext.getPackageName());

        mSpeechRecognizer.startListening(intent);
        setState(State.INITIALIZING);
    }

    public void stopRecognition() {
        mSpeechRecognizer.stopListening();
        setState(State.IDLE);
    }

    public boolean isRunning() {
        return mState != State.IDLE;
    }

    private void setState(State newState) {
        if (DBG) Log.d(TAG, "Entering state: " + newState);
        mState = newState;
        if (mListener != null) {
            mListener.onStateChanged(mState);
        }
    }

    public State getState() {
        return mState;
    }

    public void destroy() {
        if (mSpeechRecognizer != null) {
            mSpeechRecognizer.destroy();
            mSpeechRecognizer = null;
        }
    }

    private void handlePartialInput(String text) {
        if (mListener != null) {
            mListener.onPartialInput(text);
        }
    }

    private void handleSpeechInput(String text) {
        if (mListener != null) {
            mListener.onSpeechInput(text);
        }
    }

    private class MyRecognitionListener implements RecognitionListener {
        @Override
        public void onReadyForSpeech(Bundle params) {
            if (DBG) Log.d(TAG, "onReadyForSpeech");
            setState(State.WAITING_FOR_SPEECH);
        }

        @Override
        public void onBeginningOfSpeech() {
            if (DBG) Log.d(TAG, "onBeginningOfSpeech");
            setState(State.RECORDING);
        }

        @Override
        public void onBufferReceived(byte[] buffer) {
            // Ignore
        }

        @Override
        public void onRmsChanged(float rmsdB) {
            if (DBG) Log.d(TAG, "onRmsChanged(" + rmsdB + ")");
        }

        @Override
        public void onEndOfSpeech() {
            if (DBG) Log.d(TAG, "onEndOfSpeech");
            setState(State.WAITING_FOR_RESULTS);
        }

        @Override
        public void onError(int error) {
            if (DBG) Log.d(TAG, "Error: " + errorMessage(error) + " (" + error + ")");
            setState(State.IDLE);
        }

        private String errorMessage(int speechRecognizerError) {
            switch(speechRecognizerError) {
                case SpeechRecognizer.ERROR_NETWORK_TIMEOUT:
                    return "network timeout";
                case SpeechRecognizer.ERROR_NETWORK:
                    return "network";
                case SpeechRecognizer.ERROR_AUDIO:
                    return "audio";
                case SpeechRecognizer.ERROR_SERVER:
                    return "server";
                case SpeechRecognizer.ERROR_CLIENT:
                    return "client";
                case SpeechRecognizer.ERROR_SPEECH_TIMEOUT:
                    return "timeout waiting for speech";
                case SpeechRecognizer.ERROR_NO_MATCH:
                    return "no match found";
                case SpeechRecognizer.ERROR_RECOGNIZER_BUSY:
                    return "recognizer busy";
                case SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS:
                    return "insufficient permissions (missing RECORD_AUDIO?)";
                default:
                    return "unknown";
            }
        }

        @Override
        public void onEvent(int eventType, Bundle params) {
            if (DBG) Log.d(TAG, "onEvent(" + eventType + ")");
        }

        @Override
        public void onPartialResults(Bundle bundle) {
            if (DBG) {
                StringBuilder sb = new StringBuilder();
                sb.append("onPartialResults:");
                appendResults(sb, bundle);
                Log.d(TAG, sb.toString());
            }

            String result = getResult(bundle);
            if (!TextUtils.isEmpty(result)) {
                handlePartialInput(result);
            }
        }

        @Override
        public void onResults(Bundle bundle) {
            if (DBG) {
                StringBuilder sb = new StringBuilder();
                sb.append("onResults:");
                appendResults(sb, bundle);
                Log.d(TAG, sb.toString());
            }

            setState(State.IDLE);

            String result = getResult(bundle);
            if (!TextUtils.isEmpty(result)) {
                handleSpeechInput(result);
            }
        }

        private String getResult(Bundle bundle) {
            ArrayList<String> results = 
                    bundle.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
            if (results != null && !results.isEmpty()) {
                return results.get(0);
            } else {
                return null;
            }
        }

        private void appendResults(StringBuilder sb, Bundle bundle) {
            ArrayList<String> results = 
                    bundle.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
            float[] scores = bundle.getFloatArray(SpeechRecognizer.CONFIDENCE_SCORES);

            if (results != null) {
                int size = results.size();
                for (int i = 0; i < size; i++) {
                    sb.append("\n> ").append(results.get(i));
                    if (scores != null && i < scores.length) {
                        sb.append(" [").append(scores[i]).append("]");
                    }
                }
            }
        }
    }

    public interface Listener {
        void onPartialInput(String input);
        void onSpeechInput(String input);
        void onStateChanged(State newState);
    }

}
