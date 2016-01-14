package org.grammaticalframework.pgf;

/** A class for types in the abstract syntax of a grammar */
public class Type {
	/** The category */
	public native String getCategory();
	
	/** An array of arguments for the category */
	public native Expr[] getExprs();
	
	/** An array of hypotheses if this is a function type. 
	 * If the represented type is A1 -&gt; A2 -&gt; ... An -&gt; B, then
	 * the hypotheses represent the types in A1, A2 ... An. */
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
