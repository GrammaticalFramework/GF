package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.http.client.Request;
import com.google.gwt.http.client.RequestBuilder;
import com.google.gwt.http.client.RequestCallback;
import com.google.gwt.http.client.RequestException;
import com.google.gwt.http.client.Response;
import com.google.gwt.http.client.URL;

import java.util.List;

public class JSONRequestBuilder {

	public static <T extends JavaScriptObject> JSONRequest sendRequest (String base, List<Arg> vars, final JSONCallback<T> callback) {
		String url = base + "?" + buildQueryString(vars);
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

		return new JSONRequest(request);
	}

	private static native JavaScriptObject eval(String json) /*-{ 
        return eval('(' + json + ')');
    }-*/;

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
