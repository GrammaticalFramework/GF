package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.http.client.*;

public class JSONRequest {

	private Request httpRequest;

	JSONRequest (Request httpRequest) {
		this.httpRequest = httpRequest;
	}

	public void cancel() {
		if (httpRequest != null) {
			httpRequest.cancel();
		}
	}

}