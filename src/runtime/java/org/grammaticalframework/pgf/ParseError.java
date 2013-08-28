package org.grammaticalframework.pgf;

public class ParseError extends Exception {
	public ParseError(String token) {
		super(token);
	}
	
	public String getToken() {
		return getMessage();
	}
}
