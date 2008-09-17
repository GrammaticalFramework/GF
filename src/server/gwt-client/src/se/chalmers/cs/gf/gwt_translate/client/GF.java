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

    public static interface GFCallback<T extends JavaScriptObject> {
	public void onResult (T result) ;
	public void onError (Throwable e) ;
    }

    /* Languages */

    public GFRequest languages (final LanguagesCallback callback) {
	return sendRequest("languages", null, callback);
    }

    public interface LanguagesCallback extends GFCallback<Languages> { }

    public static class Languages extends JsArray<Language> {
	protected Languages() { }

	public final Language getLanguage(String name) {
	    int c = length();
	    for (int i = 0; i < c; i++) {
		Language l = get(i);
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

    public GFRequest translate (String input, List<String> fromLangs, String cat, List<String> toLangs, 
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

    public interface TranslateCallback extends GFCallback<Translations> {  }

    public static class Translations extends JsArray<Translation> {
	protected Translations() { }
    }

    public static class Translation extends JavaScriptObject {
	protected Translation() { }

        public final native String getFrom() /*-{ return this.from; }-*/;
        public final native String getTo() /*-{ return this.to; }-*/;
        public final native String getText() /*-{ return this.text; }-*/;
    }

    /* Completion */
    
    public GFRequest complete (String input, List<String> fromLangs, String cat, int limit, final CompleteCallback callback) {
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

    public interface CompleteCallback extends GFCallback<Completions> { }

    public static class Completions extends JsArray<Translation> {
	protected Completions() { }
    }

    public static class Completion extends JavaScriptObject {
	protected Completion() { }

        public final native String getFrom() /*-{ return this.from; }-*/;
        public final native String getText() /*-{ return this.text; }-*/;
    }

    /* Utilities */

    private <T extends JavaScriptObject> GFRequest sendRequest (String resource, List<Arg> vars, final GFCallback<T> callback) {
	String url = baseURL + "/" + resource + "?" + buildQueryString(vars);
	RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
	builder.setTimeoutMillis(30000);
	builder.setHeader("Accept","text/plain, text/html;q=0.5, */*;q=0.1");
	Request request = null;

	try {
	    request = builder.sendRequest(null, new RequestCallback() {
		    public void onError(Request request, Throwable e) {
			callback.onError(e);
		    }
		    
		    public void onResponseReceived(Request request, Response response) {
			if (200 == response.getStatusCode()) {
			    callback.onResult((T)eval(response.getText()).cast());
			} else {
			    RequestException e = new RequestException("Response not OK: " + response.getStatusCode() + ". " + response.getText());
			    callback.onError(e);
			}
		    }
		});
	} catch (RequestException e) {
	    callback.onError(e);
	}

	return new GFRequest(request);
    }

    private static native JavaScriptObject eval(String json) /*-{ 
        return eval('(' + json + ')');
    }-*/;

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