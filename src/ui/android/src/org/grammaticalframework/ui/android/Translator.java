package org.grammaticalframework.ui.android;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import org.grammaticalframework.pgf.Concr;
import org.grammaticalframework.pgf.Expr;
import org.grammaticalframework.pgf.MorphoAnalysis;
import org.grammaticalframework.pgf.PGF;
import org.grammaticalframework.pgf.ParseError;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class Translator {

    private static final String TAG = "Translator";

    // TODO: allow changing
    private String mGrammar = "ParseEngAbs.pgf";
    /// private String mGrammar = "TranslateEngChiFinSwe.pgf";  // AR

    // TODO: build dynamically?
    private Language[] mLanguages = {
	/*
        new Language("en-US", "English", "TranslateEng", R.xml.inflection_en),  // AR
        new Language("cmn-Hans-CN", "Chinese", "TranslateChi", 0), 
	        new Language("fi-FI", "Finnish", "TranslateFin", 0), 
	        new Language("sv-SE", "Swedish", "TranslateSwe", 0), 
	*/
    	new Language("en-US", "English", "ParseEng", R.xml.inflection_en),
        new Language("bg-BG", "Bulgarian", "ParseBul", R.xml.inflection_bg),
    };

    private Language mSourceLanguage;

    private Language mTargetLanguage;

	private PGF mPGF;
	private Thread mGrammarLoader;

	private static final String SOURCE_LANG_KEY = "source_lang";
	private static final String TARGET_LANG_KEY = "target_lang";
	
	private SharedPreferences mSharedPref;
	
	private Language getPrefLang(String key, int def) {
		int index = mSharedPref.getInt(key, def);
		if (index < 0 || index >= mLanguages.length)
			index = def;
		return mLanguages[index];
	}

	private void setPrefLang(String key, Language def) {
		for (int index = 0; index < mLanguages.length; index++) {
			if (def == mLanguages[index]) {
				SharedPreferences.Editor editor = mSharedPref.edit();
				editor.putInt(key, index);
				editor.commit();
				break;
			}
		}
	}

    public Translator(Context context) {
		mGrammarLoader = new GrammarLoader(context);
		mGrammarLoader.start();
		
		mSharedPref = context.getSharedPreferences(
				context.getString(R.string.global_preferences_key), Context.MODE_PRIVATE);
		
		mSourceLanguage = getPrefLang(SOURCE_LANG_KEY, 0);
		mTargetLanguage = getPrefLang(TARGET_LANG_KEY, 1);
    }

    public List<Language> getAvailableSourceLanguages() {
        return Arrays.asList(mLanguages);
    }

    public List<Language> getAvailableTargetLanguages() {
        return Arrays.asList(mLanguages);
    }

    public void setSourceLanguage(Language language) {
        mSourceLanguage = language;
        setPrefLang(SOURCE_LANG_KEY, language);
    }

    public void setTargetLanguage(Language language) {
        mTargetLanguage = language;
        setPrefLang(TARGET_LANG_KEY, language);
    }

    public Language getSourceLanguage() {
        return mSourceLanguage;
    }

    public Language getTargetLanguage() {
        return mTargetLanguage;
    }

    private static String explode(String in) {
    	String out = "";
    	for (int i = 0; i < in.length(); i++) {
    		if (i > 0)
    			out += ' ';
    		out += in.charAt(i);
    	}
    	return out;
    }
    /**
     * Takes a lot of time. Must not be called on the main thread.
     */
    public String translate(String input) {
        if (getSourceLanguage().getLangCode().equals("cmn-Hans-CN")) {
        	// for Chinese we need to put space after every character
        	input = explode(input);
        }

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

    public String linearize(Expr e) {
        Concr targetLang = getConcr(getTargetLanguage().getConcrete());
        return targetLang.linearize(e);
    }

    public Map<String,String> tabularLinearize(Expr e) {
        Concr targetLang = getConcr(getTargetLanguage().getConcrete());
        return targetLang.tabularLinearize(e);
    }

    public List<MorphoAnalysis> lookupMorpho(String sentence) {
    	return getConcr(getSourceLanguage().getConcrete()).lookupMorpho(sentence);
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
