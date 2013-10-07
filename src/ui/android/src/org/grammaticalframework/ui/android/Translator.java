package org.grammaticalframework.ui.android;

import android.content.Context;
import android.util.Log;

import org.grammaticalframework.pgf.Concr;
import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.pgf.PGF;
import org.grammaticalframework.pgf.ParseError;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;

public class Translator {

    private static final String TAG = "Translator";

    // TODO: allow changing
    private String mGrammar = "ResourceDemo.pgf";

    // TODO: build dynamically?
    private Language[] mLanguages = {
            new Language("en-US", "English", "ResourceDemoEng"),
            new Language("de-DE", "German", "ResourceDemoGer"),
            new Language("es-ES", "Spanish", "ResourceDemoSpa"),
            new Language("fr-FR", "French", "ResourceDemoFre"),
    };

    private Language mSourceLanguage;

    private Language mTargetLanguage;

	private PGF mPGF;
	private Thread mGrammarLoader;


    public Translator(Context context) {
		mGrammarLoader = new GrammarLoader(context);
		mGrammarLoader.start();
    }

    public List<Language> getAvailableSourceLanguages() {
        return Arrays.asList(mLanguages);
    }

    public List<Language> getAvailableTargetLanguages() {
        return Arrays.asList(mLanguages);
    }

    public void setSourceLanguage(Language language) {
        mSourceLanguage = language;
    }

    public void setTargetLanguage(Language language) {
        mTargetLanguage = language;
    }

    public Language getSourceLanguage() {
        return mSourceLanguage != null ? mSourceLanguage : mLanguages[0];
    }

    public Language getTargetLanguage() {
        return mTargetLanguage != null ? mTargetLanguage : mLanguages[1];
    }

    /**
     * Takes a lot of time. Must not be called on the main thread.
     */
    public String translate(String input) {
        try {
            Concr sourceLang = getConcr(getSourceLanguage().getConcrete());
            Expr expr = sourceLang.parseBest(getGrammar().getStartCat(), input);
            Concr targetLang = getConcr(getTargetLanguage().getConcrete());
            String output = targetLang.linearize(expr);
            return output;
        } catch (ParseError e) {
            Log.e(TAG, "Parse error: " + e);
            return "parse error: " + e.getMessage(); // TODO: no no no
        }
    }

    private Concr getConcr(String name) {
        return getGrammar().getLanguages().get(name);
    }

	private PGF getGrammar() {
		try {
			mGrammarLoader.join();
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}
		return mPGF;
	}

	private class GrammarLoader extends Thread {
	    private final Context mContext;
	    
	    public GrammarLoader(Context context) {
	    	mContext = context;
	    }

		public void run() {
			InputStream in = null;
			
		    try {
		    	in = mContext.getAssets().open(mGrammar);
		        Log.d(TAG, "Trying to open " + mGrammar);
		        long t1 = System.currentTimeMillis();
		        mPGF = PGF.readPGF(in);
		        long t2 = System.currentTimeMillis();
		        Log.d(TAG, "Grammar loaded ("+(t2-t1)+" ms)");
		    } catch (FileNotFoundException e) {
		        Log.e(TAG, "File not found", e);
		    } catch (IOException e) {
		        Log.e(TAG, "Error loading grammar", e);
		    } finally {
		    	if (in != null) {
		    		try {
		    			in.close();
		    		} catch (IOException e) {
		    			Log.e(TAG, "Error closing the stream", e);
		    		}
		    	}
		    }
		}
	}
}
