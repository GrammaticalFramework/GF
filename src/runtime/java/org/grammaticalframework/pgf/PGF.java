package org.grammaticalframework.pgf;

import java.io.*;
import java.util.*;

/** This is the class for PGF grammars.*/
public class PGF {
	/** Reads a grammar with the specified file path.
	 * @param path The path to the file.
	 * @return an object representing the grammar in memory. */
	public static native PGF readPGF(String path) throws FileNotFoundException;

	/** Reads a grammar from an input stream.
	 * @param stream The stream from which to read the grammar
	 * @return an object representing the grammar in memory. */
	public static native PGF readPGF(InputStream stream);

	/** Returns the name of the abstract syntax for the grammar */
	public native String getAbstractName();

	/** Returns a map from a name of a concrete syntax to 
	 * a {@link Concr} object for the syntax. */
	public native Map<String,Concr> getLanguages();

	/** Returns a list of with all categories in the grammar */
	public native List<String> getCategories();
	
	/** The name of the start category for the grammar. This is usually
	 * specified with 'params startcat=&lt;cat&gt;'.
	 */
	public native String getStartCat();
	
	/** Returns a list of with all functions in the grammar. */
	public native List<String> getFunctions();
	
	/** Returns a list of with all functions with a given return category.
	 * @param cat The name of the return category. */
	public native List<String> getFunctionsByCat(String cat);
	
	/** Returns the type of the function with the given name.
	 * @param fun The name of the function.
	 */
	public native Type getFunctionType(String fun);

	/** Returns the negative logarithmic probability of the function
	 * with the given name.
	 * @param fun The name of the function.
	 */
	public native double getFunctionProb(String fun);

	/** Returns an iterable over the set of all expression in
	 * the given category. The expressions are enumerated in decreasing
	 * probability order.
	 */
	public Iterable<ExprProb> generateAll(String startCat) {
		return new Generator(this, startCat);
	}

	/** Normalizes an expression to its normal form by using the 'def'
	 * rules in the grammar.
	 * 
	 * @param expr the original expression.
	 * @return the normalized expression.
	 */
	public native Expr compute(Expr expr);

	/** Takes an expression and returns a refined version
	 * of the expression together with its type */
	public native TypedExpr inferExpr(Expr expr) throws TypeError;

	//////////////////////////////////////////////////////////////////
	// private stuff
	private Pool pool;
	private long ref;

	private PGF(long pool, long ref) {
		this.pool = new Pool(pool);
		this.ref  = ref;
	}
	
	static { 
         System.loadLibrary("jpgf");
    }
}
