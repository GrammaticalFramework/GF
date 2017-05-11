package org.grammaticalframework.pgf;

public class ExprApplication {
	private String fun;
	private Expr[] arguments;

	public ExprApplication(String fun, Expr[] arguments) {
		this.fun       = fun;
		this.arguments = arguments;
	}
	
	public String getFunction() {
		return fun;
	}
	
	public Expr[] getArguments() {
		return arguments;
	}
}
