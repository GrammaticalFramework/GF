package org.grammaticalframework.pgf;

import java.io.Serializable;

/** Simply a pair of an expression and a probability value. */
public class ExprProb implements Serializable {
	private static final long serialVersionUID = -3112602244416576742L;

	private Expr expr;
	private double prob;

	public ExprProb(Expr expr, double prob) {
		this.expr = expr;
		this.prob = prob;
	}
	
	@SuppressWarnings("unused")
	private static ExprProb mkExprProb(Pool pool, PGF gr, long expr, double prob) {
		return new ExprProb(new Expr(pool, gr, expr), prob);
	}
	
	/** Returns the expression. */
	public Expr getExpr() {
		return expr;
	}

	/** Returns the negative logarithmic probability. */
	public double getProb() {
		return prob;
	}
}
