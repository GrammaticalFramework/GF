package org.grammaticalframework.pgf;

/** Simply a pair of an expression and a probability value. */
public class TokenProb {
	private String tok;
	private String cat;
	private String fun;
	private double prob;

	public TokenProb(double prob, String tok, String cat, String fun) {
		this.prob = prob;
		this.tok  = tok;
		this.cat  = cat;
		this.fun  = fun;
	}

	/** Returns the negative logarithmic probability. */
	public double getProb() {
		return prob;
	}

	/** Returns the token. */
	public String getToken() {
		return tok;
	}

	/** Returns the category from which this word was predicted. */
	public String getCategory() {
		return cat;
	}
	
	/** Returns the function from which this word was predicted. */
	public String getFunction() {
		return fun;
	}
}
