package se.chalmers.cs.gf.gwt.client;

import se.chalmers.cs.gf.gwt.client.JSONRequestBuilder.Arg;

import com.google.gwt.core.client.JavaScriptObject;

import java.util.List;
import java.util.ArrayList;

public class PGF {

	private String baseURL;

	public PGF (String baseURL) {
		this.baseURL = baseURL;
	}
	
	/* List grammars */
	
	public JSONRequest listGrammars (final GrammarNamesCallback callback) {
		return JSONRequestBuilder.sendRequest(baseURL + "/", null, callback);
	}
	
	public interface GrammarNamesCallback extends JSONCallback<GrammarNames> { }
	
	public static class GrammarNames extends IterableJsArray<GrammarName> {
		protected GrammarNames() { }
	}

	public static class GrammarName extends JavaScriptObject {
		protected GrammarName() { }
		
		public final native String getName() /*-{ return this.name; }-*/;
	}
		
	/* Grammar */

	public JSONRequest grammar (String pgfName, final GrammarCallback callback) {
		return sendGrammarRequest(pgfName, "grammar", null, callback);
	}

	public interface GrammarCallback extends JSONCallback<Grammar> { }

	public static class Grammar extends JavaScriptObject {
		protected Grammar() { }

		public final native String getName() /*-{ return this.name; }-*/;

		public final native String getUserLanguage() /*-{ return this.userLanguage; }-*/;

		public final native IterableJsArray<Language> getLanguages() /*-{ return this.languages; }-*/;

		public final Language getLanguage(String name) {
			int c = getLanguages().length();
			for (int i = 0; i < c; i++) {
				Language l = getLanguages().get(i);
				if (l.getName().equals(name))
					return l;
			}
			return null;
		}
	}

	public static class Language extends JavaScriptObject {
		protected Language() { }

		public final native String getName() /*-{ return this.name; }-*/;
		public final native String getLanguageCode() /*-{ return this.languageCode; }-*/;
		public final native boolean canParse() /*-{ return this.canParse; }-*/;
	}

	/* Translation */

	public JSONRequest translate (String pgfName, String input, String fromLang, String cat, String toLang, 
			final TranslateCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		args.add(new Arg("from", fromLang));
		args.add(new Arg("cat", cat));
		args.add(new Arg("to", toLang));
		return sendGrammarRequest(pgfName, "translate", args, callback);
	}

	public interface TranslateCallback extends JSONCallback<Translations> {  }

	public static class Translations extends IterableJsArray<Translation> {
		protected Translations() { }
	}

	public static class Translation extends JavaScriptObject {
		protected Translation() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native String getTo() /*-{ return this.to; }-*/;
		public final native String getText() /*-{ return this.text; }-*/;
	}

	/* Completion */

	/**
	 * Get suggestions for completing the input.
	 * @param limit The number of suggestions to get. 
	 * If -1 is passed, all available suggestions are retrieved.
	 */
	public JSONRequest complete (String pgfName, String input, String fromLang, String cat, int limit, final CompleteCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		args.add(new Arg("from", fromLang));
		args.add(new Arg("cat", cat));
		if (limit != -1) {
			args.add(new Arg("limit", limit));
		}
		return sendGrammarRequest(pgfName, "complete", args, callback);
	}

	public interface CompleteCallback extends JSONCallback<Completions> { }

	public static class Completions extends IterableJsArray<Completion> {
		protected Completions() { }
	}

	public static class Completion extends JavaScriptObject {
		protected Completion() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native String getText() /*-{ return this.text; }-*/;
	}

	/* Parsing */

	public JSONRequest parse (String pgfName, String input, String fromLang, String cat, final ParseCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		args.add(new Arg("from", fromLang));
		args.add(new Arg("cat", cat));
		return sendGrammarRequest(pgfName, "parse", args, callback);
	}

	public interface ParseCallback extends JSONCallback<ParseResults> { }

	public static class ParseResults extends IterableJsArray<ParseResult> {
		protected ParseResults() { }
	}

	public static class ParseResult extends JavaScriptObject {
		protected ParseResult() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native String getTree() /*-{ return this.tree; }-*/;
	}

	/* Common */

	public <T extends JavaScriptObject> JSONRequest sendGrammarRequest(String pgfName, String resource, List<Arg> args, final JSONCallback<T> callback) {
		return JSONRequestBuilder.sendRequest(baseURL + "/" + pgfName + "/" + resource, args, callback);
	}

}