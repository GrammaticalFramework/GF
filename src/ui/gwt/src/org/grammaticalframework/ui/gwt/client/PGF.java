package org.grammaticalframework.ui.gwt.client;

import org.grammaticalframework.ui.gwt.client.JSONRequestBuilder.Arg;

import java.util.*;
import com.google.gwt.core.client.*;
import com.google.gwt.http.client.*;

public class PGF {

	public PGF () {
	}

	/* Grammar */

	public JSONRequest grammar (String pgfURL, final GrammarCallback callback) {
		return sendGrammarRequest(pgfURL, "grammar", new ArrayList<Arg>(), callback);
	}

	public interface GrammarCallback extends JSONCallback<Grammar> { }

	public static class Grammar extends JavaScriptObject {
		protected Grammar() { }

		public final native String getName() /*-{ return this.name; }-*/;

		public final native String getUserLanguage() /*-{ return this.userLanguage; }-*/;

		public final native IterableJsArray<Language> getLanguages() /*-{ return this.languages; }-*/;

		public final native JsArrayString getCategories() /*-{ return this.categories; }-*/;

		public final native JsArrayString getFunctions() /*-{ return this.functions; }-*/;
	}

	public static class Language extends JavaScriptObject {
		protected Language() { }

		public final native String getName() /*-{ return this.name; }-*/;
		public final native String getLanguageCode() /*-{ return this.languageCode; }-*/;
	}

	/* Translation */

	public JSONRequest translate (String pgfURL, String input, String fromLang, String cat, String toLang,
			final TranslateCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		args.add(new Arg("from", fromLang));
		args.add(new Arg("cat", cat));
		args.add(new Arg("to", toLang));
		return sendGrammarRequest(pgfURL, "translate", args, callback);
	}

	public interface TranslateCallback extends JSONCallback<Translations> {  }

	public static class Translations extends IterableJsArray<TranslationResult> {
		protected Translations() { }
	}

	public static class TranslationResult extends JavaScriptObject {
		protected TranslationResult() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native BracketedString getBracketedString() /*-{ return this.brackets; }-*/;
                public final native IterableJsArray<Translation> getTranslations() /*-{ return this.translations; }-*/;
		public final native TcError[] getTypeErrors() /*-{ return this.typeErrors; }-*/;
	}

	public static class Translation extends JavaScriptObject {
		protected Translation() { }

                public final native String getTree() /*-{ return this.tree; }-*/;
		public final native Linearizations getLinearizations() /*-{ return this.linearizations; }-*/;
	}

	/* Completion */

	/**
	 * Get suggestions for completing the input.
	 * @param limit The number of suggestions to get. 
	 * If -1 is passed, all available suggestions are retrieved.
	 */
	public JSONRequest complete (String pgfURL, String input, String fromLang, String cat, int limit, final CompleteCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		args.add(new Arg("from", fromLang));
		args.add(new Arg("cat", cat));
		if (limit > 0) {
			args.add(new Arg("limit", limit));
		}
		return sendGrammarRequest(pgfURL, "complete", args, callback);
	}

	public interface CompleteCallback extends JSONCallback<Completions> { }

	public static class Completions extends IterableJsArray<Completion> {
		protected Completions() { }
	}

	public static class Completion extends JavaScriptObject {
		protected Completion() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native BracketedString getBracketedString() /*-{ return this.brackets; }-*/;
		public final native String[] getCompletions() /*-{ return this.completions; }-*/;
		public final native String getText() /*-{ return this.text; }-*/;
	}

	/* Parsing */

