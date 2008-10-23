package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.core.client.JavaScriptObject;

public interface JSONCallback<T extends JavaScriptObject> {
	public void onResult (T result) ;
	public void onError (Throwable e) ;
}
