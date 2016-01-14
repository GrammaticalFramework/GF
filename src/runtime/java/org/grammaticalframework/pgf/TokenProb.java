package org.grammaticalframework.pgf;

/** Simply a pair of an expression and a probability value. */
public class TokenProb {
	private String tok;
	private double prob;

	public TokenProb(String tok, double prob) {
		this.tok  = tok;
		this.prob = prob;
	}

	/** Returns the token. */
	public String getToken() {
		return tok;
	}

	/** Returns the negative logarithmic probability. */
	public double getProb() {
		return prob;
	}
}
