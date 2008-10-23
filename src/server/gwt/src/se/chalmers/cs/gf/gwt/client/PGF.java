package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.JavaScriptObject;

import java.util.List;
import java.util.ArrayList;

public class PGF {

	private String baseURL;
	private String pgfName;

	public PGF (String baseURL, String pgfName) {
		this.baseURL = baseURL;
		this.pgfName = pgfName;
	}

	/* Grammar */

	public JSONRequest grammar (final GrammarCallback callback) {
		return sendRequest("grammar", null, callback);
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

	public JSONRequest translate (String input, List<String> fromLangs, String cat, List<String> toLangs, 
			final TranslateCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		if (fromLangs != null) {
			for (String from : fromLangs) {
				args.add(new Arg("from", from));
			}
		}
		args.add(new Arg("cat", cat));
		if (toLangs != null) {
			for (String to : toLangs) {
				args.add(new Arg("to", to));
			}
		}
		return sendRequest("translate", args, callback);
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

	public JSONRequest complete (String input, List<String> fromLangs, String cat, int limit, final CompleteCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		if (fromLangs != null) {
			for (String from : fromLangs) {
				args.add(new Arg("from", from));
			}
		}
		args.add(new Arg("cat", cat));
		args.add(new Arg("limit", limit));
		return sendRequest("complete", args, callback);
	}

	public interface CompleteCallback extends JSONCallback<Completions> { }

	public static class Completions extends IterableJsArray<Translation> {
		protected Completions() { }
	}

	public static class Completion extends JavaScriptObject {
		protected Completion() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native String getText() /*-{ return this.text; }-*/;
	}

	/* Parsing */

	public JSONRequest parse (String input, List<String> fromLangs, String cat, final ParseCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		if (fromLangs != null) {
			for (String from : fromLangs) {
				args.add(new Arg("from", from));
			}
		}
		args.add(new Arg("cat", cat));
		return sendRequest("parse", args, callback);
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

	public <T extends JavaScriptObject> JSONRequest sendRequest(String resource, List<Arg> args, final JSONCallback<T> callback) {
		return JSONRequestBuilder.sendRequest(baseURL + "/" + pgfName + "/" + resource, args, callback);
	}

}