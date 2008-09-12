package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.http.client.*;
import com.google.gwt.core.client.GWT;

import com.google.gwt.json.client.JSONValue;
import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONParser;

import java.util.Set;
import java.util.Map;
import java.util.HashMap;

public class GF {

    private String baseURL;

    public GF (String baseURL) {
	this.baseURL = baseURL;
    }

    /* Translation */


    /* Completion */

    public void complete (String text, int count, final CompleteCallback callback) {
	Map<String,String> args = new HashMap<String,String>();
	args.put("input",text);
	//	args.put("from",);
	//	args.put("cat",);
	//      args.put("count",);
	sendRequest("complete", args, new JSONRequestCallback() {
		public void onJSONReceived(JSONValue json) {
		    callback.onCompleteDone(new Completions(json));
		}
	    });
    }

    public static final class Completions {
	private final JSONObject completions;
	public Completions (JSONValue json) {
	    this.completions = json.isObject();
	}
	public final Set<String> getCompletionLanguages() { return completions.keySet(); }
	public final int countCompletions(String lang) { 
	    JSONValue cs = completions.get(lang);
	    return cs == null ? 0 : cs.isArray().size(); 
	}
	public final String getCompletion(String lang, int i) { 
	    JSONValue cs = completions.get(lang);
	    return cs == null ? null : cs.isArray().get(i).isString().stringValue(); 
	}
    }

    public interface CompleteCallback {
	public void onCompleteDone (Completions completions);
    }


    /* Utilities */

    public interface JSONRequestCallback {
	public void onJSONReceived(JSONValue json);
    }

    private void sendRequest (String resource, Map<String,String> vars, final JSONRequestCallback callback) {
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
			    GWT.log("Response not OK: " + response.getStatusCode(), null);
			}
		    }
		});
	} catch (RequestException e) {
	    GWT.log("Failed to send request", e);
	}
    }

    private static String buildQueryString(Map<String,String> vars) {
	StringBuffer sb = new StringBuffer();
	for (Map.Entry<String,String> e : vars.entrySet()) {
	    if (sb.length() > 0) {
		sb.append("&");
	    }
	    sb.append(URL.encodeComponent(e.getKey()));
	    sb.append("=");
	    sb.append(URL.encodeComponent(e.getValue()));
	}	
	return sb.toString();
    }

}