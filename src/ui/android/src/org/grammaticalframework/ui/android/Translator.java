package org.grammaticalframework.ui.android;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager.NameNotFoundException;
import android.util.Log;
import android.util.Pair;
import android.net.Uri;
import android.view.inputmethod.CompletionInfo;
import android.database.sqlite.SQLiteDatabase;
import android.database.Cursor;

import org.grammaticalframework.sg.*;
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
	//    	new Language("zh-CN", "Chinese", "AppChi", R.xml.qwerty),
	//    	new Language("yue", "Chinese (Cantonese)", "AppChi", R.xml.qwerty),
	//    	new Language("cmn-Hans-CN", "Chinese (Mandarin)", "AppChi", R.xml.qwerty),
        new Language("nl-NL", "Dutch", "AppDut", R.xml.qwerty),
    	new Language("en-US", "English", "AppEng", R.xml.qwerty),
        new Language("et-EE", "Estonian","AppEst", R.xml.nordic),
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
    private SemanticGraphManager mSGManager;

	private static final String SOURCE_LANG_KEY = "source_lang";
	private static final String TARGET_LANG_KEY = "target_lang";
	
	public static final String WORDS     = "words";
	public static final String SENTENCES = "sentences";
	
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

        mSGManager = new SemanticGraphManager(context);
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
		return s.replaceAll("(?<!^[%*+])\\s","");
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
            callbacks.put("PN", new NercLiteralCallback(mGrammarLoader.getGrammar(), sourceLang, input));
            callbacks.put("Symb", new UnknownLiteralCallback(sourceLang, input));

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
		  return implode(s);
		else
		  return s;
    }

    public String linearizeSource(Expr expr) {
    	Concr targetLang = getSourceConcr();
    	String s = targetLang.linearize(expr);
    	if (s == null)
    		s = "% ";     // make sure that we return something
	
		if (getTargetLanguage().getLangCode().equals("cmn-Hans-CN") ||
		    getTargetLanguage().getLangCode().equals("ja-JP") ||
		    getTargetLanguage().getLangCode().equals("th-TH"))
		  return implode(s);
		else
		  return s;
    }

    public Object[] bracketedLinearize(Expr expr) {
    	Concr targetLang = getTargetConcr();
    	return targetLang.bracketedLinearize(expr);
    }

    public String generateLexiconEntry(Expr lemma) {
        Concr sourceLang = getSourceConcr();
        Concr targetLang = getTargetConcr();
        String fun = lemma.toString();
    	String cat = getGrammar().getFunctionType(fun).getCategory();
		
    	Expr e2 = Expr.readExpr("MkTag (Inflection"+cat+" "+fun+")");

    	if (targetLang.hasLinearization("Inflection"+cat)) {
	        if (targetLang.hasLinearization(fun))
	        	return sourceLang.linearize(lemma) + " - " + targetLang.linearize(e2) + ". " + targetLang.linearize(lemma);
	        else
	        	return sourceLang.linearize(lemma) + " " + targetLang.linearize(e2)+".";
    	} else {
    		if (targetLang.hasLinearization(fun))
    			return sourceLang.linearize(lemma) + " - " + targetLang.linearize(lemma);
    		else
    			return sourceLang.linearize(lemma);
    	}
    }

	private static final Expr gloss_pred   = Expr.readExpr("gloss");
	private static final Expr topic_pred   = Expr.readExpr("topic");
	private static final Expr example_pred = Expr.readExpr("example");
	
    public Expr getDefinition(Expr lemma, boolean withExample) {
		Expr gloss   = null;
		Expr example = null;
		Map<String,Uri.Builder> topics = new TreeMap<String,Uri.Builder>();

		try {
			TripleResult res = mSGManager.queryTriple(lemma, null, null);
			while (res.hasNext()) {
				if (res.getPredicate().equals(gloss_pred))
					gloss = res.getObject();
				else if (res.getPredicate().equals(topic_pred))
					updateWordsMap(res.getObject(), topics);
				else if (res.getPredicate().equals(example_pred))
					example = res.getObject();
			}
			res.close();
		} catch (IOException e) {
			// nothing
		} catch (SGError e) {
			// nothing
		}

		Expr topic = null;
		if (topics.size() > 0) {
			StringBuilder builder = new StringBuilder();
			builder.append('(');
			buildWordsHtml(topics, builder);
			builder.append(')');
			topic = new Expr(builder.toString());
		}
		if (gloss == null)
			return topic;
		else {
			if (topic == null)
				topic = new Expr("");
			if (withExample && example != null)
				return new Expr("MkDefinitionEx", topic, gloss, example);
			else
				return new Expr("MkDefinition", topic, gloss);
		}
	}

	private void updateWordsMap(Expr expr, Map<String,Uri.Builder> map) {
		String word = getTargetConcr().linearize(expr);

		Uri.Builder builder = map.get(word);
		if (builder == null) {
			builder = new Uri.Builder();
			builder.scheme("gf-translator");
			builder.authority(WORDS);
			builder.appendQueryParameter("source", word);	
			map.put(word,builder);
		}
		builder.appendQueryParameter("alternative", expr.toString());
	}

    private void buildWordsHtml(Map<String,Uri.Builder> map, StringBuilder sbuilder) {
		boolean first = true;
		for (Map.Entry<String,Uri.Builder> entry : map.entrySet()) {
			if (first)
				first = false;
			else
				sbuilder.append(", ");

			sbuilder.append("<a href=\""+entry.getValue().build()+"\">"+entry.getKey()+"</a>");
		}
	}

    public List<Expr> getTopicWords(Expr lemma) {
		TripleResult res = null;
		List<Expr> words = new ArrayList<Expr>();
		try {
			res = mSGManager.queryTriple(null, topic_pred, lemma);
			while (res.hasNext()) {
				words.add(res.getSubject());
			}
		} catch (IOException e) {
			// nothing
		} catch (SGError e) {
			// nothing
		} finally {
			if (res != null)
				res.close();
		}
		return words;
	}

    private Expr getTopicWordsHtml(Expr lemma) {
		StringBuilder sbuilder = new StringBuilder();
		TripleResult res = null;
		try {
			res = mSGManager.queryTriple(null, topic_pred, lemma);
			Map<String,Uri.Builder> map = new TreeMap<String,Uri.Builder>();
			while (res.hasNext()) {
				updateWordsMap(res.getSubject(), map);
			}

			StringBuilder builder = new StringBuilder();
			buildWordsHtml(map, builder);
			return new Expr(builder.toString());
		} catch (IOException e) {
			// nothing
		} catch (SGError e) {
			// nothing
		} finally {
			if (res != null)
				res.close();
		}
		return null;
	}

	public String getInflectionTable(Expr lemma) {
		boolean withExample =
			(getSourceLanguage().getLangCode().equals("en-US") ||
             getTargetLanguage().getLangCode().equals("en-US"));
		Expr def = 
			getDefinition(lemma, withExample);

		String fun = lemma.toString();
		Concr targetLang = getTargetConcr();
		String cat = getGrammar().getFunctionType(fun).getCategory();

		if (targetLang.hasLinearization(fun) && 
		    targetLang.hasLinearization("Inflection"+cat)) {
			if (def == null)
				def = Expr.readExpr("NoDefinition");

			Expr e = new Expr("MkDocument", 
			                  def,
			                  new Expr("Inflection"+cat,lemma),
			                  getTopicWordsHtml(lemma));
			String html =
				"<html><head><meta charset=\"UTF-8\"/><style>a {color: #808080;}</style></head><body>" +
				targetLang.linearize(e) +
				"</body>";
			return html;
		} else if (def != null) {
			String html =
				"<html><head><meta charset=\"UTF-8\"/><style>a {color: #808080;}</style></head><body>" +
				targetLang.linearize(def) +
				"</body>";
			return html;
		} else {
			return null;
		}
	}

    public List<Expr> getTopicsOf(Expr lemma) {
		TripleResult res = null;
		List<Expr> topics = new ArrayList<Expr>();
		try {
			res = mSGManager.queryTriple(lemma, topic_pred, null);
			while (res.hasNext()) {
				topics.add(res.getObject());
			}
		} catch (IOException e) {
			// nothing
		} catch (SGError e) {
			// nothing
		} finally {
			if (res != null)
				res.close();
		}
		return topics;
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

    public boolean isUpgraded(String key) {
		int old_code = mSharedPref.getInt(key, 0);

		int new_code = 0;
		try {
			new_code = mContext.getPackageManager().getPackageInfo(mContext.getPackageName(), 0).versionCode;
		} catch (NameNotFoundException e) {
			// Huh? Really?
		}

		SharedPreferences.Editor editor = mSharedPref.edit();
		editor.putInt(key, new_code);
		editor.commit();

		return (old_code != new_code);
	}
}
