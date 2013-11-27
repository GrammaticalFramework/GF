package org.grammaticalframework.pgf;

public class Type {
	public native String getCategory();
	public native Expr[] getExprs();
	public native Hypo[] getHypos();
	
	//////////////////////////////////////////////////////////////////
	// private stuff
	
	private PGF gr;
	private long ref;
	
	private Type(PGF gr, long ref) {
		this.gr  = gr;
		this.ref = ref;
	}
}
