package org.grammaticalframework.pgf;

import java.io.Serializable;

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
	
	public Expr getExpr() {
		return expr;
	}

	public double getProb() {
		return prob;
	}
}
