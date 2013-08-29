package org.grammaticalframework.pgf;

public class ExprProb {
	private Expr expr;
	private double prob;

	public ExprProb(Expr expr, double prob) {
		this.expr = expr;
		this.prob = prob;
	}
	
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
