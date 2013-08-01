package org.grammaticalframework.pgf;

public class ExprProb {
	private Expr expr;
	private double prob;

	public ExprProb(Expr expr, double prob) {
		this.expr = expr;
		this.prob = prob;
	}
	
	public Expr getExpr() {
		return expr;
	}

	public double getProb() {
		return prob;
	}
}
