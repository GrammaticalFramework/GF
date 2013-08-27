package org.grammaticalframework.pgf;

import java.util.*;

public class Concr {

	public native String getName();
	
	public Iterable<ExprProb> parse(String startCat, String s) {
		return new Parser(this, startCat, s);
	}

	//////////////////////////////////////////////////////////////////
	// private stuff
	
	private PGF gr;
	public long concr;

	private Concr(PGF gr, long concr) {
		this.gr    = gr;
		this.concr = concr;
	}
}
