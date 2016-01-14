package org.grammaticalframework.pgf;

/** This exception is thrown when parsing a string fails. */
public class ParseError extends Exception {
	private static final long serialVersionUID = -6086991674218306569L;

	public ParseError(String token) {
		super(token);
	}
	
	public String getToken() {
		return getMessage();
	}
}
