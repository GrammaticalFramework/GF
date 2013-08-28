package org.grammaticalframework.pgf;

import java.util.*;

class Parser implements Iterable<ExprProb> {
	private Concr concr;
	private String s;
	private String startCat;
	private ExprIterator iter;

	public Parser(Concr concr, String startCat, String s) throws ParseError {
		this.concr    = concr;
		this.startCat = startCat;
		this.s        = s;
		this.iter     = parse(concr, startCat, s);
	}

	public Iterator<ExprProb> iterator() {
		if (iter == null) {
			// If someone has asked for a second iterator over
			// the same parse results then we have to parse again.
			try {
				return parse(concr, startCat, s);
			} catch (ParseError e) {
				return null;
			}
		} else {
			ExprIterator tmp_iter = iter;
			iter = null;
			return tmp_iter;
		}
	}

	static native ExprIterator parse(Concr concr, String startCat, String s) throws ParseError;
}
