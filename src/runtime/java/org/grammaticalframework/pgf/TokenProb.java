package org.grammaticalframework.pgf;

public class TokenProb {
	private String tok;
	private double prob;

	public TokenProb(String tok, double prob) {
		this.tok  = tok;
		this.prob = prob;
	}

	public String getToken() {
		return tok;
	}

	public double getProb() {
		return prob;
	}
}
