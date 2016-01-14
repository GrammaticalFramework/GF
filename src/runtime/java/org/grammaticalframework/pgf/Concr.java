package org.grammaticalframework.pgf;

import java.io.*;
import java.util.*;

/** The class for concrete syntaxes.*/
public class Concr {

	public native String getName();

	/** Parses a string with a given start category.
	 * @param startCat the start category.
	 * @param s the input string
	 * @return an iterable over all abstract expressions for the input
	 * string. The expressions are enumerated in decreasing probability order.
	 */
	public Iterable<ExprProb> parse(String startCat, String s) throws ParseError {
		return new Parser(this, startCat, s, -1, null);
	}

	/** Parses a string with a given start category and specific
	 * setup of some other parameters.
	 * @param startCat the start category.
	 * @param s the input string
	 * @param heuristics this is a number from 0.0 to 1.0. Zero means
	 * slower parsing but with accurate order of the expressions. 
	 * One means fast but potentially inaccurate ordering of the expressions.
	 * @param callbacks a map which assigns a callback to each literal category
	 * in the grammar. The callbacks can be used to add custom parsing
	 * rules for certain categories.
	 * @return an iterable over all abstract expressions for the input
	 * string. The expressions are enumerated in decreasing probability order.
	 */
	public Iterable<ExprProb> parseWithHeuristics(String startCat, String s, double heuristics, Map<String,LiteralCallback> callbacks) throws ParseError {
		return new Parser(this, startCat, s, heuristics, callbacks);
	}

	public Iterable<TokenProb> complete(String startCat, String s, String prefix) throws ParseError {
		return new Completer(this, startCat, s, prefix);
	}

	/** Computes the linearization of the abstract expression. */
	public native String linearize(Expr expr);

	/** Linearizes the expression as an inflection table.
	 * @return a map from the name of the inflection form to its value.
	 */
	public native Map<String, String> tabularLinearize(Expr expr);

	/** Computes the bracketed string for the linearization of the expression.
	 * @return an array of objects where each element is either a string
	 * or a {@link Bracket} object.
	 */
	public native Object[] bracketedLinearize(Expr expr);

	/** Takes a word form or a multilingual expression and
	 * returns a list of its possible analyses according to the lexicon
	 * in the grammar. This method is doing just lexical lookup 
	 * without parsing.
	 * 
	 * @param sentence the word form or the multilingual expression.
	 */
	public native List<MorphoAnalysis> lookupMorpho(String sentence);

	/** Returns an iterable enumerating all words in the lexicon
	 * starting with a given prefix.
	 * @param prefix the prefix of the word.
	 */
	public Iterable<FullFormEntry> lookupWordPrefix(String prefix) {
		return new Lexicon(this, prefix);
	}

	/** returns true if a given function has linearization in this
	 * concrete syntax.
	 * @param fun the name of the function
	 */
	public native boolean hasLinearization(String fun);

	/** If the concrete syntaxes in the grammar are stored in external
	 * files then this method can be used to load the current syntax
	 * in memory.
	 * @param path the path to the concrete syntax file.
	 */
	public native void load(String path) throws FileNotFoundException;

	/** If the concrete syntaxes in the grammar are stored in external
	 * files then this method can be used to load the current syntax
	 * in memory.
	 * @param stream the stream from which to load the file.
	 */
	public native void load(InputStream stream);

	/** When the syntax is no longer needed then this method can be
	 * used to unload it.
	 */
	public native void unload();

	//////////////////////////////////////////////////////////////////
	// private stuff
	
	private PGF gr;
	private long ref;

	private Concr(PGF gr, long ref) {
		this.gr  = gr;
		this.ref = ref;
	}
}
