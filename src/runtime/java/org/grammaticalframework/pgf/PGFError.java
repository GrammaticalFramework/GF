package org.grammaticalframework.pgf;

/** This exception is thrown when some grammatical operation fails. */
public class PGFError extends RuntimeException {
	private static final long serialVersionUID = -5098784200043861938L;

	public PGFError(String message) {
		super(message);
	}
}
