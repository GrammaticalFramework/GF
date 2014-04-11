package org.grammaticalframework.pgf;

import java.util.*;

class Completer implements Iterable<TokenProb> {
	private Concr concr;
	private String s;
	private String prefix;
	private String startCat;
	private TokenIterator iter;

	public Completer(Concr concr, String startCat, String s, String prefix) throws ParseError {
		this.concr    = concr;
		this.startCat = startCat;
		this.s        = s;
		this.prefix   = prefix;
		this.iter     = complete(concr, startCat, s, prefix);
	}

	public Iterator<TokenProb> iterator() {
		if (iter == null) {
			// If someone has asked for a second iterator over
			// the same parse results then we have to parse again.
			try {
				return complete(concr, startCat, s, prefix);
			} catch (ParseError e) {
				return null;
			}
		} else {
			TokenIterator tmp_iter = iter;
			iter = null;
			return tmp_iter;
		}
	}

	static native TokenIterator complete(Concr concr, String startCat, String s, String prefix) throws ParseError;
}
