package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.http.client.*;
import com.google.gwt.core.client.GWT;
import com.google.gwt.core.client.JsArray;
import com.google.gwt.core.client.JavaScriptObject;

import com.google.gwt.json.client.JSONValue;
import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONParser;

import java.util.Set;
import java.util.List;
import java.util.ArrayList;

public class GF {

    private String baseURL;

    public GF (String baseURL) {
	this.baseURL = baseURL;
    }

    /* Languages */

    public void languages (final LanguagesCallback callback) {
	sendRequest("languages", null, new JSONRequestCallback() {
		public void onJSONReceived(JSONValue json) {
		    callback.onLanguagesDone((Languages)json.isArray().getJavaScriptObject().cast());
		}
	    });
    }

    public static class Languages extends JsArray<Language> {
	protected Languages() { }
    }

    public static class Language extends JavaScriptObject {
	protected Language() { }

        public final native String getName() /*-{ return this.name; }-*/;
        public final native String getLanguageCode() /*-{ return this.languageCode; }-*/;
        public final native boolean canParse() /*-{ return this.canParse; }-*/;
    }


    public interface LanguagesCallback {
	public void onLanguagesDone (Languages languages);
    }

    /* Translation */

    public void translate (String input, List<String> fromLangs, String cat, List<String> toLangs, 
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
	sendRequest("translate", args, new JSONRequestCallback() {
		public void onJSONReceived(JSONValue json) {
		    callback.onTranslateDone((Translations)json.isArray().getJavaScriptObject().cast());
		}
	    });
    }

    public static class Translations extends JsArray<Translation> {
	protected Translations() { }
    }

    public static class Translation extends JavaScriptObject {
	protected Translation() { }

        public final native String getFrom() /*-{ return this.from; }-*/;
        public final native String getTo() /*-{ return this.to; }-*/;
        public final native String getText() /*-{ return this.text; }-*/;
    }

    public interface TranslateCallback {
	public void onTranslateDone (Translations translations);
    }

    /* Completion */

    public void complete (String input, List<String> fromLangs, String cat, int limit, final CompleteCallback callback) {
	List<Arg> args = new ArrayList<Arg>();
	args.add(new Arg("input", input));
	if (fromLangs != null) {
	    for (String from : fromLangs) {
		args.add(new Arg("from", from));
	    }
	}
	args.add(new Arg("cat", cat));
	args.add(new Arg("limit", limit));
	sendRequest("complete", args, new JSONRequestCallback() {
		public void onJSONReceived(JSONValue json) {
		    callback.onCompleteDone((Completions)json.isArray().getJavaScriptObject().cast());
		}
	    });
    }

    public static class Completions extends JsArray<Translation> {
	protected Completions() { }
    }

    public static class Completion extends JavaScriptObject {
	protected Completion() { }

        public final native String getFrom() /*-{ return this.from; }-*/;
        public final native String getText() /*-{ return this.text; }-*/;
    }

    public interface CompleteCallback {
	public void onCompleteDone (Completions completions);
    }


    /* Utilities */

    public interface JSONRequestCallback {
	public void onJSONReceived(JSONValue json);
    }

    private void sendRequest (String resource, List<Arg> vars, final JSONRequestCallback callback) {
	String url = baseURL + "/" + resource + "?" + buildQueryString(vars);
	RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);

	try {
	    Request request = builder.sendRequest(null, new RequestCallback() {
		    public void onError(Request request, Throwable e) {
			GWT.log("onError called", e);
		    }
		    
		    public void onResponseReceived(Request request, Response response) {
			if (200 == response.getStatusCode()) {
			    callback.onJSONReceived(JSONParser.parse(response.getText()));
			} else {
			    GWT.log("Response not OK: " + response.getStatusCode() + ". " + response.getText(), null);
			}
		    }
		});
	} catch (RequestException e) {
	    GWT.log("Failed to send request", e);
	}
    }

    private static class Arg {
	public final String name;
	public final String value;
	public Arg (String name, String value) {
	    this.name = name;
	    this.value = value;
	}
	public Arg (String name, int value) {
	    this(name, Integer.toString(value));
	}
    }

    private static String buildQueryString(List<Arg> args) {
	StringBuffer sb = new StringBuffer();
	if (args != null) {
	    for (Arg arg : args) {
		if (arg.value != null) {
		    if (sb.length() > 0) {
			sb.append("&");
		    }
		    sb.append(URL.encodeComponent(arg.name));
		    sb.append("=");
		    sb.append(URL.encodeComponent(arg.value));
		}
	    }
	}
	return sb.toString();
    }

}