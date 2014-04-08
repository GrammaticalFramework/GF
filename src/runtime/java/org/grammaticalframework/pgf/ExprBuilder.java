package org.grammaticalframework.pgf;

public class ExprBuilder {
	public ExprBuilder() {
		
	}

	ExprBuilder(long poolRef) {
	}

	public native Expr mkApp(String fun, Expr... args);

	public native Expr mkLiteral(String s);
	public native Expr mkLiteral(int n);
	public native Expr mkLiteral(double d);
}
