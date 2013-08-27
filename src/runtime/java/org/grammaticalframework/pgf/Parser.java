package org.grammaticalframework.pgf;

import java.util.*;

class Parser implements Iterable<ExprProb> {
	private Concr concr;
	private String s;
	private String startCat;

	public Parser(Concr concr, String startCat, String s) {
		this.concr    = concr;
		this.startCat = startCat;
		this.s        = s;
	}

	public Iterator<ExprProb> iterator() {
		ExprIterator iter = parse(concr, startCat, s);
		if (iter == null) {
			throw new PGFError("The sentence cannot be parsed");
		}
		return iter;
	}

	public static native ExprIterator parse(Concr concr, String startCat, String s);
}