	public JSONRequest parse (String pgfURL, String input, String fromLang, String cat, final ParseCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("input", input));
		args.add(new Arg("from", fromLang));
		args.add(new Arg("cat", cat));
		return sendGrammarRequest(pgfURL, "parse", args, callback);
	}

	public interface ParseCallback extends JSONCallback<ParseResults> { }

	public static class ParseResults extends IterableJsArray<ParseResult> {
		protected ParseResults() { }
	}

	public static class ParseResult extends JavaScriptObject {
		protected ParseResult() { }

		public final native String getFrom() /*-{ return this.from; }-*/;
		public final native BracketedString getBracketedString() /*-{ return this.brackets; }-*/;
		public final native String[] getTrees() /*-{ return this.trees; }-*/;
		public final native TcError[] getTypeErrors() /*-{ return this.typeErrors; }-*/;
	}

	public static class BracketedString extends JavaScriptObject {
		protected BracketedString() { }

		public final native String getToken() /*-{ return this.token; }-*/;

		public final native String getCat() /*-{ return this.cat; }-*/;
		public final native int getFId() /*-{ return this.fid; }-*/;
		public final native int getIndex() /*-{ return this.index; }-*/;
		public final native BracketedString[] getChildren() /*-{ return this.children; }-*/;
	}

	public static class TcError extends JavaScriptObject {
		protected TcError() { }

		public final native int getFId() /*-{ return this.fid; }-*/;
		public final native String getMsg() /*-{ return this.msg; }-*/;
	}
	
	
	/* Linearization */

	public JSONRequest linearize (String pgfURL, String tree, String toLang, final LinearizeCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("tree", tree));
		args.add(new Arg("to", toLang));
		return sendGrammarRequest(pgfURL, "linearize", args, callback);
	}

	public interface LinearizeCallback extends JSONCallback<Linearizations> { }
	
	public static class Linearizations extends IterableJsArray<Linearization> {
		protected Linearizations() { }
	}
	
	public static class Linearization extends JavaScriptObject {
		protected Linearization() { }

		public final native String getTo() /*-{ return this.to; }-*/;
                public final native String getText() /*-{ return this.text; }-*/;
	}

	public String graphvizAbstractTree(String pgfURL, String abstractTree) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "abstrtree"));
                args.add(new Arg("tree", abstractTree));
		return JSONRequestBuilder.getQueryURL(pgfURL,args);
	}

	public String graphvizParseTree(String pgfURL, String abstractTree, String lang) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "parsetree"));
                args.add(new Arg("tree", abstractTree));
		args.add(new Arg("from", lang));
		return JSONRequestBuilder.getQueryURL(pgfURL,args);
	}

	public String graphvizAlignment(String pgfURL, String abstractTree) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "alignment"));
                args.add(new Arg("tree", abstractTree));
		return JSONRequestBuilder.getQueryURL(pgfURL,args);
	}

	public Request browse(String pgfURL, String id, String href, String cssClass, RequestCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("command", "browse"));
		args.add(new Arg("id", id));
		args.add(new Arg("href", href));
		args.add(new Arg("css-class", cssClass));

		Request request = null;
		try {
			RequestBuilder builder = new RequestBuilder(RequestBuilder.GET,
                                                                    JSONRequestBuilder.getQueryURL(pgfURL,args));
			builder.setCallback(callback);
			request = builder.send();
		} catch (RequestException ex) {
			callback.onError(request, ex);
		}

		return request;
	}
	
	public JSONRequest query(String pgfURL, String query, QueryCallback callback) {
		List<Arg> args = new ArrayList<Arg>();
		args.add(new Arg("cat", query));
		return sendGrammarRequest(pgfURL, "query", args, callback);
	}
	
	public interface QueryCallback extends JSONCallback<QueryResult> {}

	public static class QueryResult extends JavaScriptObject {
		protected QueryResult() { }

		public final native String[] getRows() /*-{ return this.rows; }-*/;
	}

	public <T extends JavaScriptObject> JSONRequest sendGrammarRequest(String pgfURL, String resource, List<Arg> args, final JSONCallback<T> callback) {
		args.add(new Arg("command", resource));
		return JSONRequestBuilder.sendRequest(pgfURL, args, callback);
	}

}
