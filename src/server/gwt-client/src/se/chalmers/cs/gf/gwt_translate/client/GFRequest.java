package se.chalmers.cs.gf.gwt_translate.client;

import com.google.gwt.http.client.*;

public class GFRequest {

    private Request httpRequest;

    GFRequest (Request httpRequest) {
	this.httpRequest = httpRequest;
    }

    public void cancel() {
	if (httpRequest != null) {
	    httpRequest.cancel();
	}
    }

}