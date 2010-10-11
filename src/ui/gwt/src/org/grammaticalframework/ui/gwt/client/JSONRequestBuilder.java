package org.grammaticalframework.ui.gwt.client;

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.http.client.Request;
import com.google.gwt.http.client.RequestBuilder;
import com.google.gwt.http.client.RequestCallback;
import com.google.gwt.http.client.RequestException;
import com.google.gwt.http.client.Response;
import com.google.gwt.http.client.URL;

import java.util.List;

public class JSONRequestBuilder {

	public static class Arg {
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
	
	public static <T extends JavaScriptObject> JSONRequest sendRequest (String base, List<Arg> vars, final JSONCallback<T> callback) {
		String url = getQueryURL(base,vars);
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
						callback.onResult(JSONRequestBuilder.<T>eval(response.getText()));
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

	public static <T extends JavaScriptObject> JSONRequest sendDataRequest (String base, List<Arg> vars, String content, final JSONCallback<T> callback) {
		String url = getQueryURL(base,vars);
		RequestBuilder builder = new RequestBuilder(RequestBuilder.POST, url);
		builder.setRequestData(content);
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
						callback.onResult(JSONRequestBuilder.<T>eval(response.getText()));
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

	private static native <T extends JavaScriptObject> T eval(String json) /*-{ 
        return eval('(' + json + ')');
    }-*/;

	public static String getQueryURL(String base, List<Arg> args) {
		StringBuffer sb = new StringBuffer();
		sb.append(base);
		sb.append("?");
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
