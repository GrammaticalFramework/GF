package se.chalmers.cs.gf.gwt.client;

import com.google.gwt.http.client.*;

public class PGFRequest {

    private Request httpRequest;

    PGFRequest (Request httpRequest) {
	this.httpRequest = httpRequest;
    }

    public void cancel() {
	if (httpRequest != null) {
	    httpRequest.cancel();
	}
    }

}