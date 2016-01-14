package org.grammaticalframework.sg;

/** This exception is thrown if an error occurs in the semantic graph.
 */
public class SGError extends RuntimeException {
	private static final long serialVersionUID = -6098784400143861939L;

	public SGError(String message) {
		super(message);
	}
}
