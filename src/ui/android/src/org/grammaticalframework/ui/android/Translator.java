package org.grammaticalframework.ui.android;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
import android.util.Pair;
import android.view.inputmethod.CompletionInfo;
import android.database.sqlite.SQLiteDatabase;
import android.database.Cursor;

import org.grammaticalframework.pgf.*;
import java.io.*;
import java.util.*;

public class Translator {

    private static final String TAG = "Translator";

    // new

    // TODO: allow changing
    private String mGrammar = "App.pgf" ;

    // TODO: build dynamically?
    private Language[] mLanguages = {
    	new Language("bg-BG", "Bulgarian", "AppBul", R.xml.cyrillic),
        new Language("ca-ES", "Catalan", "AppCat", R.xml.qwerty),
    	new Language("cmn-Hans-CN", "Chinese", "AppChi", R.xml.qwerty),
	//    	new Language("yue", "Chinese (Cantonese)", "AppChi", R.xml.qwerty),
	//    	new Language("cmn-Hans-CN", "Chinese (Mandarin)", "AppChi", R.xml.qwerty),
        new Language("nl-NL", "Dutch", "AppDut", R.xml.qwerty),
    	new Language("en-US", "English", "AppEng", R.xml.qwerty),
        new Language("fi-FI", "Finnish", "AppFin", R.xml.nordic),
        new Language("fr-FR", "French",  "AppFre", R.xml.qwerty), ////
        new Language("de-DE", "German",  "AppGer", R.xml.qwerty),
        new Language("hi-IN", "Hindi",   "AppHin", R.xml.devanagari_page1, R.xml.devanagari_page2),
        new Language("it-IT", "Italian", "AppIta", R.xml.qwerty),
        new Language("ja-JP", "Japanese","AppJpn", R.xml.qwerty),
        new Language("es-ES", "Spanish", "AppSpa", R.xml.qwerty),
        new Language("sv-SE", "Swedish", "AppSwe", R.xml.nordic),
        new Language("th-TH", "Thai",    "AppTha", R.xml.thai_page1, R.xml.thai_page2)
    };

    private Context mContext;

	private GrammarLoader mGrammarLoader;
    private ConcrLoader mSourceLoader;
    private ConcrLoader mTargetLoader;
    private ConcrLoader mOtherLoader;
    private DBManager mDBManager;

	private static final String SOURCE_LANG_KEY = "source_lang";
	private static final String TARGET_LANG_KEY = "target_lang";
	
	private static final int NUM_ALT_TRANSLATIONS = 10;
	
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
    	mContext = context;

		mSharedPref = context.getSharedPreferences(
				context.getString(R.string.global_preferences_key), Context.MODE_PRIVATE);

		mGrammarLoader = new GrammarLoader();
		mGrammarLoader.start();
		
		Language prefSourceLang = getPrefLang(SOURCE_LANG_KEY, 0);
		Language prefTargetLang = getPrefLang(TARGET_LANG_KEY, 1);
		
        mSourceLoader = new ConcrLoader(prefSourceLang);
        mSourceLoader.start();
        
        if (prefSourceLang == prefTargetLang) {
        	mTargetLoader = mSourceLoader;
        } else {
        	mTargetLoader = new ConcrLoader(prefTargetLang);
        	mTargetLoader.start();
        }

        mOtherLoader = null;

