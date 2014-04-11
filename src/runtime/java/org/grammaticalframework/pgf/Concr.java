package org.grammaticalframework.pgf;

import java.io.*;
import java.util.*;

public class Concr {

	public native String getName();

	public Iterable<ExprProb> parse(String startCat, String s) throws ParseError {
		return new Parser(this, startCat, s);
	}

	public Expr parseBest(String startCat, String s) throws ParseError {
		Iterator<ExprProb> iter = Parser.parse(this, startCat, s);
		if (iter.hasNext()) {
			return iter.next().getExpr();
		} else {
			return null;
		}
	}

	public Iterable<TokenProb> complete(String startCat, String s, String prefix) throws ParseError {
		return new Completer(this, startCat, s, prefix);
	}

	public native String linearize(Expr expr);

	public native Map<String, String> tabularLinearize(Expr expr);

	public native List<MorphoAnalysis> lookupMorpho(String sentence);

	public Iterable<FullFormEntry> lookupWordPrefix(String prefix) {
		return new Lexicon(this, prefix);
	}

	public native boolean hasLinearization(String id);

	public native void load(String path) throws FileNotFoundException;

	public native void load(InputStream stream);

	public native void unload();

	public native void addLiteral(String cat, LiteralCallback callback);

	//////////////////////////////////////////////////////////////////
	// private stuff
	
	private PGF gr;
	private long ref;

	private Concr(PGF gr, long ref) {
		this.gr  = gr;
		this.ref = ref;
	}
}