        mDBManager = new DBManager(context);
    }

    public List<Language> getAvailableLanguages() {
        return Arrays.asList(mLanguages);
    }

    public Language getSourceLanguage() {
        return mSourceLoader.getLanguage();
    }

    public void setSourceLanguage(Language language) {
    	setPrefLang(SOURCE_LANG_KEY, language);

    	if (mSourceLoader.getLanguage() == language)
    		return;
    	if (mTargetLoader.getLanguage() == language) {
    		cacheOrUnloadLanguage(mSourceLoader);
    		mSourceLoader = mTargetLoader;
    		return;
    	}
    	if (mOtherLoader != null &&
    	    mOtherLoader.getLanguage() == language) {
    		ConcrLoader tmp = mSourceLoader;
    		mSourceLoader = mOtherLoader;
    		mOtherLoader  = tmp;
    		return;
    	}

    	try {
    		mSourceLoader.join();
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}

    	if (mSourceLoader.getLanguage() != mTargetLoader.getLanguage()) {
    		cacheOrUnloadLanguage(mSourceLoader);
    	}

        mSourceLoader = new ConcrLoader(language);
        mSourceLoader.start();
    }

    public boolean isSourceLanguageLoaded() {
    	try {
    		mSourceLoader.join();
    		return true;
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}
    	return false;
    }

    private Concr getSourceConcr() {
    	try {
    		mSourceLoader.join();
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}
        return mSourceLoader.getConcr();
    }

    public Language getTargetLanguage() {
        return mTargetLoader.getLanguage();
    }

    public void setTargetLanguage(Language language) {
    	setPrefLang(TARGET_LANG_KEY, language);

    	if (mTargetLoader.getLanguage() == language)
    		return;
    	if (mSourceLoader.getLanguage() == language) {
    		cacheOrUnloadLanguage(mTargetLoader);
    		mTargetLoader = mSourceLoader;
    		return;
    	}
    	if (mOtherLoader != null &&
    	    mOtherLoader.getLanguage() == language) {
    		ConcrLoader tmp = mTargetLoader;
    		mTargetLoader = mOtherLoader;
    		mOtherLoader  = tmp;
    		return;
    	}

    	try {
    		mTargetLoader.join();
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}

    	if (mSourceLoader.getLanguage() != mTargetLoader.getLanguage()) {
    		cacheOrUnloadLanguage(mTargetLoader);
    	}

    	mTargetLoader = new ConcrLoader(language);
    	mTargetLoader.start();
    }

    public boolean isTargetLanguageLoaded() {
    	try {
    		mTargetLoader.join();
    		return true;
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}
    	return false;
    }

    private Concr getTargetConcr() {
    	try {
    		mTargetLoader.join();
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}
        return mTargetLoader.getConcr();
    }

	private void cacheOrUnloadLanguage(ConcrLoader loader) {
		if (mOtherLoader != null) {
			mOtherLoader.getConcr().unload();
			Log.d(TAG, mOtherLoader.getLanguage().getConcrete() + ".pgf_c unloaded");
		}
		mOtherLoader = loader;
	}

    public void switchLanguages() {
    	ConcrLoader tmp = mSourceLoader;
    	mSourceLoader = mTargetLoader;
    	mTargetLoader = tmp;
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

    private static String implode(String s) {
	return s.replaceAll("\\s","");
    } 
	
    private String translateWord(String input) {

    	String output = input.toUpperCase() ;  // if all else fails, return the word itself in upper case ///in brackets
    	Concr sourceLang = getSourceConcr() ;
    	Concr targetLang = getTargetConcr() ;

    	String lowerinput = input.toLowerCase() ;  // also consider lower-cased versions of the word

        try {
        	Iterator<ExprProb> iter = sourceLang.parse("Chunk", input).iterator(); // try parse as chunk
        	Expr expr = iter.next().getExpr();
            output = targetLang.linearize(expr);
            return output ;
        } catch (ParseError e) {                               	  // if this fails
        	List<MorphoAnalysis> morphos = lookupMorpho(input) ;  // lookup morphological analyses

        	morphos.addAll(lookupMorpho(lowerinput)) ;  // including the analyses of the lower-cased word

        	for (MorphoAnalysis ana : morphos) {
        		if (targetLang.hasLinearization(ana.getLemma())) {    // check that the word has linearization in target
        			output = targetLang.linearize(Expr.readExpr(ana.getLemma())) ;
        			break ;                                           // if yes, don't search any more
        		} 
        	} 
        	return output ;
        }
    }

    private String translateByLookup(String input) {
    	String[] words = input.split(" ") ;

        String output = "%" ;
        for (String w : words) {
        	output = output + " " + translateWord(w) ; 
        }

        return output ;
    }

    /**
     * Takes a lot of time. Must not be called on the main thread.
     */
    public Pair<String, List<ExprProb>> translate(String input) {
        if (getSourceLanguage().getLangCode().equals("cmn-Hans-CN")) {
        	// for Chinese we need to put space after every character
        	input = explode(input);
        }

        String output = null;
        List<ExprProb> exprs = new ArrayList<ExprProb>();

        try {
            Concr sourceLang = getSourceConcr();
            Concr targetLang = getTargetConcr();

            Map<String,LiteralCallback> callbacks = new HashMap<String,LiteralCallback>();
            callbacks.put("PN", new NercLiteralCallback(mGrammarLoader.getGrammar(), sourceLang));
            callbacks.put("Symb", new UnknownLiteralCallback(sourceLang));

            int count = NUM_ALT_TRANSLATIONS;
            for (ExprProb ep : sourceLang.parseWithHeuristics(getGrammar().getStartCat(), input, -1, callbacks)) {
            	if (count-- <= 0)
            		break;
            	exprs.add(ep);
            	if (output == null)
					output = targetLang.linearize(ep.getExpr());
            }
        } catch (ParseError e) {
        	output = translateByLookup(input);
        }
        
        if (output == null)
        	output = "% ";     // make sure that we return something

	if (getTargetLanguage().getLangCode().equals("cmn-Hans-CN") ||
	    getTargetLanguage().getLangCode().equals("ja-JP") ||
	    getTargetLanguage().getLangCode().equals("th-TH"))
	    output = implode(output) ;
		
        return new Pair<String,List<ExprProb>>(output, exprs);
    }

    public String linearize(Expr expr) {
    	Concr targetLang = getTargetConcr();
    	String s = targetLang.linearize(expr);
    	if (s == null)
    		s = "% ";     // make sure that we return something
	
	if (getTargetLanguage().getLangCode().equals("cmn-Hans-CN") ||
	    getTargetLanguage().getLangCode().equals("ja-JP") ||
	    getTargetLanguage().getLangCode().equals("th-TH"))
	    return implode(s) ;
	else return s ;
    }

    public Object[] bracketedLinearize(Expr expr) {
    	Concr targetLang = getTargetConcr();
    	return targetLang.bracketedLinearize(expr);
    }

    public String generateLexiconEntry(String lemma) {
        Concr sourceLang = getSourceConcr();
        Concr targetLang = getTargetConcr();
    	String cat = getGrammar().getFunctionType(lemma).getCategory();
		
    	Expr e1 = Expr.readExpr(lemma);
    	Expr e2 = Expr.readExpr("MkTag (Inflection"+cat+" "+lemma+")");

    	if (targetLang.hasLinearization("Inflection"+cat)) {
	        if (targetLang.hasLinearization(lemma))
	        	return sourceLang.linearize(e1) + " - " + targetLang.linearize(e2) + ". " + targetLang.linearize(e1);
	        else
	        	return sourceLang.linearize(e1) + " " + targetLang.linearize(e2)+".";
    	} else {
    		if (targetLang.hasLinearization(lemma))
    			return sourceLang.linearize(e1) + " - " + targetLang.linearize(e1);
    		else
    			return sourceLang.linearize(e1);
    	}
    }

	public String getInflectionTable(String lemma) {
		String def = "";
/*		SQLiteDatabase db = mDBManager.getReadableDatabase();
		Cursor crs = db.rawQuery("select def from defs where fun=?1", new String[] { lemma });
		if (crs.moveToNext()) {
			def = escapeHtml(crs.getString(0));
		}
		crs.close();*/

		Concr targetLang = getTargetConcr();
		String cat = getGrammar().getFunctionType(lemma).getCategory();

		if (targetLang.hasLinearization(lemma) && 
		    targetLang.hasLinearization("Inflection"+cat)) {
			Expr e = Expr.readExpr("MkDocument \""+def+"\" (Inflection"+cat+" "+lemma+") \"\"");
			String html =
				"<html><head><meta charset=\"UTF-8\"/></head><body>" +
				targetLang.linearize(e) +
				"</body>";
			return html;
		} else if (def != "") {
			return "<p style=\"font-size:20px\">"+def+"</p>";
		} else {
			return null;
		}
	}
	
	private static String escapeHtml(CharSequence text) {
		StringBuilder out = new StringBuilder();

		for (int i = 0; i < text.length(); i++) {
			char c = text.charAt(i);

			if (c == '<') {
				out.append("&lt;");
			} else if (c == '>') {
				out.append("&gt;");
			} else if (c == '&') {
				out.append("&amp;");
			} else if (c == '"') {
				out.append("&quot;");
			} else if (c > 0x7E || c < ' ') {
				out.append("&#").append((int) c).append(";");
			} else if (c == ' ') {
				while (i + 1 < text.length() && text.charAt(i + 1) == ' ') {
					out.append("&nbsp;");
					i++;
				}

				out.append(' ');
			} else {
				out.append(c);
			}
		}
		
		return out.toString();
	}

    public List<MorphoAnalysis> lookupMorpho(String sentence) {
    	return getSourceConcr().lookupMorpho(sentence);
    }

    public CompletionInfo[] lookupWordPrefix(String prefix) {
    	PriorityQueue<FullFormEntry> queue = 
    		new PriorityQueue<FullFormEntry>(500, new Comparator<FullFormEntry>() {
				@Override
				public int compare(FullFormEntry lhs, FullFormEntry rhs) {
					return Double.compare(lhs.getProb(), rhs.getProb());
				}
			});
    	for (FullFormEntry entry : getSourceConcr().lookupWordPrefix(prefix)) {
    		queue.add(entry);
    		if (queue.size() >= 1000)
    			break;
    	}

    	CompletionInfo[] completions = new CompletionInfo[Math.min(queue.size(), 5)+1];
    	completions[0] = new CompletionInfo(0, 0, prefix);
    	for (int i = 1; i < completions.length; i++) {
    		completions[i] = new CompletionInfo(i,i,queue.poll().getForm());
    	}

    	if (completions.length > 1) {
	    	Arrays.sort(completions, 1, completions.length-1, new Comparator<CompletionInfo>() {
				@Override
				public int compare(CompletionInfo arg0, CompletionInfo arg1) {
					return ((String) arg0.getText()).compareTo((String) arg1.getText());
				}
	    	});
    	}

    	return completions;
    }

	private PGF getGrammar() {
		try {
			mGrammarLoader.join();
		} catch (InterruptedException e) {
			Log.e(TAG, "Loading interrupted", e);
		}
		return mGrammarLoader.getGrammar();
	}

	private class GrammarLoader extends Thread {
		private PGF mPGF;
		
		public GrammarLoader() {
			mPGF = null;
		}

		public PGF getGrammar() {
			return mPGF;
		}

		public void run() {
			InputStream in = null;
			
		    try {
		    	in = mContext.getAssets().open(mGrammar);
		        Log.d(TAG, "Trying to open " + mGrammar);
		        long t1 = System.currentTimeMillis();
		        mPGF = PGF.readPGF(in);
		        long t2 = System.currentTimeMillis();
		        Log.d(TAG, mGrammar + " loaded ("+(t2-t1)+" ms)");		        
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

	private class ConcrLoader extends Thread {
		private Language mLanguage;
		private Concr mConcr;

		public ConcrLoader(Language lang) {
			this.mLanguage = lang;
			this.mConcr = null;
		}

		public Language getLanguage() {
			return mLanguage;
		}
		
		public Concr getConcr() {
			return mConcr;
		}

		public void run() {
			try {
				mGrammarLoader.join();
			} catch (InterruptedException e) {
				Log.d(TAG, "interrupted", e);
			}

			InputStream in = null;

		    try {
		    	String name = mLanguage.getConcrete()+".pgf_c";
		    	in = mContext.getAssets().open(name);
		        Log.d(TAG, "Trying to load " + name);
		        long t1 = System.currentTimeMillis();
		        mConcr = mGrammarLoader.getGrammar().getLanguages().get(mLanguage.getConcrete());
		        mConcr.load(in);
		        long t2 = System.currentTimeMillis();
		        Log.d(TAG, name + " loaded ("+(t2-t1)+" ms)");
		    } catch (FileNotFoundException e) {
		        Log.e(TAG, "File not found", e);
		    } catch (IOException e) {
		        Log.e(TAG, "Error loading concrete", e);
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
